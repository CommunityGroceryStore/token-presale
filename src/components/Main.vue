<template>
  <div class="min-h-screen w-screen bg-[#EFEEE5]">
    <!-- Header -->
    <header class="border-b border-gray-300 px-4 py-3">
      <div class="container mx-auto flex items-center justify-between">
        <div class="flex items-center gap-2">
          <div class="h-10 w-10 rounded-full bg-green-100">
            <img src="/cgs.png" alt="CGS Logo" class="h-full w-full rounded-full" />
          </div>
          <div>
            <h1 class="font-bold text-green-900">Community</h1>
            <div class="flex items-center">
              <span class="font-bold text-green-900">Grocery</span>
              <span
                class="ml-1 rounded bg-green-900 px-2 py-0.5 text-xs font-bold text-white"
                >Store</span
              >
            </div>
          </div>
        </div>

        <div>
          <template v-if="isConnected">
            <Button
              @click="tab = 'presale'"
              class="
                rounded-full
                bg-green-900
                mr-2
                px-4
                py-2
                text-white
                hover:bg-green-800
                cursor-pointer
              "
              :class="tab === 'presale' ? 'bg-green-700' : ''"
            >Presale</Button>
            <Button
              @click="tab = 'cgs-balance'"
              class="
                rounded-full
                bg-green-900
                mr-2
                px-4
                py-2
                text-white
                hover:bg-green-800
                cursor-pointer
              "
              :class="tab === 'cgs-balance' ? 'bg-green-700' : ''"
            >My $CGS</Button>
          </template>

          <Button
            @click="
              isConnected
                ? open({ view: 'Account' })
                : open({ view: 'Connect', namespace: 'eip155' })
            "
            class="
              rounded-full
              bg-green-900
              px-4 py-2
              text-white
              hover:bg-green-800
              cursor-pointer
            "
          >
            {{ isConnected ? walletAddress : 'Connect Wallet' }}
          </Button>
        </div>
      </div>
    </header>

    <!-- Main Content -->
    <main class="container mx-auto px-4 py-8">
      <div class="grid gap-8 lg:grid-cols-2">
        <!-- Left Column - Info -->
        <div class="space-y-6">
          <div class="flex items-center gap-4">
            <div>
              <h2
                class="text-2xl md:text-3xl lg:text-4xl font-bold text-green-900"
              >
                Community
              </h2>
              <div class="flex items-center">
                <span
                  class="text-2xl md:text-3xl lg:text-4xl font-bold text-green-900"
                  >Grocery</span
                >
                <span
                  class="ml-2 mt-2 rounded bg-green-900 px-3 py-1 text-md md:text-lg lg:text-xl font-bold text-white"
                  >Store</span
                >
              </div>
            </div>
            <div class="h-16 w-1 bg-green-900" />
            <div>
              <h3 class="text-xl md:text-2xl font-bold text-green-900">
                $CGS Token Presale
              </h3>
            </div>
          </div>

          <div class="space-y-4 text-green-900">
            <p>
              We've opened an exclusive seed round for individuals and
              institutions interested in becoming early adopters and initial
              holders of CGS.
            </p>

            <p>
              At CGS, we are deeply committed to a fair launch approach.
              Therefore, this seed allocation represents only a small portion of
              the total tokens available for public acquisition. Additionally,
              to support long-term market stability, all tokens obtained during
              this presale will be subject to strict vesting schedules.
            </p>

            <p>
              Once the early adopter allocation has been fully distributed, the
              next available opportunity to obtain CGS tokens will be during our
              public launch on Uniswap, where tokens will be offered at our
              initial launch price of $0.08 per token.
            </p>

            <p>
              Holding CGS tokens is required for participation in DAO governance
              decisions and to qualify for holder- exclusive incentives and
              rewards.
            </p>
          </div>

          <div class="flex flex-wrap gap-3">
            <Button
              variant="default"
              class="flex items-center gap-2 bg-green-900 hover:bg-green-800 rounded-full"
            >
              <svg
                :width="12"
                :height="12"
                viewBox="0 0 100 100"
                xmlns="http://www.w3.org/2000/svg"
                class="fill-white"
              >
                <circle cx="50" cy="50" r="50" />
              </svg>
              Litepaper
            </Button>
            <Button
              variant="outline"
              class="flex items-center gap-2 border-green-900 bg-transparent hover:bg-stone-200/50 text-green-900 rounded-full"
            >
              Strategy
              <ArrowUpRight class="h-4 w-4" />
            </Button>
            <Button
              variant="outline"
              class="flex items-center gap-2 border-green-900 bg-transparent hover:bg-stone-200/50 text-green-900 rounded-full"
            >
              Incentives
              <ArrowUpRight class="h-4 w-4" />
            </Button>
            <Button
              variant="outline"
              class="flex items-center gap-2 border-green-900 bg-transparent hover:bg-stone-200/50 text-green-900 rounded-full"
            >
              Revenue
              <ArrowUpRight class="h-4 w-4" />
            </Button>
            <Button
              variant="outline"
              class="flex items-center gap-2 border-green-900 bg-transparent hover:bg-stone-200/50 text-green-900 rounded-full"
            >
              Tokenomics
              <ArrowUpRight class="h-4 w-4" />
            </Button>
            <Button
              variant="outline"
              class="flex items-center gap-2 border-green-900 bg-transparent hover:bg-stone-200/50 text-green-900 rounded-full"
            >
              Timeline
              <ArrowUpRight class="h-4 w-4" />
            </Button>
          </div>

          <div
            class="flex flex-col lg:flex-row lg:items-center justify-between gap-8"
          >
            <div>
              <h4 class="mb-2 text-green-900">Socials</h4>
              <div class="flex gap-2">
                <Button
                  variant="outline"
                  class="h-10 w-10 rounded-md bg-green-900 hover:bg-green-800 hover:text-white p-0 text-white"
                >
                  <Send class="h-5 w-5" />
                </Button>
                <Button
                  variant="outline"
                  class="h-10 w-10 rounded-md bg-green-900 hover:bg-green-800 hover:text-white p-0 text-white"
                >
                  <Send class="h-5 w-5" />
                </Button>
                <Button
                  variant="outline"
                  class="h-10 w-10 rounded-md bg-green-900 hover:bg-green-800 hover:text-white p-0 text-white"
                >
                  <Twitter class="h-5 w-5" />
                </Button>
                <Button
                  variant="outline"
                  class="h-10 w-10 rounded-md bg-green-900 hover:bg-green-800 hover:text-white p-0 text-white"
                >
                  <Youtube class="h-5 w-5" />
                </Button>
              </div>
            </div>

            <div>
              <h4 class="mb-2 text-green-900">Get the app!</h4>
              <div class="flex gap-4">
                <a href="#">
                  <img width="140" src="/images/google-play-icon.svg" alt="" />
                </a>
                <a href="#">
                  <img width="140" src="/images/app-store-icon.svg" alt="" />
                </a>
              </div>
            </div>
          </div>
        </div>

        <!-- Right Column - Swap Interface -->
        <div class="flex  justify-center">
          <CGSBalanceCard
            v-if="tab === 'cgs-balance'"
            @back-to-presale-clicked="tab = 'presale'"
          />
          <PresaleCard
            v-else
            @balance-clicked="tab = 'cgs-balance'"
          />
        </div>
      </div>
    </main>

    <footer class="my-auto text-center text-sm text-green-700">
      <a
        href="#"
        class="flex items-center justify-center gap-1 hover:text-green-900"
      >
        communitygrocerystore.com
        <ArrowUpRight class="h-3 w-3" />
      </a>
    </footer>
  </div>
</template>

<script lang="ts" setup>
import { computed, ref } from 'vue'
import { useAccount } from '@wagmi/vue'
import {
  ArrowUpRight,
  Send,
  Twitter,
  Youtube
} from 'lucide-vue-next'
import { useAppKit } from '@reown/appkit/vue'

import CGSBalanceCard from './CGSBalanceCard.vue'
import PresaleCard from './PresaleCard.vue'
import { Button } from '@/components/ui/button'
import { abbreviateAddress } from '@/utils'

const { address, isConnected } = useAccount()
const { open } = useAppKit()
const walletAddress = computed(() =>
  address.value ? abbreviateAddress({ address: address.value }) : ''
)
const tab = ref('presale')
</script>
