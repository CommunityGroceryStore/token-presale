<template>
  <Card class="w-full max-w-md border-gray-300 bg-[#E8E6DB] p-6">
    <CardContent class="p-0">
      <div class="mb-6 flex flex-col items-center">
        <div class="mb-2 h-16 w-16 rounded-full bg-green-100">
          <img
            src="/cgs.png"
            alt="CGS Logo"
            class="h-full w-full rounded-full"
          />
        </div>
        <h3 class="text-xl font-bold text-green-900">My $CGS Balance</h3>
        <p class="text-sm text-green-700">Balance & Vesting Schedule</p>
      </div>

      <template v-if="isCgsVestingScheduleInitialized">
        <div class="mb-6">
          <div class="rounded-lg border-gray-300 bg-gray-50 p-3">
            <p class="text-xs text-green-700">Vesting Schedule Start</p>
            <p class="text-lg font-bold text-green-900 text-right">
              {{ cgsVestingScheduleStartFormatted }}
            </p>
          </div>
        </div>

        <div class="mb-6">
          <div class="rounded-lg border-gray-300 bg-gray-50 p-3">
            <p class="text-xs text-green-700">Vesting Schedule Cliff</p>
            <p class="text-lg font-bold text-green-900 text-right">
              {{ cgsVestingScheduleCliffFormatted }}
            </p>
          </div>
        </div>

        <div class="mb-6">
          <div class="rounded-lg border-gray-300 bg-gray-50 p-3">
            <p class="text-xs text-green-700">Vesting Schedule End</p>
            <p class="text-lg font-bold text-green-900 text-right">
              {{ cgsVestingScheduleEndFormatted }}
            </p>
          </div>
        </div>

        <div class="mb-6 grid grid-cols-2 gap-2">
          <div class="rounded-lg border-green-900 bg-green-900 p-3">
            <p class="text-xs text-white">$CGS Fully Vested as of now</p>
            <p class="text-lg font-bold text-white text-right">
              {{ cgsVestVestedAmountFormatted }}
            </p>
          </div>

          <div class="rounded-lg border-green-900 bg-green-900 p-3">
            <p class="text-xs text-white">
              $CGS Total Vest Size
            </p>
            <p class="text-lg font-bold text-white text-right">
              {{ cgsVestingScheduleTotalAmountFormatted }}
            </p>
          </div>
        </div>

        <div class="mb-6 grid grid-cols-2 gap-2">
          <div class="rounded-lg border-gray-300 bg-gray-50 p-3">
            <p class="text-xs text-green-700">Vested $CGS Claimable</p>
            <p class="text-lg font-bold text-green-900 text-right">
              {{ cgsVestClaimableAmountFormatted }}
            </p>
          </div>
          <div class="rounded-lg border-gray-300 bg-gray-50 p-3">
            <p class="text-xs text-green-700">$CGS Claimed from Vest</p>
            <p class="text-lg font-bold text-green-900 text-right">
              {{ cgsVestingScheduleClaimedAmountFormatted }}
            </p>
          </div>
        </div>

        <Button
          @click="isConnected ? claim() : open()"
          class="
            w-full
            mb-4
            bg-green-900
            py-3
            text-white
            hover:bg-green-800
            rounded-full
            cursor-pointer
          "
          :disabled="!isConnected || isClaiming || !hasTokensToClaim"
          :class="isClaiming ? 'opacity-50 cursor-not-allowed' : ''"
        >
          <LoaderCircle v-if="isClaiming" class="animate-spin h-5 w-5 mr-2" />
          {{
            isConnected
              ? hasTokensToClaim
                ? `Claim ${cgsVestClaimableAmountFormatted} $CGS`
                : 'No $CGS to claim'
              : 'Connect Wallet'
          }}
        </Button>

        <div class="mb-6 grid grid-cols-2 gap-2">
          <div class="rounded-lg border-gray-300 bg-gray-50 p-3">
            <p class="text-xs text-green-700">My Remaining Vesting $CGS</p>
            <p class="text-lg font-bold text-green-900 text-right">
              {{ cgsVestedBalanceFormatted }}
            </p>
          </div>
          <div class="rounded-lg border-gray-300 bg-gray-50 p-3">
            <p class="text-xs text-green-700">My Held $CGS</p>
            <p class="text-lg font-bold text-green-900 text-right">
              {{ cgsBalanceFormatted }}
            </p>
          </div>
        </div>
      </template>
      <template
        v-else-if="
          !isCgsVestingScheduleInitialized &&
          vestingClosedEvents &&
          vestingClosedEvents.length > 0
        "
      >
        <table class="w-full my-4 rounded-md border-gray-300 bg-gray-50 p-4">
          <thead class="border-b border-gray-300">
            <tr class="text-green-800">
              <th class="text-left py-2 px-2" colspan="3">
                Completed Vesting Schedules
              </th>
            </tr>
          </thead>
          <tbody>
            <template
              v-for="event in vestingClosedEvents"
              :key="event.transactionHash"
            >
            <tr>
              <td class="text-left text-green-800 pl-2 font-bold">Started</td>
              <td class="text-right pr-2">
                {{
                  new Date(Number((event as any).args[2]) * 1000).toUTCString()
                }}
              </td>
            </tr>
            <tr>
              <td class="text-left text-green-800 pl-2 font-bold">Ended</td>
              <td class="text-right pr-2">
                {{
                  new Date(
                    Number(
                      (event as any).args[2] + (event as any).args[3]
                    ) * 1000
                  ).toUTCString()
                }}
              </td>
            </tr>
            <tr class="border-b border-gray-300">
              <td class="text-left text-green-800 pl-2 font-bold">Amount</td>
              <td class="text-right pr-2">
                {{
                  parseFloat(
                    ethers.formatUnits((event as any).args[1].toString(), 18)
                  ).toLocaleString('en-US', {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                  })
                }} $CGS
              </td>
            </tr>
            </template>
          </tbody>
        </table>
      </template>
      <template v-else-if="isConnected && !isVestingClosedEventsPending">
        <div class="mb-6">
          <div class="rounded-lg border-gray-300 bg-gray-50 p-3">
            <p class="text-md font-bold text-green-900">
              Vesting Schedule completed or not initialized
            </p>
          </div>
        </div>
      </template>

      <div
        v-if="feedbackMessage"
        class="mb-6 rounded-md border-gray-300 bg-gray-50 p-4"
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

      <div class="mb-6">
        <div class="rounded-lg border-green-900 bg-green-900 p-3">
          <p class="text-xs text-white">
            My Total $CGS (Remaining Vesting + Held)
          </p>
          <p class="text-lg font-bold text-white text-right">
            {{ cgsTotalBalanceFormatted }}
          </p>
        </div>
      </div>

      <div class="mt-4 text-center text-xs text-green-700">
        <a
          class="underline cursor-pointer"
          @click="emit('back-to-presale-clicked')"
        >Back to Presale</a>
      </div>
    </CardContent>
  </Card>
