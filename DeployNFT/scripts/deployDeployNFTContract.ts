import { toNano } from '@ton/core';
import { DeployNFTContract } from '../wrappers/DeployNFTContract';
import { NetworkProvider } from '@ton/blueprint';

export async function run(provider: NetworkProvider) {
    const deployNFTContract = provider.open(await DeployNFTContract.fromInit());

    await deployNFTContract.send(
        provider.sender(),
        {
            value: toNano('0.05'),
        },
        null,
    );

    await provider.waitForDeploy(deployNFTContract.address);

    // run methods on `deployNFTContract`
}
