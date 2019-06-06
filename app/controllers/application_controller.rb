class ApplicationController < ActionController::Base
  include SessionsHelper

  def logged_in_user
    return if  logged_in?
    store_location
    flash[:danger] = t "users.alert.login"
    redirect_to login_path
  end
end
