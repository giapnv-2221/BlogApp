class CommentsController < ApplicationController
  before_action :logged_in_user, only: %i(create)



  def create
    @comment = current_user.comments.build comment_params
    @comment.entry_id = params[:entry_id]
    unless @comment.save
      flash[:danger] = t "users.alert.error"
      redirect_to root_url
    end
    @entry = Entry.find_by id: params[:entry_id]
    return unless @entry
    @comments = @entry.comments.
      recent.page(params[:page]).per 5
    respond_to do |format|
      format.html { redirect_to entry_path(@entry) }
      format.js
    end
  end

  def destroy
  end

  def comment_params
    params.require(:comment).permit :content
  end
end
