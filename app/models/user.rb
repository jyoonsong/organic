class User < ApplicationRecord
    has_many :answers
    has_many :surveyanswers
    has_many :answered_articles, through: :answers, source: :article
    has_many :logs

    def update_capability(num)
        if (!self[:capability].nil?)
            return self[:capability] += ("," + num.to_s)
        end

        return num.to_s
    end

    def capability_arr
        if (!self[:capability].nil?)
            return self[:capability].split(/\s*,\s*/).map!{ |c| c.to_i }
        end

        return []
    end
end
