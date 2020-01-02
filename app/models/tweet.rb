class Tweet < ApplicationRecord
    has_many :tweet_answers
    has_many :unmatch_answers
    has_many :answered_users, through: :answers, source: :user

    def self.tweet_to_solve(tweet_id)
        if (tweet_id <= 24)
            return self.find(tweet_id) 
        elsif (tweet_id > 24)
            return self.find(tweet_id - 24)
        end
    end

    def isUnmatched(user_id)
        tweet_answer1 = self.tweet_answers.find_by(user_id: user_id, order: 1)
        tweet_answer2 = self.tweet_answers.find_by(user_id: user_id, order: 2)

        if tweet_answer1.nil?
            raise "error"
        elsif tweet_answer2.nil?
            raise "error"
        else
            return tweet_answer1.isfallacy != tweet_answer2.isfallacy
        end
    end

    def answer_find_with_order(user_id, order)
        return self.tweet_answers.find_by(user_id: user_id, order: order)
    end


end
