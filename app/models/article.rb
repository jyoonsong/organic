class Article < ApplicationRecord
    has_many :answered_users, through: :answers, source: :user
end
