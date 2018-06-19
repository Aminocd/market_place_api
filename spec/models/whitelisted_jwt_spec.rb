require 'rails_helper'

RSpec.describe WhitelistedJwt, type: :model do
  before { @jwt = FactoryBot.build(:whitelisted_jwt)}
  subject { @jwt }

  it { should respond_to(:jti)}
  it { should respond_to(:aud)}
  it { should respond_to(:exp)}
  it { should belong_to(:user)}
  it { should be_valid}

  it "destroys iself on user destruct" do
    @user = @jwt.user
    @jti = @jwt.jti
    @user.destroy!
    expect(WhitelistedJwt.find_by(jti: @jti)).to be(nil)
  end
end
