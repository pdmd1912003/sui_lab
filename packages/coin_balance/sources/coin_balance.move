module coin_balance::coin_balance;

use sui::balance::{Self, Balance};
use sui::sui::SUI;
use sui::coin::Coin;
public struct Vault has key, store {
    id:UID,
    balance: Balance<SUI>,
    owner: address
}
#[allow(lint(self_transfer))]
public fun create_vault(ctx: &mut TxContext) {
    let vault = Vault {
        id: object::new(ctx),
        balance: balance::zero<SUI>(),
        owner: ctx.sender(),
    };
    transfer::public_transfer(vault, ctx.sender());
}

public fun deposit(vault: &mut Vault, coin: Coin<SUI>) {
    let coin_balance = coin.into_balance();
    balance::join(&mut vault.balance, coin_balance);
    vault.balance.join(coin_balance);
}