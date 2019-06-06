class RelationshipsController < ApplicationController
  def create
    @user = User.find_by id: params[:followed_id]
    if @user
      current_user.follow(@user)
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    else
      flash[:danger] = "Something error!"
      redirect_to request.referer || root_path
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
