import { CompilerConfig } from '@ton/blueprint';

export const compile: CompilerConfig = {
    lang: 'tact',
    target: 'contracts/TransferNFT.tact',
    options: {
        debug: true,
    },
};
