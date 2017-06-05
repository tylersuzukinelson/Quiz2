class IdeasController < ApplicationController
  # load_and_authorize_resource
  before_action :authenticate_user!, except:[:index, :show]
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
    @idea = Idea.new idea_params
    @idea.user = current_user

    if @idea.save
      redirect_to idea_path(@idea), notice: "Successfully created!"
    else
      flash.now[:alert] = 'Unable to create!'
      render :new
    end
  end


  def edit
    unless can? :edit, @idea
      flash[:alert] = 'Access Denied. You are not authorized to edit this Idea.'
      redirect_to @idea
    end
  end

  def update
    if can? :update, @idea
      if @idea.update(idea_params)
        redirect_to (@idea), notice: 'Idea updated.'
      else
        flash.now[:alert] = 'Unable to update!'
        render :edit
      end
    end
  end

  def destroy
    if can? :destroy, @idea
      @idea.destroy
      redirect_to ideas_path, alert: "Idea removed."
    else
      flash[:alert] = 'Access Denied. You are not authorized to delete this Idea.'
      redirect_to ideas_path
    end
  end

  private

  def find_idea
    @idea = Idea.find params[:id]
  end

  def idea_params
    idea_params = params.require(:idea).permit([:title, :description, :user_id])
  end

end
