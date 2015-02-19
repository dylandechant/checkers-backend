
class GamesController < ApplicationController
  
  before_action :authenticate_user_from_token! , :only => [:join, :create, :move]

  def show
    @game = Game.find(params[:id])
    render json: { :game => @game }, status: :ok
  end

  def join
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

  def move
    binding.pry
    @game = set_game
    if @game.valid_move?(params[:move])
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

