class User < ApplicationRecord
  attr_accessor :remember_token

  before_save :downcase_email

  has_many :entries, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id",dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /[A-Z][a-z]\d/i

  validates :name, presence: true,
    length: {minimum: Settings.users.name.min_length,
      maximum: Settings.users.name.max_length}
  validates :email, presence:true,
    length: {maximum: Settings.users.email.max_length},
      format: {with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password, presence:true, length:
    {minimum: Settings.users.password.min_length,
      maximum: Settings.users.password.max_length},
        format: {with: VALID_PASSWORD_REGEX}, allow_nil: true
  has_secure_password

  scope :get_list, ->{select("id,name,email")}
  scope :recent, ->{ order(created_at: :DESC) }

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false  unless digest
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def was? obj
    self == obj
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
      WHERE  follower_id = :user_id"
    Entry.where("user_id IN (#{following_ids}) OR user_id= :user_id", user_id:id)
  end

  def follow other_user
    return unless other_user
    following << other_user
  end

  def unfollow other_user
    return unless  other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  def active_follow user_id
    self.active_relationships.find_by(followed_id: user_id)
  end
  private
  def downcase_email
    email.downcase!
  end

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ?
        BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
