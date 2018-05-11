require 'graphql'
require_relative './strategy_type'
module Types  
  TradeType = GraphQL::ObjectType.define do
    name 'Trade'
    description 'Trade'
    field :target, types.String
    field :name, types.String
    field :lookback, types.Int
    field :duration, types.Int
    field :recommendations, types[Types::StrategyType]
    field :extras, types[Types::StrategyType]
    field :supports, types[types.Int]
    field :resistances, types[types.Int]
  end
end