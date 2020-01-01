class User < ApplicationRecord
    has_many :tweet_answers
    has_many :surveyanswers
    has_many :answered_articles, through: :answers, source: :article
    has_many :logs

    def update_capability(num)
        if (!self[:capability].nil?)
            return self[:capability] + ("," + num.to_s)
        end

        return num.to_s
    end

    def capability_arr
        if (!self[:capability].nil?)
            return self[:capability].split(/\s*,\s*/).map!{ |c| c.to_i }
        end

        return []
    end

    def assign_group
        @user_cnt = User.distinct.count(:key)
        @passed_group1 = User.where(passed: true).where(group: 1).distinct.count(:key)
        if (@user_cnt % 2 == 0 && @passed_group1 < 20)
            self.group = 1
        else 
            self.group = 2
        end
    end
end
