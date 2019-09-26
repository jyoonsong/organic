class ArticlesController < ApplicationController
    before_action :authenticate_user

    def index
        @articles = Article.all
        render 'index'
    end

    #
    # 3 views - survey, show, post_survey
    #

    def show
        # pre survey를 끝내지 못한 경우 pre survey로 redirect
        if (!Surveyanswer.pre_done?(current_user.id))
            redirect_to "/articles/1/survey"

        # tasks를 이미 끝낸 유저의 경우 post survey로 redirect
        elsif (!current_user.passed.nil?)
            redirect_to "/articles/1/post_survey"

        # 다른 유저들은 task 시작
        else
            # @article = Article.find(params[:id])
            @article = Article.find(1)
            @direction = "Section 2. Read the article (required) and answer the questions (optional)."
            @show_next = true

            Log.create(
                :side => "system",
                :kind => "trigger_article",
                :content => params[:id],
                :user_id => current_user.id
            )

            # 유저에게 보여줄 task를 탐색
            task_id = trigger_task

            # 탐색 결과 적절한 것이 없는 경우 post survey로 redirect
            if (task_id < 0)
                redirect_to "/articles/1/post_survey"
            # 탐색 결과 적절한 것이 없는 경우 해당 task 보여주기
            else
                @task = Task.find(task_id)
                render 'show'
            end
        end
    end

    def survey
        # @article = Article.find(params[:id])
        @direction = "Section 1. You must answer all questions. Then, it will automatically move on to the next section."
        
        # check if all finished
        if (Surveyanswer.pre_done?(current_user.id))
            redirect_to ("/articles/1/")
        else
            Log.create(
                :side => "system",
                :kind => "trigger_pre_survey",
                :content => params[:id],
                :user_id => current_user.id
            )
            render 'survey'
        end
    end

    def post_survey
        # @article = Article.find(params[:id])
        @direction = "Section 3. You must answer all questions. Then, it will automatically finish."
        
        # check if all finished
        if (Surveyanswer.done?(current_user.id))
            redirect_to ("/articles/1/finish/")
        elsif (!Surveyanswer.pre_done?(current_user.id))
            redirect_to ("/articles/1/survey/")
        else
            current_user.update(
                :passed => true
            )
            Log.create(
                :side => "system",
                :kind => "trigger_post_survey",
                :content => params[:id],
                :user_id => current_user.id
            )
            render 'post_survey'
        end
    end

    #
    # actions for "show"
    #

    def skip_answer
        task_id = params[:task_id]

        @answer = Answer.create(
            :article_id => 1,
            :task_id => task_id,
            :user_id => current_user.id,
            :highlight => ""
        )

        task_id = trigger_task
        if (task_id < 0)
            redirect_to "/articles/1/post_survey"
        else
            @task = Task.find(task_id)
            respond_to do |format|
                format.js { render :layout => false }
            end
        end
    end

    def create_answer 
        # calculate duration time
        time = (Time.now.to_f * 1000).to_i - params[:time].to_i

        # create answer
        article_id = 1
        task_id = params[:task_id]
        @current_task = Task.find(task_id)
        
        highlight = 0

        # handle multiple choice answer
        if (params[:multiple].nil?)
            value = params[:answer_value]

            if (task_id.to_i == 7)
                highlight = (value.to_i - 1)
            elsif (!@current_task.highlights_arr.include?(value.to_i))
                highlight = 1
            end
        else
            value = ""
            params[:answer_values].each_with_index do |a, i|
                value += a

                if (i != params[:answer_values].length - 1)
                    value += ","
                end

                if (!@current_task.highlights_arr.include?(a.to_i))
                    highlight += 1
                end
            end
        end

        # see if answer already exists just in case
        answer = Answer.find_by(user_id: current_user.id, task_id: task_id)

        if (answer.nil?)
            @answer = Answer.create(
                :user_id => current_user.id,
                :article_id => article_id,
                :task_id => task_id,
                :value => value,
                :time => time
            )
        else
            answer.update(
                :value => value,
                :time => time
            )
            @answer = answer
        end

        # save input for 'other' option
        if (!params[:other].nil?)
            @answer.update(
                :other => params[:other]
            )
        end

        # update the consensus of the task
        consensus = @current_task.calculate_consensus
        
        @current_task.update(
            :consensus => consensus
        )
    
        # set current task
        if (highlight == 0)
            @answer.update(
                :highlight => ""
            )
            task_id = trigger_task

            if (task_id < 0)
                redirect_to "/articles/1/post_survey"
            else
                @task = Task.find(task_id)
                respond_to do |format|
                    format.js { render :layout => false, locals: {highlight: highlight} }
                end
            end
        else
            respond_to do |format|
                format.js { render :layout => false, locals: {highlight: highlight} }
            end
        end

    end

    def create_highlight
        @answer = Answer.find(params[:answer_id])
        updated = @answer.update_highlights(params[:answer_value])
        @answer.update(
            :highlight => updated
        )

        if (@answer.task_id == 7)
            goal = @answer.value.to_i * 3
        else
            goal = @answer.value_with_highlight * 3
        end
        
        if (goal <= @answer.highlights_arr.length)
            task_id = trigger_task
            if (task_id < 0)
                redirect_to "/articles/1/post_survey"
            else
                @task = Task.find(task_id)
                respond_to do |format|
                    format.js { render :layout => false }
                end
            end
        else
            respond_to do |format|
                format.js { render :layout => false }
            end
        end
        
    end

    def update_answer 
        # calculate duration time
        time = (Time.now.to_f * 1000).to_i - params[:time].to_i

        answer_id = params[:answer_id]
        answer = Answer.find(answer_id)
        
        # check if highlight number has to change
        highlight = 0
        @current_task = Task.find(answer.task_id)

        # handle multiple choice answer
        if (params[:multiple].nil?)
            value = params[:answer_value]

            if (@current_task.id == 7)
                highlight = (value.to_i - 1)
            elsif (!@current_task.highlights_arr.include?(value.to_i))
                highlight = 1
            end
        else
            value = ""
            params[:answer_values].each_with_index do |a, i|
                value += a

                if (i != params[:answer_values].length - 1)
                    value += ","
                end

                if (!@current_task.highlights_arr.include?(a.to_i))
                    highlight += 1
                end
            end
        end

        answer.update(
            :value => value,
            :time => time
        )

        # save input for 'other' option
        if (!params[:other].nil?)
            answer.update(
                :other => params[:other]
            )
        end

        if (highlight > 0)
            respond_to do |format|
                format.js { render :layout => false, locals: {answer: answer, highlight: highlight} }
            end
        else
            answer.update(
                :highlight => ""
            )
            redirect_to "/articles/1"
        end
    end

    #
    # actions for "survey" and "post_survey"
    #

    def survey_answer

        # if answer is nil reload
        if (params[:answer_value].nil? && params[:answer_values].nil? && ( params[:motivation].nil? || params[:motivation].length < 40 ) )
            respond_to do |format|
                format.js {render inline: "location.reload();" }
            end

        # else
        else

            ##
            ## 1. handle multiple choice answer
            ##
            if (!params[:motivation].nil?)
                value = params[:motivation]
            elsif (params[:multiple].nil?)
                value = params[:answer_value]
            else
                value = ""
                params[:answer_values].each_with_index do |a, i|
                    value += a

                    if (i != params[:answer_values].length - 1)
                        value += ","
                    end
                end

            end

            ##
            ## 2. check if user's answer is correct
            ##

            survey_task = Surveytask.find(params[:task_id])

            # only when the given surveytask is "gold task" or "content" question
            if (survey_task.classification == "gold task")
                if (survey_task.answer != value.to_i) # if wrong
                    new_capability = current_user.update_capability(survey_task.task_id)
                    current_user.update(
                        :capability => new_capability # add it to capability column
                    )
                end
            elsif (survey_task.classification == "content")
                if (survey_task.answer != value.to_i) # if wrong
                    current_user.update(
                        :passed => false # set passed as false
                    )
                end
            end

            ##
            ## 3. save the answer as a new surveyanswer instance
            ##
            Surveyanswer.create(
                :value => value,
                :value_reason => params[:reason],
                :surveytask_id => params[:task_id],
                :user_id => current_user.id
            )

            ##
            ## 4. where to redirect to?
            ##

            # if user is done with both surveys, redirect to finish page
            if (Surveyanswer.done?(current_user.id))
                redirect_to ("/articles/1/finish")

            # if user is done with pre survey but not the main tasks, redirect to "show" page 
            elsif (current_user.passed.nil? && Surveyanswer.pre_done?(current_user.id))
                redirect_to ("/articles/1") # TODO: if multiple article, get id
            
            # if user needs to continue, call "survey_answer.js.erb"
            else
                respond_to do |format|
                    format.js { render :layout => false }
                end
            end

        end
        
    end

    #
    # global
    #

    def finish
        render 'finish'
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

        # calculate next task
        Task.all.each do |t|
            # check if already done by this user
            answers = Answer.find_by(user_id: current_user.id, task_id: t.id)

            @log = Log.new(
                :side => "system",
                :kind => "calculate_task",
                :user_id => current_user.id
            )

            # check sequencing constraints & gold task
            if(!answers.nil?)
                @log.update(
                    :content => "task no. " + t.id.to_s + ": already done or skipped",
                )
            elsif (current_user.capability_arr.include?(t.id))
                @log.update(
                    :content => "task no. " + t.id.to_s + ": gold task failed"
                )
            elsif (!t.constraints_satisfied?(current_user))
                @log.update(
                    :content => "task no. " + t.id.to_s + ": constraints not satisfied",
                )
            else
                # calculate marginal information gain
                current = t.marginal_information_gain
                if (current > max)
                    max = current
                    maxId = t.id
                    
                elsif (current == max)
                    # first consider chained questions
                    
                    if (@current_task.nil?)
                        maxId = 1
                    elsif (@current_task.constraints_priority(t.id, maxId))
                        max = current
                        maxId = t.id
                    end
                end
                
                @log.update(
                    :content => "task no. " + t.id.to_s + ": " + current.to_s + " marginal_information_gain (" + t.answers_count.to_s + ")",
                )
            end
        end


        # if not found, redirect to survey
        if (maxId < 0)
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
