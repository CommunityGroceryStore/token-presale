<template>
  <div class="flex min-h-screen ">
    <Main class="bg-[url('/images/indexbgimg.png')] bg-contain bg-bottom bg-no-repeat object-cover" />
  </div>
</template>

<style>
@import '@/style.css';
</style>

<script setup lang="ts">
import { createAppKit } from '@reown/appkit/vue'
// import { arbitrum, mainnet, sepolia } from '@reown/appkit/networks'
import { WagmiAdapter } from '@reown/appkit-adapter-wagmi'
import { networks } from '@/lib/wagmi/config'
import Main from './components/Main.vue'

const projectId = import.meta.env.VITE_REOWN_PROJECT_ID ?? ''

// 2. Create a metadata object - optional
const metadata = {
  name: 'erc20-presale',
  description: '',
  url: window.location.href,
  icons: ['https://assets.reown.com/reown-profile-pic.png']
}

// 3. Create Wagmi Adapter
const wagmiAdapter = new WagmiAdapter({
  networks,
  projectId
})

// 4. Create modal
createAppKit({
  adapters: [wagmiAdapter],
  networks: networks as any,
  metadata,
  projectId,
  features: {
    connectMethodsOrder: ['wallet', 'email', 'social']
  }
})
</script>
