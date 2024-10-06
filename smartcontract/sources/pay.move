module 0x0b8fa29fb79a3007dc574f80a6f0bd0f1c629701142add75982f80d01138b29c::StockContract {
    use std::vector;
    use std::signer;
    use std::option;

    // Struct to represent a Stock
    struct Stock has key {
        id: u64,
        name: vector<u8>,  // Changed from string to vector<u8>
        price: u64,
        quantity: u64,
    }

    // Struct to represent the account that holds stocks
    struct StockAccount has key {
        stocks: vector<Stock>,
    }

    // Function to create a new stock account
    public fun create_stock_account(signer: &signer) {
        let account = StockAccount {
            stocks: vector::empty<Stock>(),
        };
        move_to(signer, account);
    }

    // Function to create a new stock
    public fun create_stock(signer: &signer, id: u64, name: vector<u8>, price: u64, quantity: u64) {
        let stock = Stock {
            id: id,
            name: name,
            price: price,
            quantity: quantity,
        };

        // Store the stock in the account's storage
        let stock_account = borrow_global_mut<StockAccount>(signer::address_of(signer));
        vector::push_back(&mut stock_account.stocks, stock);
    }

    // Function to retrieve all stocks for an account
    public fun get_stocks(signer: &signer): &mut vector<Stock> {
        let stock_account = borrow_global_mut<StockAccount>(signer::address_of(signer));
        &mut stock_account.stocks
    }

    // Function to get stock details by id
    public fun get_stock(signer: &signer, id: u64): option::Option<Stock> {
        let stocks = get_stocks(signer);
        let mut stock_opt: option::Option<Stock> = option::none();

        // Search for the stock by ID
        for stock in stocks {
            if (stock.id == id) {
                stock_opt = option::some(stock);
            }
        }

        stock_opt
    }

    // Function to update stock price
    public fun update_stock_price(signer: &signer, id: u64, new_price: u64) {
        let stocks = get_stocks(signer);
        
        for stock in stocks {
            if (stock.id == id) {
                stock.price = new_price;
                break;  // Optionally break once the stock is found and updated
            }
        }
    }

    // Function to update stock quantity
    public fun update_stock_quantity(signer: &signer, id: u64, new_quantity: u64) {
        let stocks = get_stocks(signer);
        
        for stock in stocks {
            if (stock.id == id) {
                stock.quantity = new_quantity;
                break;  // Optionally break once the stock is found and updated
            }
        }
    }
}