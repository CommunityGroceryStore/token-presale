<template>
  <Card class="w-full max-w-md border-gray-300 bg-[#E8E6DB] p-6 min-h-full">
    <CardContent class="p-0">
      <div class="mb-6 flex flex-col items-center">
        <div class="mb-2 h-16 w-16 rounded-full bg-green-100">
          <img
            src="/cgs.png"
            alt="CGS Logo"
            class="h-full w-full rounded-full"
          />
        </div>
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

      <template v-if="!isPresalePausedPending && !isPresalePaused">
        <div class="mb-4 grid grid-cols-2 gap-4">
          <Button
            :class="[
              'flex items-center justify-center gap-2 rounded-md py-3 cursor-pointer',
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
              'flex items-center justify-center gap-2 rounded-md py-3 cursor-pointer',
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

        <div class="mb-4 rounded-md border-gray-300 bg-gray-50 p-4">
          <div class="mb-1 flex items-center justify-between">
            <span class="text-sm text-green-700"
              >You pay</span
            >
            <div class="flex items-center gap-1 text-sm text-green-900">
              Balance: {{ selectedTokenBalanceFormatted }}
              <CircleDollarSign class="h-4 w-4" />
              {{ selectedToken }}
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
              <a
                class="underline cursor-pointer"
                @click="emit('balance-clicked')"
              >
                Balance (Incl. Vested):
              </a>{{ cgsBalanceFormatted }}
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
          class="
            w-full
            bg-green-900
            py-3
            text-white
            hover:bg-green-800
            rounded-full
            cursor-pointer
          "
          :disabled="!isConnected || isSwapping"
          :class="isSwapping ? 'opacity-50 cursor-not-allowed' : ''"
        >
          <LoaderCircle v-if="isSwapping" class="animate-spin h-5 w-5 mr-2" />
          {{ isConnected ? 'Swap' : 'Connect Wallet' }}
        </Button>
      </template>
      <div
        v-else-if="isPresalePausedPending"
        class="mb-4 rounded-md border-gray-300 bg-gray-50 p-4"
      >
        <p class="text-lg font-bold text-center text-green-900">
          Checking presale status...
        </p>
      </div>
      <div v-else class="mb-4 rounded-md border-gray-300 bg-gray-50 p-4">
        <p class="text-lg font-bold text-center text-green-900">
          Presale is not live yet!
        </p>
      </div>

      <div
        v-if="feedbackMessage"
        class="my-4 rounded-md border-gray-300 bg-gray-50 p-4"
      >
        <p class="text-lg font-bold text-center text-green-900">
          {{ feedbackMessage }}
        </p>
        <p
          v-if="feedbackMessageTxHash"
          class="text-sm text-green-700 text-right"
        >
          <a
            :href="`${etherscanUrl}/tx/${feedbackMessageTxHash}`"
            target="_blank"
            rel="noopener noreferrer"
            class="cursor-pointer underline flex items-center justify-center"
          >
            View Transaction
            <ArrowUpRight class="h-3 w-3" />            
          </a>
        </p>
      </div>

      <div class="mt-4 text-center text-xs text-green-700">
        <span class="cursor-pointer">Disclaimer</span>
      </div>
    </CardContent>
  </Card>
</template>

<script lang="ts" setup>
import { useAppKit } from '@reown/appkit/vue'
import { useStorage } from '@vueuse/core'
import {
  useAccount,
  useChainId,
  useReadContract,
  useWriteContract
} from '@wagmi/vue'
import { mainnet } from '@wagmi/vue/chains'
import { ArrowUpRight, CircleDollarSign, LoaderCircle } from 'lucide-vue-next'
import { computed, defineEmits, ref } from 'vue'
import { ethers } from 'ethers'

import {
  cgsTokenPresaleAbi,
  cgsVestingAbi,
  erc20Abi
} from '@/assets/contract-artifacts/wagmi-generated'
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { Input } from '@/components/ui/input'

