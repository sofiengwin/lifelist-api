module Support
  module Test
    module Helpers
      def json(body)
        JSON.parse(body, symbolize_names: true)
      end
    end
  end
end
