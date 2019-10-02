class Surveyanswer < ApplicationRecord
    belongs_to :user
    belongs_to :surveytask

    def self.to_csv(options = {})
        CSV.generate(options) do |csv|
            csv << column_names
            all.each do |a|
                csv << a.attributes.values_at(*column_names)
            end
        end
    end

    def self.done?(user_id) 
        return self.where(user_id: user_id).length >= Surveytask.all.length
    end

    def self.pre_done?(user_id) 
        return self.where(user_id: user_id).length >= 1
    end
end
