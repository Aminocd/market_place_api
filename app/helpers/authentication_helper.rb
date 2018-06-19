module AuthenticationHelper
  def render_resource_or_jwt(resource, jwt)
    if resource.errors.empty?
      render json: jwt
    else
      validation_error(resource)
    end
  end

  def missing_param_error(msg="")
    render json: {
      errors: [
        {
          status: '422',
          title: 'Bad Request',
          detail: msg
        }
      ]
    }, status: :unprocessable_entity
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors
        }
      ]
    }, status: :bad_request
  end

  def set_jwt(response_token)
    if response_token.present?
      JwtToken.new(response_token)
    else
     {
        errors: [
          {
            status: '400',
            title: 'Bad Request',
            detail: "Error retreving JWT"
          }
        ]
      }
    end
  end
end
