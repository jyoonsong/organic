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
                puts "* constraint not satisfied for "
                puts c.to_s + " needs to be done"
                return false
            end
        end

        return true
    end

    def constraints_priority(anew, curr)

        priority_anew = Task.find(anew).constraints_arr.index(self.id)
        priority_curr = Task.find(curr).constraints_arr.index(self.id)

        puts "** priority of this task = " + priority_anew.to_s
        puts "** priority of current max = " + priority_curr.to_s

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

    def calculate_consensus
        everything = []
        if (self.answers.length > 1)
            
            self.answers.each do |a|
                everything += a.value_array
            end

            puts "*+*+* === calculate consensus"
            puts everything

            # nominal
            if (self[:character] == "nominal")
                # index of qualitative variation
                return iqv(everything)
                
            # ordinal
            else
                # normalized standard deviation
                return coefficient_variance(everything)
            end

        else
            return 1
        end
    end

    private

    def iqv(arr)
        # length
        n = arr.length

        # frequency array
        hash = frequency(arr)

        # sum of frequency & sum of squared frequency
        sum = 0
        sum_sqrt = 0
        hash.each { |key, v| 
            sum += v 
            sum_sqrt += v**2
        }

        return ( n * (sum - sum_sqrt) ) / ( sum**2 * (n - 1) )
    end

    def frequency(arr)
        hash = Hash.new(0)
        arr.each{|key| hash[key] += 1}
        return hash
    end

    def coefficient_variance(arr)
        # sum
        sum = arr.inject(0){ |accum, i| accum + i }

        # mean
        mean = sum / arr.length.to_f

        # variance
        sum_sqrt = arr.inject(0){ |accum, i| accum + (i - mean)**2 }
        variance = sum_sqrt / (arr.length - 1).to_f

        return (Math.sqrt(variance) / mean)
    end

end
