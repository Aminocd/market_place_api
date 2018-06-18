class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session

# include Authenticable
  include DeviseTokenAuth::Concerns::SetUserByToken

  protected
	def pagination(pagination_array, per_page)
		{ pagination: {
		  per_page: per_page,
		  total_pages: pagination_array.total_pages.to_s,
		  total_count: pagination_array.total_count.to_s
		  }
			
		}
	end
end
