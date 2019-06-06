class EntriesController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user , only: %i(destroy)

  def show
    store_location
    @entry = Entry.find_by id: params[:id]
    @comments = @entry.comments.recent.page(params[:page]).per 5
    @comment = Comment.new
    respond_to do |format|
      format.html { redirect_to root_url unless @entry }
      format.js
    end
  end

  def create
    @entry = current_user.entries.build entry_params
    if @entry.save
      flash[:success] = t "users.alert.success"
      redirect_to root_path
    else
      @feed_items =[]
      render "static_pages/home"
    end
  end

  def delete
    if @entry.destroy
      flash[:warning] = t "microposts.destroy_post"
      redirect_to request.referer || root_path
    else
      flash[:danger] = t "users.alert.error"
      redirect_to root_path
    end
  end

  private
  def entry_params
    params.require(:entry).permit :title,:content
  end

  def correct_user
    @entry = current_user.entries.find_by id: params[:id]
    redirect_to root_path unless @entry
  end
end
