class Api::V1::UsersController < APIController
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead
	# protect_from_forgery with: :null_session #Ben 6/19/2018 Dont need this set here since it is inhereitgn from the APIController which declares protect from forgery there.

	before_action only: [:update, :destroy] do
		authenticate_user!
	end

	def show
		respond_with User.find(params[:id])
	end

	def create
		user = User.new(user_params)
		if user.save
			render json: user, status: 201, location: [:api, user]
		else
			render json: { errors: user.errors }, status: 422
		end
	end

	def update
		user = current_user

		if user.update(user_params)
			render json: user, status: 200, location: [:api, user]
		else
			render json: { errors: user.errors }, status: 422
		end
	end

	def destroy
		current_user.destroy
		head 204
	end

	private
		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation)
		end
end
