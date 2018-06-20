class LoginTestController < ApplicationController
  layout 'login'
  respond_to :html, :js
  include LoginTestHelper
  before_action :check_if_already_logged_in, :only => [:show]

  before_action :check_if_not_logged_in, :only => [:index]


  def show
    if params[:page_type].blank?
      @page_type = "login"
    else
      @page_type = params[:page_type]
    end
  end

  def index
  end

  private
  def check_if_not_logged_in
    return if user_signed_in?
    redirect_to :action => "show"
  end

  def check_if_already_logged_in
    return unless user_signed_in?
    redirect_to :action => "index"
  end
end
