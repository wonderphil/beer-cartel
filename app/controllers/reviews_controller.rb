class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :new]
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_beer

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.beer_id = @beer.id
    if @review.save
      flash[:info] = "Beer has been Reviewed."
      redirect_to beer_path(@beer)
    else
      render 'new'
    end
  end

  def edit
    
  end

  def update
    if @review.update_attributes(review_params)
      flash[:success] = "Review updated"
      redirect_to beer_path(@beer)
    else
      render 'edit'
    end
  end

  def destroy
      Review.find(params[:id]).destroy
      flash[:success] = "Beer review has be deleted"
      redirect_to beer_path(@beer)
  end

  private

    def review_params
      params.require(:review).permit(:rating, :comment, :user_id, :beer_id)
    end

 	def set_review
      @review = Review.find(params[:id])
    end
    
    def set_beer
  		@beer = Beer.find(params[:beer_id])
	end

end
