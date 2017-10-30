class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_idea, only: [:create]
  before_action :find_review, only: [:destroy]
  before_action :authorize_user!, except: [:create]

  def create
    @review = @idea.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to idea_path(@idea)
    else
      @reviews = @idea.reviews.order(created_at: :desc)
      render 'ideas/show'
    end
  end

  def destroy
    @review.destroy
    redirect_to idea_path(@review.idea)
  end

  private
  def find_idea
    @idea = Idea.find(params[:idea_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:review_desc)
  end

  def authorize_user!
    unless can?(:manage, @review)
      flash[:alert] = "Access Denied!"
      redirect_to root_path
    end
  end 
end
