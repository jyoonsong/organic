class Surveytask < ApplicationRecord
    has_many :surveyanswers
    belongs_to :task, optional: true

    def options_arr
        if (!self[:options].nil?)
            return self[:options].split('/').map!{ |c| c.squish }
        end

        return []
    end
end
