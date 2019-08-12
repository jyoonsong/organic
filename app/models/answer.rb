class Answer < ApplicationRecord
    belongs_to :user
    belongs_to :article
    
    belongs_to :task

    def value_array
        if (!self[:value].nil?)
            return self[:value].split(/\s*,\s*/).map!{ |v| v.to_i }
        end

        return []
    end
end
