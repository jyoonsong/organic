class Task < ApplicationRecord
    has_many :answers
    has_many :surveytasks

    def marginal_information_gain
        # in terms of quantity
        gain1 = 500 - self.answers_count

        # in terms of consensus
        gain2 = 1 - self[:consensus]
        
        # total
        if (gain1 <= 0 && gain2 <= 0)
            return 0
        end
        
        return gain1 + gain2 # TODO: how to calculate this?
    end

    def answers_count
        return self.answers.where.not({value: nil}).length
    end

    def credibility_score(current_user)
        credibility = [50.00, 70.81, 71.57, 69.09, 65.86, 62.93, 59.32, 49.20, 43.89, 36.60, 43.16, 38.30, 41.61, 42.06, 43.21, 42.55, 43.29, 40.27, 36.77, 35.61, 35.55, 39.27]
        return credibility[Answer.answers_by(current_user.id).length]
    end

    def potential_credibility_score(current_user)
        potential_cred = [24.05, 9.58, 10.54, 4.46, 3.25, 14.00, 10.16, 6.25, 13.47, 7.13, 5.53, 3.49, 0.80, 2.84, 8.91, 2.50, 5.45, 6.43, 2.38, 5.40, 4.88]
        return potential_cred[Answer.answers_by(current_user.id).length]
    end

    def constraints_satisfied?(current_user)
        constraints_arr.each do |c|
            answers = current_user.answers.where({task_id: c.to_i})
            if (!answers.exists? || answers.first.value.nil? || answers.first.value.length < 1)
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

    def options_arr
        if (!self[:options].nil?)
            return self[:options].split(/\s*,\s*/).map!{ |c| c }
        end

        return []
    end

    def calculate_consensus
        everything = []
        if (self.answers_count > 1)
            
            n = options_arr.length
            self.answers.each do |a|
                everything += a.value_array
            end

            # nominal
            if (self[:character] == "nominal")
                # index of qualitative variation
                return 1.0 - iqv(everything, n)
                
            # ordinal
            else
                # normalized standard deviation
                return 1.0 - coefficient_variance(everything)
            end

        else
            return 1
        end
    end


    def self.to_csv(options = {})
        CSV.generate(options) do |csv|
            csv << column_names
            all.each do |t|
                csv << t.attributes.values_at(*column_names)
            end
        end
    end

    private

    def iqv(arr, n)
        # frequency array
        hash = frequency(arr)
        puts hash

        # sum of frequency & sum of squared frequency
        sum = 0
        sum_sqrt = 0
        hash.each { |key, v| 
            sum += v 
            sum_sqrt += v**2
        }

        return ( n * (sum**2 - sum_sqrt) ) / ( sum**2 * (n - 1) ).to_f
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

        puts "sum: " + sum.to_s
        puts "mean: " + mean.to_s

        # variance
        sum_sqrt = arr.inject(0){ |accum, i| accum + (i - mean)**2 }
        variance = sum_sqrt / (arr.length - 1).to_f

        puts "sum_sqrt: " + sum_sqrt.to_s
        puts "variance: " + variance.to_s

        return (Math.sqrt(variance) / mean)
    end

end
