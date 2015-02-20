
class GamesController < ApplicationController
  before_action :authenticate_user_from_token! , :only => [:join, :create, :move]

  def show
    @game = Game.find(params[:id])
    render json: { :game => @game , :users => @game.users }
    # render json: :game => @game, :include => { :users }, status: :ok

  end

  def join
    @waiting = Game.waiting.first
    if @waiting 
      @waiting.users << current_user
      render json: { :game => @waiting, :users => @game.users }
      # render json: :game => @waiting, :include => { :users => { :only => :email } }, status: :ok
    else
      @game = Game.create
      @game.users = [current_user]
      render json: { :game => @game, :users => @game.users }
      # render json: :game => @game, :include => { :users => { :only => :email } }, status: :ok
    end
  end

  def create
    @game = Game.create
    @game.users = [current_user]
    render json: { :game => @game,  :users => @game.users }
    # render json: :game => @game, :include => { :users => { :only => :email } }, status: :created
  end

  def move
    @game = set_game
    move = JSON.parse(params[:move])
    if @game.valid_move?(move)
      render json: { :game => @game }, status: :accepted
    else
      render json: { :error => "something went wrong" }, status: :not_modified
    end

  end


private
  def set_game
    @game = Game.find(params[:id])
  end
end