const emit = defineEmits(['balance-clicked'])
const { address, isConnected } = useAccount()
const chainId = useChainId()
const { open } = useAppKit()
const { writeContractAsync } = useWriteContract()
const tokenContractAddress = useStorage<`0x${string}`>(
  'VITE_CGS_TOKEN_CONTRACT_ADDRESS',
  import.meta.env.VITE_CGS_TOKEN_CONTRACT_ADDRESS as `0x${string}`
)
const vestingContractAddress = useStorage<`0x${string}`>(
  'VITE_CGS_VESTING_CONTRACT_ADDRESS',
  import.meta.env.VITE_CGS_VESTING_CONTRACT_ADDRESS as `0x${string}`
)
const presaleContractAddress = useStorage<`0x${string}`>(
  'VITE_CGS_PRESALE_CONTRACT_ADDRESS',
  import.meta.env.VITE_CGS_PRESALE_CONTRACT_ADDRESS as `0x${string}`
)
const usdcContractAddress = useStorage<`0x${string}`>(
  'VITE_USDC_CONTRACT_ADDRESS',
  import.meta.env.VITE_USDC_CONTRACT_ADDRESS as `0x${string}`
)
const usdtContractAddress = useStorage<`0x${string}`>(
  'VITE_USDT_CONTRACT_ADDRESS',
  import.meta.env.VITE_USDT_CONTRACT_ADDRESS as `0x${string}`
)
const feedbackMessage = ref<string | null>(null)
const feedbackMessageTxHash = ref<string | null>(null)
const selectedToken = ref('USDT')
const payAmount = ref('100')
const isSwapping = ref(false)
const etherscanUrl = chainId.value === mainnet.id
  ? 'https://etherscan.io'
  : 'https://sepolia.etherscan.io'
