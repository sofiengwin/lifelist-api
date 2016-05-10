module Support
  module Test
    module Helpers
      def json(body)
        JSON.parse(body, symbolize_names: true)
      end

      def login(user)
        AuthToken.new.encode(user.id)
      end

      def valid_get_request(route, user)
        get(
          route,
          {},
          "Authorization" => login(user)
        )
      end

      def delete_request(route, user)
        delete(
          route,
          {},
          "Authorization" => login(user)
        )
      end
    end
  end
end
