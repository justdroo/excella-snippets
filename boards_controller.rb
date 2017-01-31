class BoardsController < ApplicationController
  def show
    board = Board.find(board_params[:id])
    users = board.users

    posts = OrderedPosts.new.sort_with_user(board)
    images = OrderedImages.new.sort_with_user(board)

    render json: {board: {id: board.id, title: board.title, user_boards: board.user_boards, users: users, posts: posts, images: images}}
  end
end
