class ReviewsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]

  def index
  end

  def show
  end

  def update
    @idea = Idea.find(params[:idea_id])
    @review = Review.find(params[:id])

    if can? :edit, @idea
      @review.update(flag: !@review.flag)

      if @review.flag
        flash[:alert] = 'Review flagged.'
      else
        flash[:notice] = 'Flag removed from review.'
      end
      redirect_to @idea
    end

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
      redirect_to @idea
    end
  end

  def destroy
    @review = Review.find params[:id]
    @idea = @review.idea
    if can? :destroy, @review
      @review.destroy
      redirect_to @idea, notice: 'Review deleted'
    else
      flash[:alert] = 'Access Denied.'
      redirect_to @idea
    end
  end




  private

  def review_params
    params.require(:review).permit(:body)
  end

end
