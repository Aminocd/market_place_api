# require 'spec_helper'
# Ben 6/19/2018 Dont need this anymore since the sessions are managed by devise
# describe Api::V1::SessionsController do
#
#   describe "POST #create" do
#
#    before(:each) do
#     @user = FactoryBot.create :user
#    end
#
#     context "when the credentials are correct" do
#
#       before(:each) do
#         credential_params = { email: @user.email, password: "12345678" }
# 		session_params = { session: credential_params }
#         post :create, session_params
#       end
#
#       it "returns the user record corresponding to the given credentials" do
#         @user.reload
#         expect(json_response[:"data"][:"attributes"][:"auth-token"]).to eql @user.auth_token
#       end
#
#       it { should respond_with 200 }
#     end
#
#     context "when the credentials are incorrect" do
#
#       before(:each) do
#         credentials = { email: @user.email, password: "invalidpassword" }
#         post :create, { session: credentials }
#       end
#
#       it "returns a json with an error" do
#         expect(json_response[:errors]).to eql "Invalid email or password"
#       end
#
#       it { should respond_with 422 }
#     end
#   end
#
#
#   describe "DELETE #destroy" do
#
# 	before(:each) do
# 	  @user = FactoryBot.create :user
# 	  sign_in @user #, store: false
#       delete :destroy, id: @user.auth_token
# 	end
#
# 	it { should respond_with 204 }
#
#   end
# end
