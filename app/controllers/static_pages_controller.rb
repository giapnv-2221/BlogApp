class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @entry = current_user.entries.build
     # page = params[:page]? params[:page] : 1
      @feed_items = current_user.feed.recent.
        page(params[:page]).per Settings.entries_blog.paging.num_per_page
    else
      @feed_items = Entry.select_list.recent.page(params[:page]).per 5
    end
  end
end
