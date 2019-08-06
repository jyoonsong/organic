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
        # calculate duration time
        time = (Time.now.to_f * 1000).to_i - params[:time].to_i

        article_id = params[:id]
        task_id = params[:task_id]

        @answer = Answer.create(
            :user_id => current_user.id,
            :article_id => article_id,
            :task_id => task_id,
            :value => params[:answer_value],
            :time => time
        )

        respond_to do |format|
            format.js { render :layout => false, locals: {survey: params[:survey]} }
        end
    end

    def update_answer 
        # calculate duration time
        time = (Time.now.to_f * 1000).to_i - params[:time].to_i

        answer_id = params[:answer_id]
        answer = Answer.find(answer_id)
        
        answer.update(
            :value => params[:answer_value],
            :time => time
        )

        respond_to do |format|
            format.js { render :layout => false, locals: {answer: answer} }
        end
    end

    private

    def authenticate_user
        if (current_user.nil?)
            redirect_to "/wrong"
        end
    end
    
end
