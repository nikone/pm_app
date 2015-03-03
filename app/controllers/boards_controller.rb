class BoardsController < ApplicationController
  def index
    @boards = Board.all.includes(:tasks => :tags)
  end
end
