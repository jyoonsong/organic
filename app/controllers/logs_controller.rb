class LogsController < ApplicationController

    def export
        @logs = Log.all

        respond_to do |format|
        format.html
        format.csv { send_data @logs.to_csv }
        format.xls # { send_data @products.to_csv(col_sep: "\t") }
    end

end
