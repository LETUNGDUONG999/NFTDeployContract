message(0x5fcc3d14) NFTTransfer {
    queryId: Int as uint64;
    newOwner: Address; // Address of the new owner of the NFT item.
    responseDestination: Address; // Address to send a response confirming a successful transfer and the remaining incoming message coins.
    customPayload: Cell? = null; // Optional custom data. In most cases, this should be null.
    forwardAmount: Int as coins; // The amount of nanotons to be sent to the new owner.
    forwardPayload: Slice as remaining; // Optional custom data that should be sent to the new owner.
}

contract Example {
    nftItemAddress: Address;

    init(nftItemAddress: Address) {
        self.nftItemAddress = nftItemAddress;
    }

    // Empty receiver for the deployment,
    // which forwards the remaining value back to the sender
    receive() { cashback(sender()) }

    // ... add more code from previous examples ...

    receive("transfer") {
        send(SendParameters {
            to: self.nftItemAddress,
            value: ton("0.1"),
            body: NFTTransfer {
                queryId: 42,
                // FIXME: Change this according to your needs.
                newOwner: sender(),
                responseDestination: myAddress(),
                customPayload: null,
                forwardAmount: 1,
                forwardPayload: rawSlice("F"), // Precomputed beginCell().storeUint(0xF, 4).endCell().beginParse()
            }.toCell(),
        });
    }
}