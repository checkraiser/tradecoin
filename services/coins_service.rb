require 'cryptocompare'
module CoinsService
    def self.fetch_coins
        list = Cryptocompare::CoinList.all
        base_uri = list["BaseImageUrl"]
        data = list["Data"]
        data.keys.map do |key|
            item = data[key]
            OpenStruct.new(
                image_url: "#{base_uri}#{item["ImageUrl"]}",
                name: item["Name"],
                symbol: item["Symbol"],
                coin_name: item["CoinName"],
                full_name: item["FullName"],
                algorithm: item["Algorithm"],
                proof_type: item["ProofType"],
                total_supply: item["TotalCoinSupply"].to_i,
                sort_order: item["SortOrder"]
            )
        end
    end
end