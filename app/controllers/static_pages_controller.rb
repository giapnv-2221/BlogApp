class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @entry = current_user.entries.build
      @feed_items = current_user.feed.recent.
        page(params[:page]).per Settings.entries_blog.paging.num_per_page
    else
      @feed_items = Entry.select_list.recent.
        page(params[:page]).per Settings.entries_blog.paging.num_per_page
    end
  end
end
