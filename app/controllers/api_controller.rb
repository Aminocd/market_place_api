class APIController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  respond_to :json

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
