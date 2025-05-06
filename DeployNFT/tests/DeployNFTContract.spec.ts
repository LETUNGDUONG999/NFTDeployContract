import { Blockchain, SandboxContract, TreasuryContract } from '@ton/sandbox';
import { toNano } from '@ton/core';
import { DeployNFTContract } from '../wrappers/DeployNFTContract';
import '@ton/test-utils';

describe('DeployNFTContract', () => {
    let blockchain: Blockchain;
    let deployer: SandboxContract<TreasuryContract>;
    let deployNFTContract: SandboxContract<DeployNFTContract>;

    beforeEach(async () => {
        blockchain = await Blockchain.create();

        deployNFTContract = blockchain.openContract(await DeployNFTContract.fromInit());

        deployer = await blockchain.treasury('deployer');

        const deployResult = await deployNFTContract.send(
            deployer.getSender(),
            {
                value: toNano('0.05'),
            },
            null,
        );

        expect(deployResult.transactions).toHaveTransaction({
            from: deployer.address,
            to: deployNFTContract.address,
            deploy: true,
            success: true,
        });
    });

    it('should deploy', async () => {
        // the check is done inside beforeEach
        // blockchain and deployNFTContract are ready to use
    });
});
