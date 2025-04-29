<template>
  <div class="min-h-screen w-screen bg-[#EFEEE5]">
    <!-- Header -->
    <header class="border-b border-gray-300 px-4 py-3">
      <div class="container mx-auto flex items-center justify-between">
        <div class="flex items-center gap-2">
          <div class="h-10 w-10 rounded-full bg-green-100"></div>
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
        <Button
          @click="
            isConnected
              ? open({ view: 'Account' })
              : open({ view: 'Connect', namespace: 'eip155' })
          "
          class="rounded-full bg-green-900 px-4 py-2 text-white hover:bg-green-800"
        >
          {{ isConnected ? walletAddress : 'Connect Wallet' }}
        </Button>
      </div>
    </header>

    <!-- Main Content -->
    <main class="container mx-auto px-4 py-8">
      <div class="grid gap-8 md:grid-cols-2">
        <!-- Left Column - Info -->
        <div class="space-y-6">
          <div class="flex items-center gap-4">
            <div>
              <h2 class="text-4xl font-bold text-green-900">Community</h2>
              <div class="flex items-center">
                <span class="text-4xl font-bold text-green-900">Grocery</span>
                <span
                  class="ml-2 rounded bg-green-900 px-3 py-1 text-xl font-bold text-white"
                  >Store</span
                >
              </div>
            </div>
            <div class="h-16 w-1 bg-green-900" />
            <div>
              <h3 class="text-2xl font-bold text-green-900">Crypto</h3>
              <h3 class="text-2xl font-bold text-green-900">Token Presale</h3>
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
              class="flex items-center gap-2 border-green-900 bg-transparent hover:bg-green-50 text-green-900 rounded-full"
            >
              Strategy
              <ArrowUpRight class="h-4 w-4" />
            </Button>
            <Button
              variant="outline"
              class="flex items-center gap-2 border-green-900 bg-transparent hover:bg-green-50 text-green-900 rounded-full"
            >
              Incentives
              <ArrowUpRight class="h-4 w-4" />
            </Button>
            <Button
              variant="outline"
              class="flex items-center gap-2 border-green-900 bg-transparent hover:bg-green-50 text-green-900 rounded-full"
            >
              Revenue
              <ArrowUpRight class="h-4 w-4" />
            </Button>
            <Button
              variant="outline"
              class="flex items-center gap-2 border-green-900 bg-transparent hover:bg-green-50 text-green-900 rounded-full"
            >
              Tokenomics
              <ArrowUpRight class="h-4 w-4" />
            </Button>
            <Button
              variant="outline"
              class="flex items-center gap-2 border-green-900 bg-transparent hover:bg-green-50 text-green-900 rounded-full"
            >
              Timeline
              <ArrowUpRight class="h-4 w-4" />
            </Button>
          </div>

          <div class="flex items-center justify-between">
            <div>
              <h4 class="mb-2 text-green-900">Socials</h4>
              <div class="flex gap-2">
                <Button
                  variant="outline"
                  class="h-10 w-10 rounded-md bg-green-900 p-0 text-white"
                >
                  <Send class="h-5 w-5" />
                </Button>
                <Button
                  variant="outline"
                  class="h-10 w-10 rounded-md bg-green-900 p-0 text-white"
                >
                  <Send class="h-5 w-5" />
                </Button>
                <Button
                  variant="outline"
                  class="h-10 w-10 rounded-md bg-green-900 p-0 text-white"
                >
                  <Twitter class="h-5 w-5" />
                </Button>
                <Button
                  variant="outline"
                  class="h-10 w-10 rounded-md bg-green-900 p-0 text-white"
                >
                  <Youtube class="h-5 w-5" />
                </Button>
              </div>
            </div>

            <div>
              <h4 class="mb-2 text-green-900">Get the app!</h4>
              <div class="flex gap-4">
                <div class="h-10 w-32 rounded-md bg-gray-200"></div>
                <div class="h-10 w-32 rounded-md bg-gray-200"></div>
              </div>
            </div>
          </div>
        </div>

        <!-- Right Column - Swap Interface -->
        <div class="flex items-center justify-center">
          <Card class="w-full max-w-md border-gray-300 bg-[#E8E6DB] p-6">
            <CardContent class="p-0">
              <div class="mb-6 flex flex-col items-center">
                <div class="mb-2 h-16 w-16 rounded-full bg-green-100"></div>
                <h3 class="text-xl font-bold text-green-900">Acquire $CGS</h3>
                <p class="text-sm text-green-700">Crypto Token Presale</p>
              </div>

              <div class="mb-6 grid grid-cols-2 gap-2">
                <div class="rounded-lg border-gray-300 bg-gray-50 p-3">
                  <p class="text-xs text-green-700">Initial Presale Price</p>
                  <p class="text-lg font-bold text-green-900">$0.04</p>
                </div>
                <div class="rounded-lg border-gray-300 bg-gray-50 p-3">
                  <p class="text-xs text-green-700">Public Uniswap Launch</p>
                  <p class="text-lg font-bold text-green-900">$0.08</p>
                </div>
              </div>

              <div class="mb-4 grid grid-cols-2 gap-4">
                <Button
                  :class="[
                    'flex items-center justify-center gap-2 rounded-md py-3',
                    selectedToken === 'USDT'
                      ? 'bg-green-900 text-white hover:bg-green-900'
                      : 'bg-transparent border-green-700 text-green-900 border  hover:border-green-900 hover:bg-transparent'
                  ]"
                  @click="selectedToken = 'USDT'"
                >
                  <CircleDollarSign class="h-5 w-5" />
                  USDT
                </Button>
                <Button
                  :class="[
                    'flex items-center justify-center gap-2 rounded-md py-3',
                    selectedToken === 'USDC'
                      ? 'bg-green-900 text-white hover:bg-green-900'
                      : 'bg-transparent border-green-700 text-green-900 border  hover:border-green-900 hover:bg-transparent'
                  ]"
                  @click="selectedToken = 'USDC'"
                >
                  <CircleDollarSign class="h-5 w-5" />
                  USDC
                </Button>
              </div>

              <div class="mb-1 text-right text-xs text-green-700">
                Need Wallet?
                <span class="cursor-pointer font-bold text-green-900">↗</span>
              </div>

              <div class="mb-4 rounded-md border-gray-300 bg-gray-50 p-4">
                <div class="mb-1 flex items-center justify-between">
                  <span class="text-sm text-green-700"
                    >You pay ({{ selectedToken }})</span
                  >
                  <div class="flex items-center gap-1 text-sm text-green-900">
                    <CircleDollarSign class="h-4 w-4" />
                    USDT
                  </div>
                </div>
                <Input
                  v-model="payAmount"
                  type="number"
                  class="border-none shadow-none text-xl font-bold text-green-900 focus-visible:ring-0"
                  placeholder="0.00"
                />
              </div>

              <div class="mb-6 rounded-md border-gray-300 bg-gray-50 p-4">
                <div class="mb-1 flex items-center justify-between">
                  <span class="text-sm text-green-700">You receive</span>
                  <div class="flex items-center gap-1 text-sm text-green-900">
                    <CircleDollarSign class="h-4 w-4" />
                    CGS
                  </div>
                </div>
                <div class="text-xl font-bold text-green-900">
                  {{ receiveAmount }}
                </div>
              </div>

              <Button
                @click="isConnected ? swap() : open()"
                class="w-full bg-green-900 py-3 text-white hover:bg-green-800 rounded-full"
              >
                {{ isConnected ? 'Swap' : 'Connect Wallet' }}
              </Button>

              <div class="mt-4 text-center text-xs text-green-700">
                <span class="cursor-pointer">Disclaimer</span>
              </div>
            </CardContent>
          </Card>
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
import { ref, computed } from 'vue'
import { useAccount } from '@wagmi/vue'
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import {
  ArrowUpRight,
  CircleDollarSign,
  Send,
  Twitter,
  Youtube
} from 'lucide-vue-next'
import { abbreviateAddress } from '@/utils'
import { useAppKit } from '@reown/appkit/vue'

// Wallet connection with @wagmi/vue
const { address, isConnected } = useAccount()
const { open } = useAppKit()

// Swap state
const selectedToken = ref('USDT')
const payAmount = ref('100')
const receiveAmount = computed(() => {
  if (!payAmount.value) return '0'
  return (parseFloat(payAmount.value) / 0.04).toFixed(2)
})

const walletAddress = computed(() =>
  address.value ? abbreviateAddress({ address: address.value }) : ''
)

// Swap function
const swap = async () => {
  // This would integrate with @reown/appkit for the actual swap
  console.log(
    `Swapping ${payAmount.value} ${selectedToken.value} for ${receiveAmount.value} CGS`
  )
  alert(`Swap successful! You received ${receiveAmount.value} CGS`)
}
</script>
