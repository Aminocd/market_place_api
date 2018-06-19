module LoginTestHelper
  def resource_name
    :user
  end

  def omniauth_resource_name
    resource_name
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
