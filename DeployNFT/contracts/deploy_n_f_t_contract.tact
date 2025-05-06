message(0x1) NFTDeploy {
    queryId: Int as uint64;
    itemIndex: Int as uint64;
    amount: Int as coins; // amount to send when deploying NFT
    nftContent: Cell;
}

contract Example {
    nftCollectionAddress: Address;

    init(nftCollectionAddress: Address) {
        self.nftCollectionAddress = nftCollectionAddress;
    }

    // Empty receiver for the deployment,
    // which forwards the remaining value back to the sender
    receive() { cashback(sender()) }

    // ... add more code from previous examples ...

    receive("deploy") {
        send(SendParameters {
            to: self.nftCollectionAddress,
            value: ton("0.14"),
            body: NFTDeploy {
                queryId: 42,
                itemIndex: 42,
                amount: ton("0.1"),
                nftContent: beginCell().endCell(), // FIXME: Replace with your content, usually generated off-chain
            }.toCell(),
        });
    }
}