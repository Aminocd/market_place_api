class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  include Authenticable

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
