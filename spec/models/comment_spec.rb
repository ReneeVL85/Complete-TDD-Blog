require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validations" do
    it {is_expected.to belong_to(:post)}
    it {is_expected.to belong_to(:user)}
  end
end
