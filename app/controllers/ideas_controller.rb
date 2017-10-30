class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, except: [:index, :show, :new, :create]

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new idea_params
    @idea.user = current_user

    if @idea.save
      redirect_to idea_path(@idea)
    else
      render :new
    end
  end

  def show
    @reviews = @idea.reviews.order(created_at: :desc)
    @review = Review.new
  end

  def edit
    # before_action is used
  end

  def index
    @ideas = Idea.order(created_at: :desc)
  end

  def update
    return head :unauthorized unless can?(:update, @idea)

    if @idea.update idea_params
      redirect_to @idea
    else
      render :edit
    end
  end

  def destroy
    @idea.destroy
    redirect_to ideas_path
  end

  private
  def idea_params
    params.require(:idea).permit(:title, :description)
  end

  def find_idea
    @idea = Idea.find params[:id]
  end

  def authorize_user!
    unless can?(:manage, @idea)
      flash[:alert] = "Access Denied!"
      redirect_to root_path
    end
  end
end
