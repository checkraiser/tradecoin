require 'graphql'
require_relative 'types/coin_type'
require_relative '../services/btc_service'
QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root of this schema"
  field :coin do
    type Types::CoinType
    argument :name, !types.String
    argument :lookback, types.Int, default_value: -1
    argument :duration, types.Int, default_value: 5
    resolve ->(_obj, _args, _ctx) {
        get_all_btc(base: _args[:name], lookback: _args[:lookback], duration: _args[:duration])
    }
  end
end