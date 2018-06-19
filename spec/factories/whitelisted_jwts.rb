FactoryBot.define do
  factory :whitelisted_jwt do
    jti SecureRandom.hex
    aud "Test"
    exp DateTime.now + 8.hours
    user
  end
end
