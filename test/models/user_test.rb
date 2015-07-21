require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "generates a reset token" do
    user = User.create!(
      email: 'test@example.com',
      password: 'helloworld',
      password_confirmation: 'helloworld'
      )
    
    refute user.reset_token
    
    user.generate_token(:reset_token)

    assert user.reset_token
  end
end
