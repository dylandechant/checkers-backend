class LeaderboardsController < ApplicationController

  def index
    @user = User.order(:wins => :desc).limit(10)
    render json: { :user => @user }, status: :ok
  end
end
