FactoryGirl.define do
  factory :user do
    name "Jon"
  end

  factory :board do
    title "This is the title of the board"
    created_at Time.new
  end

  factory :user_board do
    user
    board
  end

  factory :post do
    content "Lorem ipsum dolor sit amet, consectetur adipisicing elit"
    user_board
    created_at Time.new
  end
end