</template>

<script setup lang="ts">
import { useAppKit } from '@reown/appkit/vue'
import { useQuery } from '@tanstack/vue-query'
import { useStorage } from '@vueuse/core'
import {
  useAccount,
  useChainId,
  useConnectorClient,
  useReadContract,
  useWriteContract
} from '@wagmi/vue'
import { mainnet } from '@wagmi/vue/chains'
import { ethers } from 'ethers'
import { ArrowUpRight, LoaderCircle } from 'lucide-vue-next'
import { computed, defineEmits, ref } from 'vue'

import {
  cgsVestingAbi,
  erc20Abi
} from '@/assets/contract-artifacts/wagmi-generated'
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { getProvider } from '@/utils/web3'

const emit = defineEmits(['back-to-presale-clicked'])
const { address, isConnected } = useAccount()
const connectorClient = useConnectorClient()
const chainId = useChainId()
const { open } = useAppKit()
const { writeContractAsync } = useWriteContract()
const isClaiming = ref(false)
const etherscanUrl = chainId.value === mainnet.id
  ? 'https://etherscan.io'
  : 'https://sepolia.etherscan.io'
const tokenContractAddress = useStorage<`0x${string}`>(
  'VITE_CGS_TOKEN_CONTRACT_ADDRESS',
  import.meta.env.VITE_CGS_TOKEN_CONTRACT_ADDRESS as `0x${string}`
)
const vestingContractAddress = useStorage<`0x${string}`>(
  'VITE_CGS_VESTING_CONTRACT_ADDRESS',
  import.meta.env.VITE_CGS_VESTING_CONTRACT_ADDRESS as `0x${string}`
)
const feedbackMessage = ref<string | null>(null)
const feedbackMessageTxHash = ref<string | null>(null)
const hasTokensToClaim = computed(() => {
  return (
    cgsVestedAndClaimableTokens.value &&
    cgsVestedAndClaimableTokens.value[1] > 0n
  )
})
const cgsVestedBalanceFormatted = computed(() => {
  if (!address.value) { return '---' }

  const cgsVestTotalAmount = cgsVestingSchedule.value
    ? cgsVestingSchedule.value[0]
    : 0n
  const cgsVestClaimedAmount = cgsVestingSchedule.value
    ? cgsVestingSchedule.value[1]
    : 0n
  const cgsVestedBalance = cgsVestTotalAmount - cgsVestClaimedAmount

  return cgsVestedBalance
    ? parseFloat(ethers.formatUnits(cgsVestedBalance.toString(), 18))
        .toLocaleString('en-US', {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2
        })
    : '0.00'
})
const cgsVestingScheduleTotalAmountFormatted = computed(() => {
  if (!address.value) { return '---' }

  const totalAmount = cgsVestingSchedule.value
    ? cgsVestingSchedule.value[0]
    : 0n

  return totalAmount
    ? parseFloat(ethers.formatUnits(totalAmount.toString(), 18))
        .toLocaleString('en-US', {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2
        })
    : '0.00'
})
const cgsVestingScheduleClaimedAmountFormatted = computed(() => {
  if (!address.value) { return '---' }

  const claimedAmount = cgsVestingSchedule.value
    ? cgsVestingSchedule.value[1]
    : 0n

  return claimedAmount
    ? parseFloat(ethers.formatUnits(claimedAmount.toString(), 18))
        .toLocaleString('en-US', {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2
        })
    : '0.00'
})
const cgsVestingScheduleStartFormatted = computed(() => {
  if (!address.value) { return '---' }

  const startTimestamp = cgsVestingSchedule.value
    ? cgsVestingSchedule.value[2]
    : 0n

  return startTimestamp
    ? new Date(Number(startTimestamp) * 1000).toUTCString()
    : 'N/A'
})
const cgsVestingScheduleCliffFormatted = computed(() => {
  if (!address.value) { return '---' }

  const cliffTimestamp = cgsVestingSchedule.value
    ? cgsVestingSchedule.value[2] + cgsVestingSchedule.value[4]
    : 0n

  return cliffTimestamp
    ? new Date(Number(cliffTimestamp) * 1000).toUTCString()
    : 'N/A'
})
const cgsVestingScheduleEndFormatted = computed(() => {
  if (!address.value) { return '---' }

  const endTimestamp = cgsVestingSchedule.value
    ? cgsVestingSchedule.value[2] + cgsVestingSchedule.value[3]
    : 0n

  return endTimestamp
    ? new Date(Number(endTimestamp) * 1000).toUTCString()
    : 'N/A'
})
const cgsVestClaimableAmountFormatted = computed(() => {
  if (!address.value) { return '---' }

  const cgsVestClaimableAmount = cgsVestedAndClaimableTokens.value
    ? cgsVestedAndClaimableTokens.value[1]
    : 0n

  return cgsVestClaimableAmount
    ? parseFloat(ethers.formatUnits(cgsVestClaimableAmount.toString(), 18))
        .toLocaleString('en-US', {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2
        })
    : '0.00'
})
const cgsVestVestedAmountFormatted = computed(() => {
  if (!address.value) { return '---' }

  const cgsVestVestedAmount = cgsVestedAndClaimableTokens.value
    ? cgsVestedAndClaimableTokens.value[0]
    : 0n

  return cgsVestVestedAmount
    ? parseFloat(ethers.formatUnits(cgsVestVestedAmount.toString(), 18))
        .toLocaleString('en-US', {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2
        })
    : '0.00'
})
const cgsBalanceFormatted = computed(() => {
  if (!address.value) { return '---' }

  const holdingBalance = cgsBalance.value ? cgsBalance.value : 0n

  return holdingBalance
    ? parseFloat(ethers.formatUnits(holdingBalance.toString(), 18))
        .toLocaleString('en-US', {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2
        })
    : '0.00'
})
const cgsTotalBalanceFormatted = computed(() => {
  if (!address.value) { return '---' }

  const holdingBalance = cgsBalance.value ? cgsBalance.value : 0n
  const cgsVestTotalAmount = cgsVestingSchedule.value
    ? cgsVestingSchedule.value[0]
    : 0n
  const cgsVestClaimedAmount = cgsVestingSchedule.value
    ? cgsVestingSchedule.value[1]
    : 0n
  const cgsVestedBalance = cgsVestTotalAmount - cgsVestClaimedAmount
  const totalCgsBalance = holdingBalance + cgsVestedBalance

  return totalCgsBalance
    ? parseFloat(ethers.formatUnits(totalCgsBalance.toString(), 18))
        .toLocaleString('en-US', {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2
        })
    : '0.00'
})
const isCgsVestingScheduleInitialized = computed(() => {
  return !!cgsVestingSchedule.value && cgsVestingSchedule.value[5]
})
const { data: cgsBalance, refetch: refetchCgsBalance } = useReadContract({
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
const {
  data: cgsVestedAndClaimableTokens,
  refetch: refetchCgsVestedAndClaimableTokens
} = useReadContract({
  address: vestingContractAddress.value,
  abi: cgsVestingAbi,
  functionName: 'getVestedAndClaimableTokens' as const,
  args: [ computed(() => address.value!) ],
  query: {
    enabled: computed(() => !!tokenContractAddress.value && !!address.value)
  }
})
const {
  data: vestingClosedEvents,
  isPending: isVestingClosedEventsPending
} = useQuery({
  queryKey: ['vesting-schedule-closed-events'],
  queryFn: async () => {
    const provider = getProvider(connectorClient)
    if (!provider) {
      throw new Error('No provider when fetching VestingScheduleClosed events!')
    }

    const contract = new ethers.Contract(
      vestingContractAddress.value,
      cgsVestingAbi,
      provider
    )
    const filter = contract.filters.VestingScheduleClosed(address.value)
    const events = await contract.queryFilter(filter)
    console.log('VestingScheduleClosed events:', events)

    return events
  }
})
const claim = async () => {
  if (!isConnected.value) {
    console.error('Wallet not connected')
    return
  }
  if (!vestingContractAddress.value) {
    console.error('Vesting contract address not set')
    return
  }
  if (
    !cgsVestedAndClaimableTokens.value ||
      cgsVestedAndClaimableTokens.value[1] <= 0n
  ) {
    console.error('No claimable tokens available')
    return
  }
  if (isClaiming.value) {
    console.warn('Claim already in progress')
    return
  }
  isClaiming.value = true
  console.log(`Claiming ${cgsVestClaimableAmountFormatted.value} $CGS`)
  try {
    const claimTxHash = await writeContractAsync({
      address: vestingContractAddress.value,
      abi: cgsVestingAbi,
      functionName: 'claimVestedTokens' as const
    })
    console.log(`Claim transaction sent: ${claimTxHash}`)

    feedbackMessage.value = `Claim successful!`
    feedbackMessageTxHash.value = claimTxHash
  } catch (error) {
    console.error('Error claiming tokens:', error)
  } finally {
    console.log('Refetching balances and vesting schedule')
    await refetchCgsBalance()
    await refetchCgsVestingSchedule()
    await refetchCgsVestedAndClaimableTokens()

    isClaiming.value = false
  }
}
</script>
