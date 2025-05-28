# Requirements
Node 22+

# Install
`npm install`

# Add Contract ABIs
Copy contract ABIs and TypeScript bindings from the [CommunityGroceryStore/contracts](https://github.com/communitygrocerystore/contracts) repository:
```bash
git clone https://github.com/communitygrocerystore/contracts
cd contracts
npm install
npx hardhat compile
npx wagmi generate
npx tsx scripts/copy-contract-bytecode.ts
```
Copy the following files from:
`communitygrocerystore/contracts/artifacts/contract-bytecode.ts`
`communitygrocerystore/contracts/artifacts/wagmi-generated.ts`
To:
`communitygrocerystore/token-presale/src/assets/contract-artifacts`

# Configure Environment
Create an `.env` file in the `/src` directory with the following contents filled out appropriately:
```
VITE_EVM_NETWORK=
VITE_CGS_TOKEN_CONTRACT_ADDRESS=
VITE_CGS_PRESALE_CONTRACT_ADDRESS=
VITE_CGS_VESTING_CONTRACT_ADDRESS=
VITE_USDC_CONTRACT_ADDRESS=
VITE_USDT_CONTRACT_ADDRESS=
VITE_CGS_MULTISIG_ADDRESS=
```

# Vue 3 + TypeScript + Vite
This template should help get you started developing with Vue 3 and TypeScript in Vite. The template uses Vue 3 `<script setup>` SFCs, check out the [script setup docs](https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup) to learn more.
Learn more about the recommended Project Setup and IDE Support in the [Vue Docs TypeScript Guide](https://vuejs.org/guide/typescript/overview.html#project-setup).
