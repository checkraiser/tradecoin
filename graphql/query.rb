require 'graphql'
require_relative 'types/trade_type'
require_relative 'types/coin_type'
require_relative '../services/btc_service'
require_relative '../services/coins_service'
QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root of this schema"
  field :trade do
    type Types::TradeType
    argument :target, types.String, default_value: 'BTC'
    argument :name, !types.String
    argument :lookback, types.Int, default_value: -1
    argument :duration, types.Int, default_value: 5
    resolve ->(_obj, _args, _ctx) {
        BtcService::trade_btc(base: _args[:name], lookback: _args[:lookback], duration: _args[:duration])
    }
  end

  field :all_coins do
    type types[Types::CoinType]
    resolve ->(_obj, _args, _ctx) {
      CoinsService::fetch_coins
    }
  end
end