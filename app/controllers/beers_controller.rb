class BeersController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :new]
  before_action :admin_user,     only: :destroy


  def index
    @beers = Beer.paginate(page: params[:page], :per_page => 10)
  end

  def show
    @beer = Beer.find(params[:id])
    @reviews = @beer.reviews.order("created_at DESC")
    if @reviews.blank?
        @avg_rating = 0
      else
        @avg_rating = @reviews.average(:rating).round(2)
      end
  end

  def new
    @beer = Beer.new
  end

  def create
    @beer = Beer.new(beer_params)
    if @beer.save
      flash[:info] = "Beer has been created."
      redirect_to @beer
    else
      render 'new'
    end
  end

  def edit
    @beer = Beer.find(params[:id])
  end

  def update
    @beer = Beer.find(params[:id])
    if @beer.update_attributes(beer_params)
      flash[:success] = "Beer updated"
      redirect_to @beer
    else
      render 'edit'
    end
  end

  def destroy
      Beer.find(params[:id]).destroy
      flash[:success] = "Beer has be deleted"
      redirect_to beers_url
  end

  def search
    if params[:search].present?
      @beers = Beer.search(params[:search])
    else
      @beers = Beer.all
    end
  end

  private

    def beer_params
      params.require(:beer).permit(:name, :style, :brewery, :brewery_url,
                                   :description, :alcohol, :picture, :drunk_on)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    

end
