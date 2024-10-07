module 0x0b8fa29fb79a3007dc574f80a6f0bd0f1c629701142add75982f80d01138b29c::StockMarket {
    struct Stock has store {
        symbol: vector<u8>,
        price: u64,
        owner: address,
    }

    public fun create_stock(symbol: vector<u8>, price: u64, owner: address): Stock {
        Stock {
            symbol,
            price,
            owner,
        }
    }

    public fun buy_stock(stock: &mut Stock, buyer: address, payment: u64) {
        assert!(payment >= stock.price, 0); // Ensure payment is sufficient

        // Update the owner of the stock
        stock.owner = buyer;
    }

    public fun sell_stock(stock: &mut Stock, seller: address) {
        assert!(stock.owner == seller, 1); // Ensure the seller is the current owner

    }

    public fun get_stock_info(stock: &Stock): (vector<u8>, u64, address) {
        (stock.symbol, stock.price, stock.owner)
    }
}