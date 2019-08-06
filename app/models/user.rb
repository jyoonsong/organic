class User < ApplicationRecord
    has_many :answers
    has_many :answered_articles, through: :answers, source: :article
    has_many :logs
end
