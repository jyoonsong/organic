class TweetAnswer < ApplicationRecord
    belongs_to :user
    belongs_to :tweet

    def self.answers_by(user_id) 
        return self.where(user_id: user_id).where.not({isfallacy: nil})
    end

    def self.answers_by_1st(user_id) 
        return self.where(user_id: user_id, order: 1).where.not({isfallacy: nil})
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

    def self.isUnmatched(user_id)
        # No tweet_answer2 => dummy
        tweet_answer2 = self.find_by(user_id: user_id, tweet_id: self[:tweet_id])
        p "MARKED"
        p self[:tweet]
        p tweet_answer2
        if tweet_answer2.nil?
            return false
        else
            return self[:isfallacy] != tweet_answer2.isfallacy
        end

    end

end
