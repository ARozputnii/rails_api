class AddReviewsCountToBookToBooks < ActiveRecord::Migration[6.0]
  def self.up
    add_column :books, :reviews_count_to_book, :integer, null: false, default: 0
  end

  def self.down
    remove_column :books, :reviews_count_to_book
  end
end
