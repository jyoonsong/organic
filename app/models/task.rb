class Task < ApplicationRecord
    has_many :answers

    def marginal_information_gain
        # in terms of quantity
        gain1 = 5 - self.answers.length

        # in terms of consensus
        gain2 = (0.6 - self[:consensus]) / 0.6

        # total
        if (gain1 <= 0 && gain2 <= 0)
            return 0
        end
        
        return gain1 + gain2 # TODO: how to calculate this?
    end

    def constraints_satisfied?(current_user)
        constraints_arr.each do |c|
            if (!current_user.answers.where({task_id: c.to_i}).exists?)
                puts "******"
                puts c
                return false
            end
        end

        return true
    end

    def constraints_priority(anew, curr)
        priority_anew = constraints_arr.index(anew)
        priority_curr = constraints_arr.index(curr)

        if (!priority_anew.nil?)
            if (priority_curr.nil? || priority_anew < priority_curr)
                return true
            end
        end

        return false

    end
    
    def constraints_arr
        if (!self[:constraints].nil?)
            return self[:constraints].split(/\s*,\s*/).map!{ |c| c.to_i }
        end

        return []
    end

    def highlights_arr
        if (!self[:highlights].nil?)
            return self[:highlights].split(/\s*,\s*/).map!{ |c| c.to_i }
        end

        return []
    end

end
