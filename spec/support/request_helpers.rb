module Request
	module JsonHelpers
		def json_response
			@json_response ||= JSON.parse(response.body, symbolize_names: true)
		end
	end

	# Our headers helpers module
	module HeadersHelpers
		def api_header(version = 1)
			request.headers['Accept'] = "application/vnd.marketplace.v#{version}"
		end

		def api_response_format(format = Mime[:json])
			request.headers['Accept'] = "#{request.headers['Accept']},#{format}"
			request.headers['Content-Type'] = format.to_s
		end

		def include_default_accept_headers
			api_header
			api_response_format
		end
		#Ben 6/19/2018 changed this and added the warden helpers below to help with the sign in logic and retreive the token
		def api_authorization_header(user)
			sign_in(user)
		end
	end
	module AuthenticationHelpers
		include Warden::Test::Helpers

	  def self.included(base)
	    base.before(:each) { Warden.test_mode! }
	    base.after(:each) { Warden.test_reset! }
	  end

	  def sign_in(resource)
	    login_as(resource, scope: warden_scope(resource))
	  end

	  def sign_out(resource)
	    logout(warden_scope(resource))
	  end

	  private

	  def warden_scope(resource)
	    resource.class.name.underscore.to_sym
	  end
  end
end
