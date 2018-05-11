require 'graphql'
require_relative './strategy_type'
module Types  
  CoinType = GraphQL::ObjectType.define do
    name 'Coin'
    description 'Coin'
    field :name, types.String
    field :lookback, types.Int
    field :duration, types.Int
    field :recommendations, types[Types::StrategyType]
    field :extras, types[Types::StrategyType]
    field :supports, types[types.Float]
    field :resistances, types[types.Float]
  end
end