class Api::V1::BooksController < ApplicationController
  before_action :set_book, only: :show
  def index
    reviews_serialize = parse_json(Book.all)
    json_response("Index books successfully", true, {books: reviews_serialize}, :ok)
  end

  def show
    review_serialize = parse_json(@book)
    json_response("Show book successfully", true, {book: review_serialize}, :ok)
  end

  private
  def set_book
    @book = Book.find_by(id: params[:id])
    unless @book.present?
      json_response("Can not get book", false, {}, :not_found)
    end
  end
end