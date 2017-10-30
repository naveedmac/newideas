class Idea < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  validates(:title, {
      presence: {message: 'must be provided'},
      uniqueness: true
    })

  validates(:description, {
      presence: true,
      length: {minimum: 5, maximum: 2000}
    })

end
