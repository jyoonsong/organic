class ArticlesController < ApplicationController
    before_action :authenticate_user

    def index
        @articles = Article.all
        render 'index'
    end

    def show
        # @article = Article.find(params[:id])
        @article = Article.find(1)
        @tasks = Task.all
        @direction = "Read the article and answer the tasks. You will be given $0.1 per task."

        @show_next = true

        Log.create(
            :side => "system",
            :kind => "trigger_article",
            :content => params[:id],
            :user_id => current_user.id
        )

        trigger_task

        render 'show'
    end

    def survey
        # @article = Article.find(params[:id])
        @article = Article.find(1)
        @direction = "After you answer all questions on the right, you can finish."

        Log.create(
            :side => "system",
            :kind => "trigger_survey",
            :content => params[:id],
            :user_id => current_user.id
        )

        render 'survey'
    end

    def create_answer 
        # calculate duration time
        time = (Time.now.to_f * 1000).to_i - params[:time].to_i

        # create answer
        article_id = 1
        task_id = params[:task_id]
        @task = Task.find(task_id)
        
        highlight = false

        if (params[:multiple].nil?)
            value = params[:answer_value]
            if (@task.highlights_arr.include?(value))
                highlight = true
            end
        else
            value = ""
            params[:answer_values].each_with_index do |a, i|
                value += a
                if (!highlight && @task.highlights_arr.include?(value))
                    highlight = true
                end
                if (i != params[:answer_values].length - 1)
                    value += ","
                end
            end
        end

        @answer = Answer.create(
            :user_id => current_user.id,
            :article_id => article_id,
            :task_id => task_id,
            :value => value,
            :time => time
        )

        # update the consensus of the task
        m = []
        @task.answers.each do |a|
            m.push(a.value_array)
        end

        matrix = Matrix[m]
        consensus = matrix.krippendorff_alpha

        @task.update(
            :consensus => consensus
        )

        # set current task
        if (!highlight)
            trigger_task
        end

        respond_to do |format|
            format.js { render :layout => false, locals: {highlight: highlight, answer_id: @answer.id} }
        end
    end

    def create_highlight
        @answer = Answer.find(params[:answer_id])
        @answer.update(
            :highlight => params[:answer_value]
        )
        
        trigger_task

        respond_to do |format|
            format.js { render :layout => false }
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

    def trigger_task
        
        max = 0
        maxId = -1

        # calculate next task
        Task.all.reverse_each do |t|
            # check if already done by this user
            answers = Answer.find_by(user_id: current_user.id, task_id: t.id)

            # check sequencing constraints
            if (t.constraints_satisfied?(current_user) && answers.nil?)

                # calculate marginal information gain
                current = t.marginal_information_gain
                
                if (current > max)
                    max = current
                    maxId = t.id
                elsif (current == max)
                    # first consider chained questions
                    if (current_task.nil? || current_task.constraints_priority(t.id, maxId))
                        max = current
                        maxId = t.id
                    end
                end

            end
        end

        # if not found, finish
        if (max == 0 || maxId < 0)
            redirect_to "/finish"
        end

        # if found, set this as current task and show gold task
        session[:task_id] = maxId
    end

    def authenticate_user
        if (current_user.nil?)
            redirect_to "/wrong"
        end
    end
    
end
