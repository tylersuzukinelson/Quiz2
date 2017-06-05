class IdeasController < ApplicationController
  # before_action :authenticate_user!, except:[:index, :show]
  before_action :find_idea, only:[:show, :edit, :update, :destroy]


  def index
    @ideas = Idea.order(created_at: :desc)
  end

  def new
    @idea = Idea.new
  end

  def show
  end

  def create

  end


  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_idea
    @idea = Idea.find params[:id]
  end

  def idea_params
    idea_params = params.require(:idea).permit([:title, :description, :user_id])
  end

end
