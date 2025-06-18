<template>
  <Card class="w-full 2xl:w-[90%] border-gray-300 bg-[#E8E6DB] p-6">
    <CardContent class="p-0">
      <div class="mb-6 flex flex-col items-center">
        <h3 class="text-[24px] font-bold text-[#004322]">$CGS Vesting & Claims</h3>
        <p class="text-[14px] font-medium text-[#004322]">Balance & Vesting Schedule</p>
      </div>

      <template v-if="isCgsVestingScheduleInitialized">
        <div class="mb-4">
          <div
            class="rounded-[16px] border border-[#D2D0CE] bg-[#F9F8F4] px-[28px] py-[20px]"
          >
            <div class="mb-4 flex items-center justify-center">
              <p class="text-[16px] text-[#004322] font-normal">Vesting Schedule</p>
              <div
                class="flex items-center justify-center rounded-[6px] border border-[#004322] p-1 ml-2"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="10"
                  height="10"
                  viewBox="0 0 10 10"
                  fill="none"
                >
                  <path
                    d="M5 10C2.23857 10 0 7.7614 0 5C0 2.23857 2.23857 0 5 0C7.7614 0 10 2.23857 10 5C10 7.7614 7.7614 10 5 10ZM3.85501 8.8337C3.37371 7.81295 3.07866 6.6871 3.01366 5.5H1.03095C1.229 7.08825 2.3582 8.38735 3.85501 8.8337ZM4.01535 5.5C4.09055 6.7194 4.4389 7.86485 5 8.876C5.5611 7.86485 5.90945 6.7194 5.98465 5.5H4.01535ZM8.96905 5.5H6.98635C6.92135 6.6871 6.6263 7.81295 6.145 8.8337C7.6418 8.38735 8.771 7.08825 8.96905 5.5ZM1.03095 4.5H3.01366C3.07866 3.31289 3.37371 2.18704 3.85501 1.16628C2.3582 1.61267 1.229 2.91175 1.03095 4.5ZM4.01535 4.5H5.98465C5.90945 3.28061 5.5611 2.13513 5 1.124C4.4389 2.13513 4.09055 3.28061 4.01535 4.5ZM6.145 1.16628C6.6263 2.18704 6.92135 3.31289 6.98635 4.5H8.96905C8.771 2.91175 7.6418 1.61267 6.145 1.16628Z"
                    fill="#004322"
                  />
                </svg>
                <p class="text-[10px] text-[#004322] font-normal ml-1">GMT</p>
              </div>
            </div>
            <div class="grid gap-4 grid-cols-12">
              <div class="col-span-4 border-r border-[#D2D0CE]">
                <p class="text-[16px] text-[#004322] font-normal mb-2">Start</p>
                <p class="text-[18px] font-bold text-[#004322] text-left">
                  {{ cgsVestingScheduleStartFormatted }}
                </p>
              </div>
              <div class="col-span-4 border-r border-[#D2D0CE]">
                <p class="text-[16px] text-[#004322] font-normal mb-2">Cliff</p>
                <p class="text-[18px] font-bold text-[#004322] text-left">
                  {{ cgsVestingScheduleCliffFormatted }}
                </p>
              </div>
              <div class="col-span-4">
                <p class="text-[16px] text-[#004322] font-normal mb-2">End</p>
                <p class="text-[18px] font-bold text-[#004322] text-left">
                  {{ cgsVestingScheduleEndFormatted }}
                </p>
              </div>
            </div>
          </div>
        </div>
        <div
          class="mb-4 rounded-[16px] border border-[#D2D0CE] bg-[#F9F8F4] px-[28px] py-[20px]"
        >
          <div class="grid gap-4 grid-cols-12 relative">
            <div class="col-span-6 pr-4">
              <p class="text-[16px] text-[#004322] font-normal mb-2">
                Vested $CGS To Date
              </p>
              <p class="text-[18px] font-bold text-[#004322] text-left break-all max-w-full">
                {{ cgsVestVestedAmountFormatted }}
              </p>
            </div>
            <div class="col-span-6 pl-4">
              <p class="text-[16px] text-[#004322] font-normal mb-2">
                Total $CGS Vest Size
              </p>
              <p class="text-[18px] font-bold text-[#004322] text-left break-all max-w-full">
                {{ cgsVestingScheduleTotalAmountFormatted }}
              </p>
            </div>
            <!-- Vertical divider line -->
            <div
              class="absolute left-1/2 top-[0px] bottom-[0px] w-[1px] p-[1px] bg-gray-200"
            ></div>
          </div>
        </div>

        <div class="mb-6 grid grid-cols-2 gap-4">
          <div class="rounded-[16px] border border-[#D2D0CE] bg-[#F9F8F4] px-[28px] py-[20px]"
          >
            <p class="text-[16px] text-[#004322] font-normal mb-2">Claimable $CGS</p>
            <div class="flex flex-col items-start gap-2 sm:flex-row sm:items-center sm:gap-2 w-full">
              <p class="text-[18px] font-bold text-[#004322] text-left break-all max-w-full">
          {{ cgsVestClaimableAmountFormatted }}
              </p>
              <Button
          @click="isConnected ? claim() : open()"
          class="w-fit !h-fit !px-[10px] !py-[5px] bg-[#004322] py-[5px] px-[10px] text-[#F9F8F4] text-[10px] hover:bg-green-800 rounded-[6px] cursor-pointer"
          :class="isClaiming ? 'opacity-50 cursor-not-allowed' : ''"
              >
          <LoaderCircle v-if="isClaiming" class="animate-spin h-5 w-5 mr-2" />
          {{
            isConnected
              ? hasTokensToClaim
                ? `Claim`
                : "No claim"
              : "Connect Wallet"
          }}
              </Button>
            </div>
          </div>
          <div
            class="rounded-[16px] border border-[#D2D0CE] bg-[#F9F8F4] px-[28px] py-[20px]"
          >
            <p class="text-[16px] text-[#004322] font-normal mb-2">Claimed $CGS</p>
            <p class="text-[18px] font-bold text-[#004322] text-left break-all max-w-full">
              {{ cgsVestingScheduleClaimedAmountFormatted }}
            </p>
          </div>
        </div>

        <div
          class="mb-4 rounded-[16px] border border-[#D2D0CE] bg-[#F9F8F4] px-[28px] py-[20px]"
        >
          <div class="grid gap-4 grid-cols-12 relative">
            <div class="col-span-6 pr-4">
              <p class="text-[16px] text-[#004322] font-normal mb-2">$CGS Vesting</p>
              <p class="text-[18px] font-bold text-[#004322] text-left break-all max-w-full">
                {{ cgsVestedBalanceFormatted }}
              </p>
            </div>
            <div class="col-span-6 pl-4">
              <p class="text-[16px] text-[#004322] font-normal mb-2">My Total $CGS</p>
              <p class="text-[18px] font-bold text-[#004322] text-left break-all max-w-full">
                {{ cgsBalanceFormatted }}
              </p>
            </div>
            <!-- Vertical divider line -->
            <div
              class="absolute left-1/2 top-[0px] bottom-[0px] w-[1px] p-[1px] bg-gray-200"
            ></div>
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
            <tr class="text-[#004322]">
              <th class="text-left py-2 px-2" colspan="3">Completed Vesting Schedules</th>
            </tr>
          </thead>
          <tbody>
            <template v-for="event in vestingClosedEvents" :key="event.transactionHash">
              <tr>
                <td class="text-left text-[#004322] pl-2 font-bold">Started</td>
                <td class="text-right pr-2">
                  {{
                    new Date(Number((event as any).args[2]) * 1000).toUTCString()
                  }}
                </td>
              </tr>
              <tr>
                <td class="text-left text-[#004322] pl-2 font-bold">Ended</td>
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
                <td class="text-left text-[#004322] pl-2 font-bold">Amount</td>
                <td class="text-right pr-2">
                  {{
                    parseFloat(
                      ethers.formatUnits((event as any).args[1].toString(), 18)
                    ).toLocaleString('en-US', {
                      minimumFractionDigits: 2,
                      maximumFractionDigits: 2
                    })
                  }}
                  $CGS
                </td>
              </tr>
            </template>
          </tbody>
        </table>
      </template>
      <template v-else-if="isConnected && !isVestingClosedEventsPending">
        <div class="mb-6">
          <div class="rounded-lg border-gray-300 bg-gray-50 p-3">
            <p class="text-md font-bold text-[#004322]">
              Vesting Schedule completed or not initialized
            </p>
          </div>
        </div>
      </template>

      <div v-if="feedbackMessage" class="mb-6 rounded-md border-gray-300 bg-gray-50 p-4">
        <p class="text-lg font-bold text-center text-[#004322]">
          {{ feedbackMessage }}
        </p>
        <p v-if="feedbackMessageTxHash" class="text-sm text-[#004322] text-right">
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
        <div
          class="grid grid-cols-2 gap-4 rounded-[16px] border border-[#D2D0CE] bg-[#004322] px-[28px] py-[20px]"
        >
          <div class="col-span-1">
            <p class="text-[16px] text-[#F9F8F4] font-normal">My Total $CGS</p>
            <p class="text-[10px] text-[#FFFFFF80] font-normal">
              (Remaining Vesting + Held)
            </p>
          </div>
          <div class="col-span-1 flex items-center justify-center">
            <p class="text-[18px] font-bold text-[#F9F8F4]">
              {{ cgsTotalBalanceFormatted }}
            </p>
            <div
              class="ml-3 rounded-full bg-[#B2EBF2] h-[23px] w-[23px] flex items-center justify-center p-1"
            >
              <img class="w-full" src="/images/CGS.svg" alt="CGS Token Icon" />
            </div>
          </div>
        </div>
      </div>

      <div
        class="mt-4 flex items-center justify-center font-medium text-[14px] text-[#004322]"
      >
        <svg class="cursor-pointer"  @click="emit('back-to-presale-clicked')"
          xmlns="http://www.w3.org/2000/svg"
          width="10"
          height="11"
          viewBox="0 0 10 11"
          fill="none"
        >
          <g clip-path="url(#clip0_924_1020)">
            <path
              d="M8.88867 5.5L1.11089 5.5"
              stroke="#004322"
              stroke-width="1.33333"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
            <path
              d="M5 9.38895L1.11111 5.50006L5 1.61117"
              stroke="#004322"
              stroke-width="1.33333"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </g>
          <defs>
            <clipPath id="clip0_924_1020">
              <rect
                width="10"
                height="10"
                fill="white"
                transform="translate(10 10.5) rotate(-180)"
              />
            </clipPath>
          </defs>
        </svg>
        <a  @click="emit('back-to-presale-clicked')" class="cursor-pointer ml-2">Back to Presale</a>
      </div>
    </CardContent>
  </Card>
