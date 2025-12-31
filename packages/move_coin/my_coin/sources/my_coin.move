/*
/// Module: my_coin
module my_coin::my_coin;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


module 0x0::my_coin {
    
    use sui::coin::{Self, TreasuryCap};
    use sui::tx_context::{Self,TxContext};
    use sui::transfer;

    //OTW
    public struct MY_COIN has drop {}

    fun init(witness: MY_COIN, ctx: &mut TxContext) {
        let (treasury, coinmetadata) = coin::create_currency(
            witness,
            5,
            b"PDWCS",
            b"PDWCS COIN",
            b"My first COIN",
            option::none(),
            ctx
        );
        transfer::public_freeze_object(coinmetadata);
        transfer::public_transfer(treasury, ctx.sender());
    }

    public fun mint_token(treasury: &mut TreasuryCap<MY_COIN>, ctx: &mut TxContext) {
        let coin_object = coin::mint(treasury, 35000, ctx);
        transfer::public_transfer(coin_object, ctx.sender());
    }


}

//packageID: 0x3e5263cc83da71f8483335d08d0f830896ad3e5263b89f5a1c7aecfd95426683