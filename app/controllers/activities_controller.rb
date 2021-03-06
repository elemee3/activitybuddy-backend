class ActivitiesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_activity, only: [:show, :update, :destroy]

  # get activities index (/activities)
  def index
    @activities = Activity.all
    render json: @activities
  end

  # get single activity (/activities/id)
  def show
    render json: @activity
  end

  def create
    @activity = Activity.new(activity_params)
    if @activity.valid?
      @activity.save
      render json: @activity, status: :created
    else
      render json: @activities.errors, status: :unprocessable_entity
    end
  end

  def update
    @activity.update_attributes(activity_params)
  end

  def destroy
    @activity.delete
    render json: @activity.id, status: :accepted
  end

  def show_activity_users
    @activity = Activity.find(params[:activity_id])
    @activity_users = @activity.users
    render json: @activity_users
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:name)
  end
end
