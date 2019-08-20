class SurveyAnswersController < ApplicationController

    def export
        @answers = SurveyAnswer.all

        respond_to do |format|
            format.html
            format.csv { send_data @answers.to_csv }
            # format.xls { send_data @logs.to_csv(col_sep: "\t") }
        end
    end
    
end
