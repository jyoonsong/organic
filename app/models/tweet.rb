class Tweet < ApplicationRecord
    has_many :answers
    has_many :answered_users, through: :answers, source: :user
end
