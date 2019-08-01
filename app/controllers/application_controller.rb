class ApplicationController < ActionController::Base

    protect_from_forgery
    helper_method :current_user

    private
    def current_user
        @_current_user ||= session[:user_id] && User.find(session[:user_id])
    end
end
