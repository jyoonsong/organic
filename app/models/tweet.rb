class Tweet < ApplicationRecord
    has_many :tweet_answers
    has_many :answered_users, through: :answers, source: :user

    def self.tweet_to_solve(tweet_id)
        if (tweet_id <= 24)
            return self.find(tweet_id) 
        elsif (tweet_id > 24)
            return self.find(tweet_id - 24)
        end

    end
end
