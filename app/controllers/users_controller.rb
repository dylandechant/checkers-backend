class UsersController < ApplicationController

  def show
    @user = User.find_by(:id => params[:id])
    @user_games = @user.games
    render json: {:user => @user.as_json(:only => [:email]), :game => @user_games }, status: :ok
  end

end