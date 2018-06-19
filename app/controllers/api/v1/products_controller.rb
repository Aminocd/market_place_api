class Api::V1::ProductsController < APIController
	before_action only: [:create, :update] do
		authenticate_user!
	end

	def show
		respond_with Product.find(params[:id]), include: :user, fields: { user: [:email, :created_at, :updated_at]}
	end

	def index
		products = Product.search(params).page(params[:page]).per(params[:per_page])
		render json: products, include: :user, fields: { user: [:email, :created_at, :updated_at]}, meta: pagination(products, params[:per_page])
	end

	def create
		product = current_user.products.build(product_params)
		if product.save
			render json: product, status: 201, location: [:api, product]
		else
			render json: { errors: product.errors}, status: 422
		end
	end

	def update
		product = current_user.products.find(params[:id])
		if (product.update(product_params))
			render json: product, status: 200, location: [:api, product]
		else
			render json: { errors: product.errors}, status: 422
		end
	end

	def destroy
		product = current_user.products.find(params[:id])
		product.destroy
		head 204
	end

	private
		def product_params
			params.require(:product).permit(:title, :price, :published)
		end
end
