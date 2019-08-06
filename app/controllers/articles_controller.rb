class ArticlesController < ApplicationController
    before_action :authenticate_user

    def index
        @articles = Article.all
        @direction = "Step 1. Choose an article"
        render 'index'
    end

    def show
        @article = Article.find(params[:id])
        @tasks = Task.all
        @direction = "Step 2. Feel free to use our system for 10 minutes. Just make sure to read the article."

        @show_next = params[:id]

        render 'show'
    end

    def survey
        @article = Article.find(params[:id])
        @tasks = Task.all
        @direction = "Step 3. Now make sure to answer all questions."

        render 'survey'
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

    def survey_answer
        answer_id = params[:answer_id]
        answer = Answer.find(answer_id)
        
        answer.update(
            :preference => params[:preference],
            :preference_reason => params[:reason],
            :finished => true
        )

        current_answers = current_user.answers.where({article_id: answer.article_id, finished: true})
        if current_answers.length == Task.all.length
            redirect_to ("/articles/" + answer.article_id.to_s + "/finish")
        else
            respond_to do |format|
                format.js { render :layout => false }
            end
        end
        
    end

    def finish
        current_answers = current_user.answers.where({article_id: params[:id], finished: true})
        if (current_answers.length < Task.all.length)
            redirect_to "/articles"
        end

        render 'finish'
    end

    private

    def authenticate_user
        if (current_user.nil?)
            redirect_to "/wrong"
        end
    end
    
end
