class LoginTestController < ApplicationController
  layout 'login'
  respond_to :html, :js
  include LoginTestHelper
  def show
    if params[:page_type].blank?
      @page_type = "login"
    else
      @page_type = params[:page_type]
    end
  end
end
