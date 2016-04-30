class AuthToken
  def encode(user_id, exp = 24.hours.from_now)
    payload = { user: user_id, exp: exp.to_i }
    generate_token(payload)
  end

  def generate_token(payload)
    JWT.encode(
      payload,
      Rails.application.secrets.secret_key_base,
      "HS256"
    )
  end

  def decode(token)
    JWT.decode(
      token,
      Rails.application.secrets.secret_key_base,
      true,
      algorithm: "HS256"
    )
  rescue
    nil
  end
end
