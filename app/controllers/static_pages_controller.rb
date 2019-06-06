class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @entry = current_user.entries.build
   # page = params[:page]? params[:page] : 1
    @feed_items = current_user.feed.recent.
      page(params[:page]).per Settings.entries_blog.paging.num_per_page
  end
end
