class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # include Authenticable

  #Ben 6/17/2018 Moved the pagination helper into the APIController
  protected
  def after_sign_in_path_for(resource)
     request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end
  def root_path
    "/"
  end
end
