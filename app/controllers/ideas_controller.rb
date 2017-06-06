require 'json' # Why?

class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :idea

  def index
    @ideas = Idea.order(created_at: :desc)
  end

  def new
  end

  def show
    @review = Review.new
    @reviews = idea.reviews.order(created_at: :desc)
  end

  def create
    idea.user = current_user
    if idea.save
      redirect_to idea_path(idea), notice: "Successfully created!"
    else
      flash.now[:alert] = 'Unable to create!'
      render :new
    end
  end

  def edit
    unless can? :edit, idea
      flash[:alert] = 'Access Denied. You are not authorized to edit this Idea.'
      redirect_to idea
    end
  end

  def update
    if can?(:update, idea) && idea.update(idea_params)
      redirect_to idea, notice: 'Idea updated.'
    else
      flash.now[:alert] = 'Unable to update!'
      render :edit
    end
  end

  def destroy
    if can? :destroy, idea
      idea.destroy
      flash[:alert] = 'Idea removed.'
    else
      flash[:alert] = 'Access Denied. You are not authorized to delete this Idea.'
    end
    redirect_to ideas_path
  end

  def like
    if !session.has_key?(idea.id)
      idea.increment(:like_count)
      if idea.save
        redirect_to ideas_path
        session[idea.id] = 1
      end
    else
      flash.now[:notice] = 'Already liked!'
      # This will attempt to render like.html.erb which doesn't exist
    end
  end


  private

  def idea
    @idea ||= begin
      if params[:id]
        Idea.find params[:id]
      elsif params.has_key? :idea
        Idea.new idea_params
      else
        Idea.new
      end
    end
  end

  def idea_params
    params.require(:idea).permit([:title, :description, :user_id])
  end
end
