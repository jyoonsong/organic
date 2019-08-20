class ArticlesController < ApplicationController
    before_action :authenticate_user

    def index
        @articles = Article.all
        render 'index'
    end

    def show
        # @article = Article.find(params[:id])
        @article = Article.find(1)
        @direction = "Section 2. Read the article and answer the questions ($0.1 per question). You can stop and finish <strong class='yellow'>anytime</strong> by clicking this button -->"

        @show_next = true

        Log.create(
            :side => "system",
            :kind => "trigger_article",
            :content => params[:id],
            :user_id => current_user.id
        )

        task_id = trigger_task

        if (task_id < 0)
            redirect_to "/articles/1/finish"
        else
            @task = Task.find(task_id)
            render 'show'
        end
    end

    def survey
        # @article = Article.find(params[:id])
        @article = Article.find(1)
        @direction = "Section 1. You must rate all questions to get a fixed payment of $1. It will automatically move on to the next section after you rate all questions."

        all_finished = true

        # TODO: check if all finished

        if (all_finished)
            redirect_to ("/articles/1/finish")
        else
            Log.create(
                :side => "system",
                :kind => "trigger_survey",
                :content => params[:id],
                :user_id => current_user.id
            )
            render 'survey'
        end
    end

    def skip_answer
        task_id = params[:task_id]

        @answer = Answer.create(
            :article_id => 1,
            :task_id => task_id,
            :user_id => current_user.id,
            :highlight => ""
        )

        task_id = trigger_task
        @task = Task.find(task_id)

        respond_to do |format|
            format.js { render :layout => false }
        end
    end

    def create_answer 
        # calculate duration time
        time = (Time.now.to_f * 1000).to_i - params[:time].to_i

        # create answer
        article_id = 1
        task_id = params[:task_id]
        @current_task = Task.find(task_id)
        
        highlight = true

        # handle multiple choice answer
        if (params[:multiple].nil?)
            value = params[:answer_value]

            if (@current_task.highlights_arr.include?(value.to_i))
                highlight = false
            end
        else
            value = ""
            params[:answer_values].each_with_index do |a, i|
                value += a

                if (i != params[:answer_values].length - 1)
                    value += ","
                end
                if (highlight && @current_task.highlights_arr.include?(a.to_i))
                    highlight = false
                end
            end
        end

        @answer = Answer.new(
            :user_id => current_user.id,
            :article_id => article_id,
            :task_id => task_id,
            :value => value,
            :time => time
        )

        if (@answer.save)

            # update the consensus of the task
            consensus = @current_task.calculate_consensus
            
            @current_task.update(
                :consensus => consensus
            )
        
            # set current task
            if (!highlight)
                @answer.update(
                    :highlight => ""
                )
                task_id = trigger_task
                @task = Task.find(task_id)
            end

            @highlight = highlight

            respond_to do |format|
                format.js { render :layout => false }
            end

        end
    end

    def create_highlight
        @answer = Answer.find(params[:answer_id])
        @answer.update(
            :highlight => params[:answer_value]
        )
        
        task_id = trigger_task
        @task = Task.find(task_id)

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
        if current_answers.length >= Task.all.length
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
            redirect_to "/wrong"
        else
            render 'finish'
        end
    end

    private

    def trigger_task

        if (@current_task.nil?)
            if (!session[:task_id].nil?)
                @current_task = Task.find(session[:task_id])
            end
        end

        if (!@current_task.nil?)
            current_answer = Answer.find_by(user_id: current_user.id, task_id: @current_task.id)
            if (current_answer.nil? || current_answer.highlight.nil?)
                return @current_task.id
            end
        end

        max = 0
        maxId = -1

        puts "====== start"
        # calculate next task
        Task.all.each do |t|
            puts "********CHECKING " + t.id.to_s
            # check if already done by this user
            answers = Answer.find_by(user_id: current_user.id, task_id: t.id)

            @log = Log.new(
                :side => "system",
                :kind => "calculate_task",
                :user_id => current_user.id
            )

            # check sequencing constraints
            if (t.constraints_satisfied?(current_user) && answers.nil?)
                # calculate marginal information gain
                current = t.marginal_information_gain
                if (current > max)
                    puts "* marginal information gain is larger than " + max.to_s
                    max = current
                    maxId = t.id
                    
                elsif (current == max)
                    puts "* marginal information gain is same with " + max.to_s
                    # first consider chained questions
                    if (@current_task.nil?)
                        maxId = 1
                    elsif (@current_task.constraints_priority(t.id, maxId))
                        puts "* priority or current task nil"
                        max = current
                        maxId = t.id
                    end
                end
                
                @log.update(
                    :content => "task no. " + t.id.to_s + ": " + current.to_s + " marginal_information_gain (" + t.answers_count.to_s + ")",
                )
            else
                @log.update(
                    :content => "task no. " + t.id.to_s + ": constraints not satisfied",
                )
            end
        end


        # if not found, redirect to survey
        if (max == 0 || maxId < 0)
            return -1
        end

        # if found, set this as current task and show gold task
        session[:task_id] = maxId


        # create log
        Log.create(
            :side => "system",
            :kind => "trigger_task",
            :content => "trigger task no. " + maxId.to_s + " with " + max.to_s + " marginal_information_gain",
            :user_id => current_user.id
        )

        return maxId
    end

    def authenticate_user
        if (current_user.nil?)
            redirect_to "/wrong"
        end
    end
    
end
