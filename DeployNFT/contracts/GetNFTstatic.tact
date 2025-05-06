message(0x2fcb26a2) NFTGetStaticData {
    queryId: Int as uint64;
}

message(0x8b771735) NFTReportStaticData {
    queryId: Int as uint64;
    index: Int as uint256;
    collection: Address;
}

struct NFTItemInitData {
    index: Int as uint64;
    collectionAddress: Address;
}

inline fun calculateNFTAddress(index: Int, collectionAddress: Address, nftCode: Cell): Address {
    let initData = NFTItemInitData {
        index,
        collectionAddress,
    };

    return contractAddress(StateInit { code: nftCode, data: initData.toCell() });
}

contract Example {
    nftCollectionAddress: Address;
    nftItemIndex: Int as uint64;
    nftCode: Cell;

    init(nftCollectionAddress: Address, nftItemIndex: Int, nftCode: Cell) {
        self.nftCollectionAddress = nftCollectionAddress;
        self.nftItemIndex = nftItemIndex;
        self.nftCode = nftCode;
    }

    // Empty receiver for the deployment,
    // which forwards the remaining value back to the sender
    receive() { cashback(sender()) }

    // ... add more code from previous examples ...

    receive("get static data") {
        // FIXME: Put proper address("[NFT_ADDRESS]") here
        let nftAddress = sender();
        send(SendParameters {
            to: nftAddress,
            value: ton("0.1"),
            body: NFTGetStaticData {
                queryId: 42,
            }.toCell(),
        });
    }

    receive(msg: NFTReportStaticData) {
        let expectedNftAddress = calculateNFTAddress(msg.index, msg.collection, self.nftCode);
        require(expectedNftAddress == sender(), "NFT contract is not the sender");

        // Save NFT static data or do something
    }
}