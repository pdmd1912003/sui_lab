module 0x0::my_nft {

    use std::string::{Self,String};
    use sui::url::{Self,Url};
    public struct GitNFT has key, store {
        id: UID,
        name:String,
        image_url:Url,
        creator: address
    }

    fun init(ctx: &mut TxContext){
        let obj = GitNFT {
            id: object::new(ctx),
            name: b"Pdwcs".to_string(),
            image_url: url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2000614090507497486/t976-LdN_400x400.jpg"),
            creator: ctx.sender()
        };

        transfer::transfer(obj, ctx.sender());

    }

    public entry fun mint(ctx: &mut TxContext){
        transfer::transfer(GitNFT{
             id: object::new(ctx),
            name: b"Pdwcs".to_string(),
            image_url: url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2000614090507497486/t976-LdN_400x400.jpg"),
            creator: ctx.sender()
            },
        ctx.sender()
        );
    }
}