require 'graphql'
module Types
  StrategyType = GraphQL::ObjectType.define do
    name 'Strategy'
    field :action, types.String
    field :entry, types.Int
    field :target, types.Int
    field :stoploss, types.Int
    field :note, types.String
  end
end