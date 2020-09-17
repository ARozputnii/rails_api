class Review < ApplicationRecord
  before_save :caculate_average_rating
  before_validation :parse_image

  belongs_to :user
  belongs_to :book

  attr_accessor :image_review
  counter_culture :book, column_name: :reviews_count_to_book

  has_attached_file :picture, styles: { medium: '300x300>', thumb: '100x100>'}
  validates_attachment :picture, present: true
  do_not_validate_attachment_file_type :picture

  private
  def caculate_average_rating
    self.average_rating = ((self.content_rating.to_f + self.recommend_rating.to_f) / 2).round(1)
  end

  def parse_image
    image = Paperclip.io_adapters.for image_review
    image.original_filename = "review_image.jpg"
    self.picture = image
  end
end
