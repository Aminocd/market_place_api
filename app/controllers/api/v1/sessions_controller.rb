class Api::V1::SessionsController < ApplicationController

  ActionController::Parameters.permit_all_parameters = true
  def create
    user_password = session[:password]
    user_email = session[:email]
    user = user_email.present? && User.find_by(email: user_email)

    if user.valid_password? user_password
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end
end

=begin
class Api::V1::SessionsController < ApplicationController
	def create
		user_password = params[:session][:password]
		puts "This is params" 
		p params
		puts "This is the user param: #{params[:session][:newword]}!!!!"
		user_email = params[:session][:email]
		user = user_email.present? && User.find_by(email: user_email)

		if user.valid_password? user_password
			sign_in user, store: false
			user.generate_authentication_token!
			user.save
			render json: user, status: 200, location: [:api, user]
		else
			render json: { errors: "Invalid email or password"}, status: 422
		end
	end
end
=end
