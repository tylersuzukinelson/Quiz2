class ReviewsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]

  def index
  end

  def show
  end

  def update
  end

  def create
    @review = Review.new(review_params)
    @idea = Idea.find(params[:idea_id])
    @review.idea = @idea
    @review.user = current_user

    if cannot? :create, @review
      flash[:alert] = 'Access Denied.'
    elsif @review.save
      redirect_to @idea, notice: 'Review created!'
    else
      flash[:alert] = 'Problem creating review.'
      render home_path
    end
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:body)
  end

end
