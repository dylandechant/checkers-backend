
class GamesController < ApplicationController

  before_action :authenticate_user_from_token! , :only => [:join, :create, :move]


  def show
    @game = Game.find(params[:id])
    render json: {:game => @game, :users => @game.users.as_json(:only => [:email])}, status: :ok
    # render json: :game => @game, :include => { :users }, status: :ok

  end

  def join
    if Game.waiting(current_user).first
      @waiting = Game.waiting(current_user).first
    end
    if @waiting
      @waiting.users << current_user
      if @waiting.turn == 1
        @waiting.update(:user_turn => current_user.email)
      end
      render json: {:game => @waiting, :users => @waiting.users.as_json(:only => [:email])}, status: :ok
    else
      @game = Game.create
      @game.users = [current_user]
      render json: {:game => @game, :users => @game.users.as_json(:only => [:email])}, status: :ok
    end
  end

  def create
    @game = Game.create(:user_turn => current_user.email)
    @game.users = [current_user]
    render json: {:game => @game, :users => @game.users.as_json(:only => [:email])}, status: :ok
  end

  def move
    @game = set_game
    move = JSON.parse(params[:move])
    if @game.valid_move?(move)
      render json: {:game => @game, :users => @game.users.as_json(:only => [:email])}, status: :ok
    else
      render json: { :error => "Unauthorized move" }, status: :unauthorized
    end

  end

private
  def set_game
    @game = Game.find(params[:id])
  end
end
