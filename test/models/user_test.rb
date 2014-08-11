require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  should have_many(:user_followers)
  # test "the truth" do
  #   assert true
  # end
end
