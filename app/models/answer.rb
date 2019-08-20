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

    def value_with_highlight
        result = 0
        highlights = Task.find(self[:task_id]).highlights_arr

        self.value_array.each do |v|
            if (!highlights.include?(v))
                result += 1
            end
        end

        return result
    end

    def highlights_arr
        if (!self[:highlight].nil?)
            return self[:highlight].split(/\s*,\s*/).map!{ |v| v.to_i }
        end

        return []
    end

    def update_highlights(val)
        if (!self[:highlight].nil?)
            return self[:highlight] + val
        end

        return val
    end



    def fixed_array(size, other)  
        Array.new(size) { |i| other[i] }
    end

    def self.answers_by(user_id) 
        return self.where(user_id: user_id).where.not({value: nil})
    end

    def self.to_csv(options = {})
        CSV.generate(options) do |csv|
            csv << column_names
            all.each do |a|
                csv << a.attributes.values_at(*column_names)
            end
        end
    end
end
