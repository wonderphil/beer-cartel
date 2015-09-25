class MeetingsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]
  before_action :admin_user,     only: [:destroy, :create, :edit, :update, :new]


  def index
    @meetings = Meeting.order("date DESC").paginate(page: params[:page], :per_page => 10)
  end

  def show
    @meeting = Meeting.find(params[:id])
  end

  def new
    @meeting = Meeting.new
  end

  def create
    @meetings = Meeting.new(meeting_params)
    if @meetings.save
      flash[:info] = "Meeting has been created."
      redirect_to @meetings
    else
      render 'new'
    end
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end

  def update
    @meeting = Meeting.find(params[:id])
    if @meeting.update_attributes(meeting_params)
      flash[:success] = "Meeting has been updated"
      redirect_to @meeting
    else
      render 'edit'
    end
  end

  def destroy
      Meeting.find(params[:id]).destroy
      flash[:success] = "Meeting has be deleted"
      redirect_to meetings_url
  end

  private

    def meeting_params
      params.require(:meeting).permit(:date, :comments, {:beer_ids => []}, {:user_ids => []}, :meeting_background )
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) && flash[:danger] = "You must be admin user" unless current_user.admin?
    end




end
