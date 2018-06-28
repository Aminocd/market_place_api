class SocialLoginValidator < ActiveModel::Validator
  def validate(record)
    if record.new_record?
      record.errors.add(:no_email_from_provider, "Email not found with #{record.provider.titleize} login. Please use an account that has a verfied email address or sign up using a valid email address")if record.email.blank?
    else
      record.errors.add(:already_registered_with_different_provider, "You have already registered this account with #{format_provider_name(record.provider_was)} and are attempting to login using #{format_provider_name(record.provider)}. Please login using #{format_provider_name(record.provider_was)}") if record.provider_changed?
    end
  end

  private
  def format_provider_name(provider)
    provider.present? ? provider.titleize : "Email and Password"
  end
end
