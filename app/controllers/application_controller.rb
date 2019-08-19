class ApplicationController < ActionController::Base

    protect_from_forgery
    helper_method :current_user, :current_task

    def wrong
        render 'wrong'
    end

    def export
        if (current_user.name != "admin")
            render 'wrong'
        end
    end


    private
    def current_user
        @_current_user ||= session[:user_id] && User.find(session[:user_id])
    end

    def current_task
        @_current_task ||= session[:task_id] && Task.find(session[:task_id])
    end
end
