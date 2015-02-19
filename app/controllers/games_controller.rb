
class GamesController < ApplicationController
  
  before_action :authenticate_user_from_token! , :only => [:join, :create]

  def show
    @game = Game.find(params[:id])
    render json: { :game => @game }, status: :ok
  end

  def join
    binding.pry
    @waiting = Game.waiting.first
    if @waiting 
      @waiting.users << current_user
      render json: { :game => @waiting }, status: :ok
    else
      
      @game = Game.create
      @game.users = [current_user]
      render json: { :game => @game }, status: :ok
    end
  end



  def create
    @game = Game.create
    @game.users = [current_user]
    render json: { :game => @game }, status: :created
  end


private
  # def user_params
  #   params.require(:user).permit(:id)
  # end
end

