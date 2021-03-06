module Cryptoexchange::Exchanges
  module Cfinex
    module Services
      class Trades < Cryptoexchange::Services::Market
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Cfinex::Market::API_URL}/data?Pair=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          output['History'].collect do |trade|
            tr = Cryptoexchange::Models::Trade.new
            tr.trade_id  = nil
            tr.base      = market_pair.base
            tr.target    = market_pair.target
            tr.market    = Cfinex::Market::NAME
            tr.type      = trade['Type'].downcase
            tr.price     = trade['Price']
            tr.amount    = trade['Amount']
            tr.timestamp = trade['UnixTime'].to_i
            tr.payload   = trade
            tr
          end
        end
      end
    end
  end
end
