class BoardsController < ApplicationController
  def show
    board = Board.find(board_params[:id])
    users = board.users

    posts = OrderedPosts.new.sort_with_user(board)
    images = OrderedImages.new.sort_with_user(board)

    render json: {board: {id: board.id, title: board.title, user_boards: board.user_boards, users: users, posts: posts, images: images}}
  end
end

class OrderedPosts
  def sort_with_user(board)
    rawPosts = board.user_boards.map {|user_board| user_board.posts}.flatten
    # [{Post}, {}, {}]
    order_posts = rawPosts.sort_by {|post| post.created_at}.reverse

    orderedWithUser = order_posts.map {|post|
      {id: post.id, content: post.content, userID: post.user_board.user.id, userName: post.user_board.user.name, createAt: post.created_at, type: "text"}
    }
  end
end

######JAVASCRIPT####### 
class Board extends Component {
  dropdown(method){
      if (method === "editing") {
        return (
          <div>
            <Col lg={11} md={11} sm={11} xs={11}>
              <form className="spaceTopS" onSubmit={this.handleEditTitle.bind(this)}>
                <FormGroup>
                  <ControlLabel>Edit Title</ControlLabel>
                  <FormControl type="text" onChange={this.handleTitleChange.bind(this)} value={this.state.title} />
                </FormGroup>
                <Button type='submit'>Edit</Button>
              </form>
            </Col>
          </div>
        )
      } else {
        return(<div></div>)
    }

    render() {
    let dropdownEdit = this.dropdown(this.props.editing);
    return (
      <Row>
        <Col lg={6} md={6} sm={6} xs={6}>
          <Button onClick={this.handleEditDropdown.bind(this)}>
            <span className="glyphicon glyphicon-cog" aria-hidden="true" value="editing"></span>
          </Button>

          {dropdownEdit}

        </Col>
      </Row>
    )

}
