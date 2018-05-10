require 'graphql'
module Types
  StrategyType = GraphQL::ObjectType.define do
    name 'Strategy'
    field :action, types.String
    field :entry, types.Float
    field :target, types.Float
    field :stoploss, types.Float
    field :note, types.String
  end
end