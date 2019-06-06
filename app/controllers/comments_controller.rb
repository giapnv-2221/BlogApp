class CommentsController < ApplicationController
  before_action :logged_in_user, only: %i(create)

  def create
    @comment = current_user.comments.build comment_params
    @comment.entry_id = params[:entry_id]
    unless @comment.save
      flash[:danger] = t "users.alert.error"
      redirect_to root_url
    end
    @comments = Comment.where(params[:entry_id]).
      recent.page(params[:page]).per 5
    respond_to do |format|
      format.html { redirect_to entry_path(params[:entry_id]) }
      format.js
    end
  end

  def destroy
  end

  def comment_params
    params.require(:comment).permit :content
  end
end
