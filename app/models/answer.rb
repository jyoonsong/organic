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

    def fixed_array(size, other)  
        Array.new(size) { |i| other[i] }
    end

    def self.answers_by(user_id) 
        return self.where(user_id: user_id).where.not({value: nil})
    end
end
