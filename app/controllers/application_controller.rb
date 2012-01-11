class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  
  def login_required
    unless current_user
      redirect_to login_url, :notice => "You must be logged in for this action"
    end
  end
  
  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
