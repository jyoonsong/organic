class TweetAnswer < ApplicationRecord
    belongs_to :user
    belongs_to :tweet

    def self.answers_by(user_id) 
        return self.where(user_id: user_id).where.not({isfallacy: nil})
    end

    def self.complete_task(user_id) 
        solved_tweets = self.answers_by(user_id)
        if (solved_tweets.count == 44)
            return true
        else
            return false
        end
    end

    def self.task_round(user_id)
        solved_tweets = self.answers_by(user_id)
        if (solved_tweets.count <= 23)
            return 1
        elsif (solved_tweets.count > 23)
            return 2
        end
    end

end
