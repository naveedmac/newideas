class Review < ApplicationRecord
  belongs_to :user
  belongs_to :idea
  validates(:review_desc, {
      presence: {message: 'body must be provided'},
      length: {minimum: 5, maximum: 2000}
    })
end
