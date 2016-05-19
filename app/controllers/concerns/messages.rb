module Messages
  def no_record_found
    "No bucketlist found"
  end

  def delete_message(object)
    "#{object.class} deleted successfully"
  end

  def login_success
    "Logged in successfully"
  end

  def login_error
    "Unable to login"
  end

  def logout_success
    "You are now logged out"
  end

  def account_created
    "Account created"
  end

  def access_denied
    "Access denied"
  end

  def invalid_endpoint_error
    "Invalid endpoint, check documentation for more details"
  end
end