</template>
<script setup lang="ts">
import { useAppKit } from '@reown/appkit/vue'
import { useQuery } from '@tanstack/vue-query'
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
const tokenContractAddress = import.meta.env.VITE_CGS_TOKEN_CONTRACT_ADDRESS as `0x${string}` | undefined
const vestingContractAddress = import.meta.env.VITE_CGS_VESTING_CONTRACT_ADDRESS as `0x${string}` | undefined
const feedbackMessage = ref<string | null>(null)
const feedbackMessageTxHash = ref<string | null>(null)
const hasTokensToClaim = computed(() => {
  return cgsVestedAndClaimableTokens.value && cgsVestedAndClaimableTokens.value[1] > 0n
})
const cgsVestedBalanceFormatted = computed(() => {
  if (!address.value) { return '---' }

  const cgsVestTotalAmount = cgsVestingSchedule.value ? cgsVestingSchedule.value[0] : 0n
  const cgsVestClaimedAmount = cgsVestingSchedule.value
    ? cgsVestingSchedule.value[1]
    : 0n
  const cgsVestedBalance = cgsVestTotalAmount - cgsVestClaimedAmount

  return cgsVestedBalance
    ? parseFloat(ethers.formatUnits(cgsVestedBalance.toString(), 18))
      .toLocaleString(
        'en-US',
        {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2
        }
      )
    : '0.00'
})
const cgsVestingScheduleTotalAmountFormatted = computed(() => {
  if (!address.value) {
    return '---'
  }

  const totalAmount = cgsVestingSchedule.value ? cgsVestingSchedule.value[0] : 0n

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
      .toLocaleString(
        'en-US',
        {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2
        }
      )
    : '0.00'
})
const formatDate = (timestamp: bigint): string => {
  if (!timestamp) return 'N/A'
  const date = new Date(Number(timestamp) * 1000)

  const time = date.toLocaleTimeString('en-US', {
    hour: '2-digit',
    minute: '2-digit',
    hour12: true
  })

  const dateStr = date.toLocaleDateString('en-US', {
    month: 'long',
    day: 'numeric',
    year: 'numeric'
  })

  return `${time}\n${dateStr}` // Line break between time and date
}

