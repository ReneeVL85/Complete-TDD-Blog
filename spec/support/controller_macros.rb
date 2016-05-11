module ControllerMacros
  def login_user
    let(:user) { User.create(email: "user@email.nl", password: "98765432") }

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end
  end
end
