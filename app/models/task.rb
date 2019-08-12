class Task < ApplicationRecord
    has_many :answers

    def marginal_information_gain
        # in terms of quantity
        gain1 = 5 - self[:answers].length

        # in terms of consensus
        gain2 = (0.6 - self[:consensus]) / 0.12

        # total
        if (gain1 <= 0 && gain2 <= 0)
            return 0
        else
            return gain1 + gain2 # TODO: how to calculate this?
    end

    def constraints_satisfied?
        self[:constraints].split(/\s*,\s*/).each do |c|
            if (!current_user.answers.where({task_id: c.to_i}).exists?)
                return false
            end    
        end
        
        return true
    end
end
