message(0x05138d91) NFTOwnershipAssigned {
    queryId: Int as uint64;
    previousOwner: Address;
    forwardPayload: Slice as remaining;
}

contract SingleNft {
    nftItemAddress: Address;

    init(nftItemAddress: Address) {
        self.nftItemAddress = nftItemAddress;
    }

    // Empty receiver for the deployment,
    // which forwards the remaining value back to the sender
    receive() { cashback(sender()) }

    receive(msg: NFTOwnershipAssigned) {
        require(self.nftItemAddress == sender(), "NFT contract is not the sender");

        // your logic of processing NFT ownership assignment notification
    }
}