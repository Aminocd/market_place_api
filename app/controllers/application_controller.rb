class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Authenticable 
  #Ben 6/17/2018 Moved the pagination helper into the APIController
end
