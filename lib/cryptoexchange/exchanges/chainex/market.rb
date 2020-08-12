module Cryptoexchange::Exchanges
  module Chainex
    class Market < Cryptoexchange::Models::Market
      NAME = 'chainex'
      API_URL = 'https://api.chainex.io'

      def self.trade_page_url(args={})
        "https://chainex.io/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
