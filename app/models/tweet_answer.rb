class TweetAnswer < ApplicationRecord
    belongs_to :user
    belongs_to :tweet

    def self.answers_by(user_id) 
        return self.where(user_id: user_id).where.not({isfallacy: nil})
    end

end
