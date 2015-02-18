class GamesControllers < ApplicationController
  before_action :authenticate_user!, only: => [:join, :create]
  before_action :authenticate_user_from_token!

  def show
    @game = Game.find(params[:id])
    render json: { :game => @game }, status: :ok
  end

  def join
    @waiting = Game.waiting.first
    if @waiting 
      @game = @waiting.users << current_user
      render json:{:game => @game}, status: :ok
    else
      
      @game = Game.create(player1_id: params[:id])
    end
  end



  def create
    @game = Game.create(game_params)
    render json: {}, status: :created
  end


private
  def game_params
    require(:game).permit(:board, :player_id)
  end
end

