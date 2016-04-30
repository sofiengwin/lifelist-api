module Support
  module Test
    module Helpers
      def json(body)
        JSON.parse(body, symbolize_names: true)
      end

      def login(user)
        post(
          "/api/v1/auth/login",
          { email: user.email, password: user.password }.to_json,
          "Accept" => "application/json",
          "Content-Type" => "application/json"
        )

        json(response.body)[:auth_token]
      end

    end
  end
end
