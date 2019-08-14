class SessionsController < ApplicationController

    def new 
        @user = User.find_by(key: params[:workerId])
        if (!@user.nil?)
            session[:user_id] = @user.id
            redirect_to "/articles/1/"
        elsif (params[:workerId].nil?)
            redirect_to "/wrong"
        else
            @user = User.new
        end
    end
    
    def create

        @user = User.new(name: params[:name], key: params[:key])
        if @user.save
            session[:user_id] = @user.id
            redirect_to "/articles/1/"
        else
            render "new"
        end

    end

end
