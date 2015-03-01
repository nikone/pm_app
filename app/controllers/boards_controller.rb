class BoardsController < ApplicationController
  def index
    @boards = Board.all.includes(:tasks)
  end
end
