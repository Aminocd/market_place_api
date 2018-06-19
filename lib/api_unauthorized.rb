#Ben 6/17/2018 Allows devise to send unauthorized messages as json see devise.rb initializer to see how it is set up
class ApiUnauthorized < Devise::FailureApp
  def respond
    if request.format == :json
      json_error_response
    else
      super
    end
  end

  def json_error_response
    self.status = 401
    self.content_type = "application/json"
    self.response_body = {
      errors: [
          {
            status: '401',
            title: "Unauthorized",
            detail: i18n_message,
            code: '100'
          }
        ]
      }.to_json
  end
end
