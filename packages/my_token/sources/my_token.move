module my_token::my_token;

use sui::coin_registry;

public struct MY_TOKEN has drop {}

/// This is a token for testing purposes, used only on testnet.
fun init(witness: MY_TOKEN, ctx: &mut TxContext) {
    let (builder, treasury_cap) = coin_registry::new_currency_with_otw(
        witness,
        8, // Decimals
        b"MYT".to_string(),
        b"MYT".to_string(),
        b"Test MYT".to_string(),
        b"https://upload.wikimedia.org/wikipedia/commons/4/46/Bitcoin.svg".to_string(),
        ctx,
    );

    let metadata_cap = builder.finalize(ctx);

    transfer::public_transfer(treasury_cap, ctx.sender());
    transfer::public_transfer(metadata_cap, ctx.sender());
}
