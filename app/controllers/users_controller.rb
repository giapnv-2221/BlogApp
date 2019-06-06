class UsersController < ApplicationController
  before_action :correct_user, except: %i(index new create)

  def index
    @users = User.get_list.recent.page(params[:page]).per Settings.users.paging.num_per_page
  end

  def show
    @user = User.find_by id: params[:id]
    @entries = @user.entries.recent.
      page(params[:page]).per Settings.entries_blog.paging.num_per_page

    redirect_to root_path unless @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit;  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.edit.success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:danger] = t "users.alert.deleted"
    else
      flash[:danger] = t "users.alert.error"
    end
    redirect_to users_path
  end

  def following
    @title = "Following"
    @user  = User.find_by id: params[:id]
    if @user
      @users = @user.following.page(params[:page]).per Settings.users.paging.num_per_page
      render "show_follow"
    else
      redirect_to user_path
    end
  end

  def followers
    @title = "Followers"
    @user  = User.find_by id: params[:id]
    @users = @user.followers.page(params[:page]).per Settings.users.paging.num_per_page
    render "show_follow"
  end

  private
  def user_params
    params.require(:user).
      permit :name,:email,:password,:password_confirmation
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_path unless @user
  end
end
