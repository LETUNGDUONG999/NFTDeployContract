import { CompilerConfig } from '@ton/blueprint';

export const compile: CompilerConfig = {
    lang: 'tact',
    target: 'contracts/deploy_n_f_t_contract.tact',
    options: {
        debug: true,
    },
};
