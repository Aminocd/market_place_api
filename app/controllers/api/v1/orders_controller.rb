class Api::V1::OrdersController < APIController
#	before_action :authenticate_with_token!
	before_action do
		authenticate_user!
	end

	def index
		orders = current_user.orders.page(params[:page]).per(params[:per_page])

		render json: orders, meta: pagination(orders, params[:per_page])
	end

	def show
		respond_with current_user.orders.find(params[:id]), include: :products, fields: { products: [:title, :price, :published] }
	end

	def create
		order = current_user.orders.build
		order.build_placements_with_product_ids_and_quantities(params[:order][:product_ids_and_quantities])

		if order.save
			order.reload # we reload the object so the response displays the product objects
			#Ben 6/19/2018 You can configure Delayed jobs to work with ActiveJob by adding this in the application.rb file "config.active_job.queue_adapter = :delayed_job" then you can run this callback  "after_commit :send_order_confirmation_mail, on: :create" in the Order model, Follow the instructions on this tutorial and it will show you how to accomplish this https://robots.thoughtbot.com/action-mailer-and-active-job-sitting-in-a-tree. Main thing is this is an asyncronous job so you wont have to call it here or have to reload the model like you are doing above
			OrderMailer.delay.send_confirmation(order)
			render json: order, status: 201, location: [:api, current_user, order]
		else
			render json: { errors: order.errors }, status: 422
		end
	end

	private
		def order_params
			params.require(:order).permit(:product_ids => [])
		end
end