const cgsVestingScheduleStartFormatted = computed(() => {
  if (!address.value) { return '---' }

  const startTimestamp = cgsVestingSchedule.value
    ? cgsVestingSchedule.value[2]
    : 0n

  return startTimestamp ? formatDate(startTimestamp) : 'N/A'
})
const cgsVestingScheduleCliffFormatted = computed(() => {
  if (!address.value) { return '---' }

  const cliffTimestamp = cgsVestingSchedule.value
    ? cgsVestingSchedule.value[2] + cgsVestingSchedule.value[4]
    : 0n
  return cliffTimestamp ? formatDate(cliffTimestamp) : 'N/A'
})
const cgsVestingScheduleEndFormatted = computed(() => {
  if (!address.value) { return '---' }

  const endTimestamp = cgsVestingSchedule.value
    ? cgsVestingSchedule.value[2] + cgsVestingSchedule.value[3]
    : 0n
  return endTimestamp ? formatDate(endTimestamp) : 'N/A'
})
const cgsVestClaimableAmountFormatted = computed(() => {
  if (!address.value) { return '---' }

  const cgsVestClaimableAmount = cgsVestedAndClaimableTokens.value
    ? cgsVestedAndClaimableTokens.value[1]
    : 0n

  return cgsVestClaimableAmount
    ? parseFloat(
        ethers.formatUnits(cgsVestClaimableAmount.toString(), 18)
      ).toLocaleString('en-US', {
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
      .toLocaleString(
        'en-US',
        {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2
        }
      )
    : '0.00'
})
const cgsBalanceFormatted = computed(() => {
  if (!address.value) { return '---' }

  const holdingBalance = cgsBalance.value ? cgsBalance.value : 0n

  return holdingBalance
    ? parseFloat(ethers.formatUnits(holdingBalance.toString(), 18))
      .toLocaleString(
        'en-US',
        {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2
        }
      )
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
      .toLocaleString(
        'en-US',
        {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2
        }
      )
    : '0.00'
})
const isCgsVestingScheduleInitialized = computed(() => {
  return !!cgsVestingSchedule.value && cgsVestingSchedule.value[5]
})
const { data: cgsBalance, refetch: refetchCgsBalance } = useReadContract({
  address: tokenContractAddress!,
  abi: erc20Abi,
  functionName: 'balanceOf' as const,
  args: [computed(() => address.value!)],
  query: {
    enabled: computed(() => !!address.value && !!tokenContractAddress)
  }
})
const {
  data: cgsVestingSchedule,
  refetch: refetchCgsVestingSchedule
} = useReadContract({
  address: vestingContractAddress!,
  abi: cgsVestingAbi,
  functionName: 'vestingSchedules' as const,
  args: [computed(() => address.value!)],
  query: {
    enabled: computed(() => !!address.value && !!vestingContractAddress)
  }
})
const {
  data: cgsVestedAndClaimableTokens,
  refetch: refetchCgsVestedAndClaimableTokens,
} = useReadContract({
  address: vestingContractAddress!,
  abi: cgsVestingAbi,
  functionName: 'getVestedAndClaimableTokens' as const,
  args: [computed(() => address.value!)],
  query: {
    enabled: computed(() => !!address.value && !!vestingContractAddress)
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
      vestingContractAddress!,
      cgsVestingAbi,
      provider
    )
    const filter = contract.filters.VestingScheduleClosed(address.value)
    const events = await contract.queryFilter(filter)

    return events
  },
  enabled: computed(() => !!address.value && !!vestingContractAddress)
})
const claim = async () => {
  if (!isConnected.value) {
    console.error('Wallet not connected')
    return
  }
  if (!vestingContractAddress) {
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
      address: vestingContractAddress!,
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
