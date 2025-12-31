module 0x0::swap_program {

    use sui::balance::{Self as balance, Balance};
    use sui::coin::{Self as coin, Coin};
    use sui::object::{Self as object, UID};
    use sui::transfer;
    use sui::tx_context::TxContext;

    use 0x0::my_coin::MY_COIN;
    use 0x0::my_faucet_coin::MY_FAUCET_COIN;
    public struct Pool has key {    
        id:UID,
        my_coin:Balance<MY_COIN>,
        my_faucet_coin:Balance<MY_FAUCET_COIN>
    }

    fun init(ctx: &mut TxContext){
        let pool = Pool {
            id: object::new(ctx),
            my_coin:balance::zero<MY_COIN>(),
            my_faucet_coin:balance::zero<MY_FAUCET_COIN>()
        };
        transfer::share_object(pool);
    }

    entry fun add_money_to_pool(pool: &mut Pool, my_coin: Coin<MY_COIN>, my_faucet_coin: Coin<MY_FAUCET_COIN>){
        pool.my_coin.join(my_coin.into_balance());
        pool.my_faucet_coin.join(my_faucet_coin.into_balance());
    }

    public entry fun deposit_my_coin(pool: &mut Pool, user_coin: Coin<MY_COIN>, ctx: &mut TxContext){
        coin::put(&mut pool.my_coin,user_coin);
    }
    public entry fun deposit_my_faucet_coin(pool: &mut Pool, user_coin: Coin<MY_FAUCET_COIN>, ctx: &mut TxContext){
        coin::put(&mut pool.my_faucet_coin,user_coin);
    }

    public entry fun swap_my_coin_to_faucet_coin(pool: &mut Pool, my_coin: Coin<MY_COIN>, ctx: &mut TxContext) {
        let amount = my_coin.value();
        assert!(amount > 0, 0);

        pool.my_coin.join(my_coin.into_balance());
        let output_coin =coin::take(&mut pool.my_faucet_coin, amount, ctx);

        transfer::public_transfer(output_coin, ctx.sender());
    }

    public entry fun swap_faucet_coin_to_my_coin(pool: &mut Pool, my_coin: Coin<MY_FAUCET_COIN>, ctx: &mut TxContext) {
        let amount = my_coin.value();
        assert!(amount > 0, 0);

        pool.my_faucet_coin.join(my_coin.into_balance());
        let output_coin =coin::take(&mut pool.my_coin, amount, ctx);

        transfer::public_transfer(output_coin, ctx.sender());
    }

}

