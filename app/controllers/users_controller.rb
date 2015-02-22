class UsersController < ApplicationController

  def show
    @user = User.find_by(:id => params[:id])
    if @user
      @user_games = @user.games
      render json: {:user => @user.as_json(:only => [:email]), :game => @user_games }, status: :ok
    else
      render json: { :error => "User does not exist"}, status: :not_found
    end
  end
end