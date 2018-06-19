class JwtToken < ActiveModelSerializers::Model #Ben 6/19/2018 Added this model so you can serialize the JWT in JSONAPI format without having to get make one for the Whitelist model(Which should not be accessible by any front end user btw) This just sets a virtual model and has no table in the database. the object_id is a random number generated and is required for json-api to serialize the object. It sets it based on the key in the request.env hash in the controller see helpers/authentication_helper to see how it is set. This token does not get set until after the devise sign_in method is called.
  attr_reader :jwt, :id
  def initialize(jwt)
    @id = self.object_id
    @jwt = jwt
  end
end
