require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get create" do
    # 1 Setup the world
    user = User.create!(
      email: 'testemail@email.com')
    topic = Topic.create!(
      title: 'cats')
    

    # 2 Take action
    get :create, {sender: user.email, subject: topic.title, 'body-plain': 'http://example.org'}

    # 3 Expect
    assert_response :success
    topic.bookmarks.first.url = 'http://example.org'
  end

end
