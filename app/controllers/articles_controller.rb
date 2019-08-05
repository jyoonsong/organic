class ArticlesController < ApplicationController
    before_action :authenticate_user

    def index
        @articles = Article.all
        @direction = "Choose an article"
        render 'index'
    end

    def show
        @article = Article.find(params[:id])
        @tasks = Task.all
        @direction = "Feel free to use our system for 10 minutes. Just make sure to read the article."
        render 'show'
    end

    def create_answer 
        article_id = params[:id]
        task_id = 

        Answer.create(
            :user_id => current_user.id,
            :article_id => 
        )
    end

    private

    def authenticate_user
        if (current_user.nil?)
            redirect_to "/wrong"
        end
    end
    
end
