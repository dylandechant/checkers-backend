class LeaderboardsController < ApplicationController
  def index
    @users = User.order(:wins => :desc).limit(10)
    render json: {:users => @users.as_json(:only => [:email, :wins])}, status: :ok
  end
end
