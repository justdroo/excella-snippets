describe BoardsController, :type => :controller do
  describe "SHOW" do
    it "responds successfully with an HTTP 200 status code" do
      board = FactoryGirl.create(:board)
      get :show, { id: board.id }
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "returns JSON" do
      board = FactoryGirl.build(:board)
      get :show, { id: board.id }
      expect(response.content_type).to eq("application/json")
    end

    it "returns correctly formatted object" do
      jack = FactoryGirl.create(:user, name: "Jack")
      jill = FactoryGirl.create(:user, name: "Jill")

      board = FactoryGirl.create(:board)
      user_board_jack = FactoryGirl.create(:user_board, board: board, user: jack)
      user_board_jill = FactoryGirl.create(:user_board, board: board, user: jill)

      jack_post = FactoryGirl.create(:post, user_board: user_board_jack)
      jill_post = FactoryGirl.create(:post, user_board: user_board_jill)
      jack_image = FactoryGirl.create(:image, user_board: user_board_jack)
      jill_image = FactoryGirl.create(:image, user_board: user_board_jill)

      total_posts = user_board_jack.posts.length + user_board_jill.posts.length
      total_posts = user_board_jack.images.length + user_board_jill.images.length

      get :show, { board.id }
      parsed = JSON.parse(response.body)
      response = parsed["board"]

      expect(response["title"]).to eq(board.title)

      expect(response["user_boards"].length).to eq(2)
      expect(response["user_boards"].first["id"]).to eq(user_board_jack.id)
      expect(response["user_boards"].first["board_id"]).to eq(user_board_jack.board_id)
      expect(response["user_boards"].last["id"]).to eq(user_board_jill.id)
      expect(response["user_boards"].last["board_id"]).to eq(user_board_jill.board_id)

      expect(response["users"].length).to eq(2)
      expect(response["users"].first["id"]).to eq(jack.id)
      expect(response["users"].last["id"]).to eq(jill.id)

      expect(response["posts"].length).to eq(total_posts)
      expect(response["images"].length).to eq(total_images)
    end
  end
end


describe OrderedPosts, :type => :model do
  context "sort_with_user" do
    it "returns posts ordered newest to oldest" do
      board = FactoryGirl.build(:board)

      user_board_one = FactoryGirl.build(:user_board, board: board)
      user_board_two = FactoryGirl.build(:user_board, board:board)

      post_one = FactoryGirl.build(:post, user_board: user_board_one)
      post_two = FactoryGirl.build(:post, user_board: user_board_two)
      post_three = FactoryGirl.build(:post, user_board: user_board_one)
      post_four = FactoryGirl.build(:post, user_board: user_board_two)

      new_list = OrderedPosts.new
      posts = new_list.sort_with_user(board)

      expect(posts).to eq([post_one, post_two, post_three, post_four])
    end
  end
end
