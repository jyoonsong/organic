class TasksController < ApplicationController

    def export
        @tasks = Task.all

        respond_to do |format|
            format.html
            format.csv { send_data @tasks.to_csv }
            # format.xls { send_data @logs.to_csv(col_sep: "\t") }
        end
    end
end
