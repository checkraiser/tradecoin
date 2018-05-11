require 'graphql'
module Types
  CoinType = GraphQL::ObjectType.define do
    name 'Coin'
    field :image_url, types.String
    field :name, types.String
    field :symbol, types.String
    field :coin_name, types.String
    field :full_name, types.String
    field :algorithm, types.String
    field :proof_type, types.String
    field :total_supply, types.Int
    field :sort_order, types.Int
  end
end