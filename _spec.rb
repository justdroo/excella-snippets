describe BoardsController, :type => :controller do
  describe "SHOW" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, { :id => 1 }
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "returns JSON" do
      get :show, { :id => 1 }
      expect(response.content_type).to eq("application/json")
    end

    it "returns correctly formatted object" do
      get :show, { :id => 1 }
      parsed = JSON.parse(response.body)
      board_object = parsed["board"]

      expect(board_object["title"]).to eq("Scott & Drew: BFFs")

      expect(board_object["user_boards"].length).to eq(2)
      expect(board_object["user_boards"].first["id"]).to eq(3)
      expect(board_object["user_boards"].first["board_id"]).to eq(1)
      expect(board_object["user_boards"].last["id"]).to eq(4)
      expect(board_object["user_boards"].last["board_id"]).to eq(1)

      expect(board_object["users"].length).to eq(2)
      expect(board_object["users"].first["id"]).to eq(1)
      expect(board_object["users"].last["id"]).to eq(2)

      expect(board_object["posts"].length).to eq(4)
      expect(board_object["images"].length).to eq(2)
    end
  end
end


describe OrderedPosts, :type => :model do
  context "sort_with_user" do
    it "receives a board object" do
      # byebug
      # my_method = OrderedPosts.sort_with_user
      # expect(my_method).to receive(:foo).with(instance_of(Board))
    end

    it "returns posts" do
      board = Board.first
      new_list = OrderedPosts.new
      posts = new_list.sort_with_user(board)
      # is_it = posts.is_a?
      byebug
    end
  end
end
