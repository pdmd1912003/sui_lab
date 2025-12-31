/*
/// Module: my_faucet_coin
module my_faucet_coin::my_faucet_coin;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


module 0x0::my_faucet_coin {
    
    use sui::coin::{Self, TreasuryCap};
    use sui::tx_context::{Self,TxContext};
    use sui::transfer;

    //OTW
    public struct MY_FAUCET_COIN has drop {}

    fun init(witness: MY_FAUCET_COIN, ctx: &mut TxContext) {
        let (treasury, coinmetadata) = coin::create_currency(
            witness,
            5,
            b"PDWCSFAUCET",
            b"PDWCS FAUCET COIN",
            b"My faucet COIN",
            option::none(),
            ctx
        );
        transfer::public_freeze_object(coinmetadata);
        transfer::public_share_object(treasury);
    }

    public entry fun mint_token(treasury: &mut TreasuryCap<MY_FAUCET_COIN>, ctx: &mut TxContext) {
        let coin_object = coin::mint(treasury, 35000, ctx);
        transfer::public_transfer(coin_object, ctx.sender());
    }
}