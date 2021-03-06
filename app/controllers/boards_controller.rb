class BoardsController < ApplicationController
  after_action :verify_authorized

  def create
    board = Board.new(board_params)
    board.project_id = params[:project_id]
    authorize board

    #binding.pry
    if board.save
      render json: board, status: 201
    else
      render json: { errors: board.errors }, status: 422
    end
  end

  def completed_tasks
    board = Board.find(params[:id])
    authorize board
    @tasks = board.completed_tasks.includes(:tags)
  end

  private
  def board_params
    params.require(:board).permit(:title)
  end
end
