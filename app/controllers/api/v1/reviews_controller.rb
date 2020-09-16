class Api::V1::ReviewsController < ApplicationController
  before_action :set_book, only: :index
  before_action :set_review, only: %w[show update destroy]
  before_action :authentication_with_token!, only: %w[create update destroy]

  def index
    @reviews = @book.reviews
    json_response("Index reviews successfully", true, {reviews: @reviews}, :ok)
  end

  def show
    json_response("Show review successfully", true, {review: @review}, :ok)
  end

  def create
    review = Review.new(review_params)
    review.user_id = current_user.id
    review.book_id = params[:book_id]
    if review.save
      json_response("Create review successfully", true, {review: review}, :ok)
    else
      json_response("Create review fail", false, {}, :unprocessable_entity)
    end
  end

  def update
    if corrent_user(@review.user)
      if @review.update(review_params)
        json_response("Update review successfully", true, {review: @review}, :ok)
      else
        json_response("Update review fail", false, {}, :unprocessable_entity)
      end
    else
      json_response("You dont have permission to do this", false, {}, :unauthorized)
    end
  end

  def destroy
    if corrent_user(@review.user)
      if @review.destroy
        json_response("Deleted review successfully", true, {}, :ok)
      else
        json_response("Deleted review fail", false, {}, :unprocessable_entity)
      end
    else
      json_response("You dont have permission to do this", false, {}, :unauthorized)
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :content_rating, :recommend_rating)
  end
  def set_book
    @book = Book.find_by(id: params[:book_id])
    unless @book.present?
      json_response("Can not find a book", false, {}, :not_found)
    end
  end

  def set_review
    @review = Review.find_by(id: params[:id])
    unless @review.present?
      json_response("Can not get review", false, {}, :not_found)
    end
  end
end