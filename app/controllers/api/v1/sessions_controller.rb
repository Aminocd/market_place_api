class Api::V1::SessionsController < ApplicationController
  # Ben 6/19/2018 You no longer need this controller since the sessions are controlled in the users/sessions controller
  # def create
  #   user_password = session[:password]
  #   user_email = session[:email]
  #   user = user_email.present? && User.find_by(email: user_email)
  #
  #   if user.valid_password? user_password
  #     sign_in user, store: false
  #     user.generate_authentication_token!
  #     user.save
  #     render json: user, status: 200, location: [:api, user]
  #   else
  #     render json: { errors: "Invalid email or password" }, status: 422
  #   end
  # end
  #
  # def destroy
	# user = User.find_by(auth_token: params[:id])
	# user.generate_authentication_token!
	# user.save
	# head 204
  # end
end
