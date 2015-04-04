require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  def setup
    @group = Group.create(name: "Example group")
  end

  test "associated users should be destroyed" do
    @group.save
    @group.users.create!(email: "example@test.com",
                         password: "password",
                         password_confirmation: "password")
    assert_difference 'Group.count', -1 do
      @group.destroy
    end
  end

end