const receiveAmount = computed(() => {
  if (!payAmount.value) return '0'
  return (parseFloat(payAmount.value) / 0.04).toFixed(2)
})
const selectedTokenBalance = computed(() => {
  if (selectedToken.value === 'USDT') {
    return usdtBalance.value ? usdtBalance.value.toString() : '0'
  } else if (selectedToken.value === 'USDC') {
    return usdcBalance.value ? usdcBalance.value.toString() : '0'
  }
  return '0'
})
const selectedTokenBalanceFormatted = computed(() => {
  if (!address.value) { return '---' }

  return selectedTokenBalance.value
    ? parseFloat(ethers.formatUnits(selectedTokenBalance.value, 6))
        .toLocaleString('en-US', {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2
        })
    : '0.00'
})
const cgsBalanceFormatted = computed(() => {
  if (!address.value) { return '---' }

  const holdingBalance = cgsBalance.value ? cgsBalance.value : 0n
  const cgsVestedBalance = cgsVestingSchedule.value
    ? cgsVestingSchedule.value[0]
    : 0n
  const totalCgsBalance = holdingBalance + cgsVestedBalance

  return totalCgsBalance
    ? parseFloat(ethers.formatUnits(totalCgsBalance.toString(), 18))
        .toLocaleString('en-US', {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2
        })
    : '0.00'
})
const {
  data: isPresalePaused,
  isPending: isPresalePausedPending
} = useReadContract({
  address: presaleContractAddress.value,
  abi: cgsTokenPresaleAbi,
  functionName: 'isPresalePaused' as const,
  query: {
    enabled: computed(() => !!presaleContractAddress.value)
  }
})
const {
  data: usdcBalance,
  refetch: refetchUsdcBalance
} = useReadContract({
  address: usdcContractAddress.value,
  abi: erc20Abi,
  functionName: 'balanceOf' as const,
  args: [ computed(() => address.value!) ],
  query: {
    enabled: computed(() => !!usdcContractAddress.value && !!address.value)
  }
})
const {
  data: usdcPresaleContractAllowance,
  refetch: refetchUsdcPresaleContractAllowance
} = useReadContract({
  address: usdcContractAddress.value,
  abi: erc20Abi,
  functionName: 'allowance' as const,
  args: [computed(() => address.value!), presaleContractAddress.value],
  query: {
    enabled: computed(() => !!address.value && !!usdcContractAddress.value)
  }
})
const {
  data: usdtBalance,
  refetch: refetchUsdtBalance
} = useReadContract({
  address: usdtContractAddress.value,
  abi: erc20Abi,
  functionName: 'balanceOf' as const,
  args: [ computed(() => address.value!) ],
  query: {
    enabled: computed(() => !!usdtContractAddress.value && !!address.value)
  }
})
const {
  data: usdtPresaleContractAllowance,
  refetch: refetchUsdtPresaleContractAllowance
} = useReadContract({
  address: usdtContractAddress.value,
  abi: erc20Abi,
  functionName: 'allowance' as const,
  args: [computed(() => address.value!), presaleContractAddress.value],
  query: {
    enabled: computed(() => !!address.value && !!usdtContractAddress.value)
  }
})
const {
  data: cgsBalance,
  refetch: refetchCgsBalance
} = useReadContract({
  address: tokenContractAddress.value,
  abi: erc20Abi,
  functionName: 'balanceOf' as const,
  args: [ computed(() => address.value!) ],
  query: {
    enabled: computed(() => !!tokenContractAddress.value && !!address.value)
  }
})
const {
  data: cgsVestingSchedule,
  refetch: refetchCgsVestingSchedule
} = useReadContract({
  address: vestingContractAddress.value,
  abi: cgsVestingAbi,
  functionName: 'vestingSchedules' as const,
  args: [ computed(() => address.value!) ],
  query: {
    enabled: computed(() => !!tokenContractAddress.value && !!address.value)
  }
})
const swap = async () => {
  if (!isConnected.value) {
    console.error('Wallet not connected')
    return
  }
  if (!presaleContractAddress.value) {
    console.error('Presale contract address not set')
    return
  }
  if (!payAmount.value || parseFloat(payAmount.value) <= 0) {
    alert('Please enter a valid amount to swap')
    return
  }
  if (isSwapping.value) {
    console.warn('Swap already in progress')
    return
  }
  isSwapping.value = true
  const atomicPayAmount = ethers.parseUnits(
    payAmount.value.toString(),
    6
  )
  const paymentTokenAddress =
    selectedToken.value === 'USDT'
      ? usdtContractAddress.value
      : usdcContractAddress.value
  console.log(
    `Swapping ${payAmount.value} [${atomicPayAmount}] ` +
      `${selectedToken.value} [${paymentTokenAddress}] ` +
      `for ${receiveAmount.value} $CGS`
  )
  try {
    const allowance = selectedToken.value === 'USDT'
      ? usdtPresaleContractAllowance.value
      : usdcPresaleContractAllowance.value
    if (!allowance || allowance < atomicPayAmount) {
      console.log(
        `Insufficient allowance for ${selectedToken.value}. ` +
        `Current allowance: ${allowance}, required: ${atomicPayAmount}`
      )
    }
    const remainingToApprove = allowance
      ? atomicPayAmount - allowance
      : atomicPayAmount
    if (remainingToApprove > 0n) {
      const approvalTxHash = await writeContractAsync({
        address: paymentTokenAddress,
        abi: erc20Abi,
        functionName: 'approve' as const,
        args: [presaleContractAddress.value, remainingToApprove]
      })
      console.log(`Approval transaction hash: ${approvalTxHash}`)
    }

    const txHash = await writeContractAsync({
      address: presaleContractAddress.value,
      abi: cgsTokenPresaleAbi,
      functionName: 'buy' as const,
      args: [
        atomicPayAmount,
        paymentTokenAddress
      ]
    })
    console.log(`Swap transaction hash: ${txHash}`)

    feedbackMessage.value = `Swap successful! `
      + `You received ${receiveAmount.value} $CGS!`
    feedbackMessageTxHash.value = txHash
  } catch (error) {
    console.error('Error during swap:', error)
  } finally {
    console.log('Refetching balances...')
    await refetchCgsBalance()
    await refetchCgsVestingSchedule()
    if (selectedToken.value === 'USDT') {
      await refetchUsdtBalance()
      await refetchUsdtPresaleContractAllowance()
    } else if (selectedToken.value === 'USDC') {
      await refetchUsdcBalance()
      await refetchUsdcPresaleContractAllowance()
    }    

    isSwapping.value = false
  }
}
</script>
