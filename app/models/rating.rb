class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, presence: true
  validates :book_id, presence: true

  after_create :update_book_rating
  after_update :update_book_rating

  private
  def update_book_rating
    book.update_attributes rating: book.raters.average(:num_rate)
  end
end
