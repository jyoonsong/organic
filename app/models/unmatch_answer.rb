class UnmatchAnswer < ApplicationRecord
    belongs_to :user
    belongs_to :tweet

    def self.answers_by(user_id) 
        return self.where(user_id: user_id)
    end

    def self.unmatch_done?(user_id)
        p self.answers_by(user_id)
        return self.answers_by(user_id).count >= 20
    end
end
