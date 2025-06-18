<template>
  <Card class="w-full 2xl:w-[90%] border-gray-300 bg-[#E8E6DB] p-6">
    <CardContent class="p-0">
      <div class="mb-6 flex flex-col items-center">
        <div>
          <img src="/images/Group 359.svg" alt="CGS Logo" />
        </div>
        <h3 class="text-xl font-bold text-[#004322]">Acquire $CGS</h3>
        <p class="text-sm text-[#004322]">Crypto Token Presale</p>
      </div>

      <div
        class="mb-6 grid grid-cols-2 relative rounded-[16px] rounded-[15px] bg-[#F9F8F4] border border-[#D2D0CE] border-r-0 px-4 py-5">
        <div>
          <p class="font-normal text-[12px] md:text-[15px] text-[#004322] font-normal">
            Initial Presale Price
          </p>
          <p class="text-[18px] font-bold text-[#004322]">$0.04</p>
        </div>
        <div>
          <p class="text-[#004322] font-normal text-[12px] md:text-[15px] text-right">
            Public Uniswap Launch
          </p>
          <p class="text-[18px] font-bold text-right text-[#004322]">$0.08</p>
        </div>
        <!-- Vertical divider line -->
        <div class="absolute left-1/2 top-[20px] bottom-[20px] w-[1px] p-[1px] bg-gray-200"></div>
      </div>
      <template v-if="!isPresalePausedPending && !isPresalePaused">
        <div class="my-4">
          <div class="mb-4 grid grid-cols-2 gap-4">
            <Button :class="[
              'flex items-center gap-2 rounded-full font-normal py-[16px] h-11 transition-colors duration-150 cursor-pointer',
              selectedToken === 'USDT'
                ? 'bg-green-900 text-white hover:bg-green-800'
                : 'bg-transparent border-green-700 text-[#004322] border  hover:border-green-900 hover:bg-transparent',
            ]" @click="selectedToken = 'USDT'">
              <span class="flex items-center justify-center w-7 h-7 rounded-full bg-green-700/80">
                <!-- USDT SVG Icon -->
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                  <g clip-path="url(#clip0_442_680)">
                    <path
                      d="M12 23.9999C18.6274 23.9999 24 18.6274 24 11.9999C24 5.37252 18.6274 -6.10352e-05 12 -6.10352e-05C5.37258 -6.10352e-05 0 5.37252 0 11.9999C0 18.6274 5.37258 23.9999 12 23.9999Z"
                      fill="#59AF99" />
                    <path
                      d="M13.2456 10.5227V9.10554H16.47V6.86994H7.52158V9.10554H10.7544V10.5227C8.04598 10.6535 6.01318 11.1971 6.01318 11.8427C6.01318 12.4883 8.04358 13.0343 10.7544 13.1627V17.8427H13.2456V13.1627C15.954 13.0331 17.9868 12.4895 17.9868 11.8427C17.9868 11.1959 15.96 10.6535 13.2456 10.5227ZM12 12.7499C9.06718 12.7499 6.68998 12.2963 6.68998 11.7503C6.68998 11.2811 8.42158 10.8863 10.752 10.7807V12.3815C11.1528 12.3995 11.5692 12.4103 11.9976 12.4103C12.426 12.4103 12.8448 12.3995 13.2432 12.3815V10.7807C15.5736 10.8863 17.3052 11.2811 17.3052 11.7503C17.31 12.3023 14.9328 12.7499 12 12.7499Z"
                      fill="white" />
                  </g>
                  <defs>
                    <clipPath id="clip0_442_680">
                      <rect width="24" height="24" fill="white" />
                    </clipPath>
                  </defs>
                </svg>
              </span>
              USDT
            </Button>
            <Button :class="[
              'flex items-center gap-2 rounded-full font-normal py-[16px] h-11 transition-colors duration-150 cursor-pointer',
              selectedToken === 'USDC'
                ? 'bg-green-900 text-white hover:bg-green-800'
                : 'bg-transparent border-green-700 text-[#004322] border  hover:border-green-900 hover:bg-transparent',
            ]" @click="selectedToken = 'USDC'">
              <div class="flex items-center justify-center w-[24px] h-[24px] rounded-full">
                <!-- USDC Icon -->
                <img src="/images/usdcicon.png" alt="USDC Icon" class="w-full" style="object-fit: contain" />
              </div>
              USDC
            </Button>
          </div>
          <div class="mb-6 flex justify-center items-center">
          </div>
        </div>
        <div
          class="flex items-center justify-between mb-4 rounded-[16px] bg-[#F9F8F4] border border-[#D2D0CE] py-[20px] px-[28px]">
          <div class="mb-1 flex flex-col items-start justify-between">
            <span class="text-[16px] text-[#004322] font-normal">You pay (USD)</span>
            <div class="flex items-center w-[50%]">
              <p class="text-[#004322] text-[18px] font-bold">$</p>
              <Input style="font-size: 18px" v-model="payAmount" type="number"
                class="px-[0px] border-none shadow-none text-[#004322] font-bold focus-visible:ring-0"
                placeholder="0.00" />
            </div>
          </div>
          <div
            class='flex items-center justify-center w-fit gap-2 bg-[#004322] rounded-[66px] pt-[6px] pr-[15px] pb-[6px] pl-[7px]'>
            <svg v-if="selectedToken === 'USDT'" xmlns="http://www.w3.org/2000/svg" width="32" height="32"
              viewBox="0 0 24 25" fill="none">
              <g clip-path="url(#clip0_442_700)">
                <path
                  d="M12 24.4999C18.6274 24.4999 24 19.1274 24 12.4999C24 5.87252 18.6274 0.499939 12 0.499939C5.37258 0.499939 0 5.87252 0 12.4999C0 19.1274 5.37258 24.4999 12 24.4999Z"
                  fill="#59AF99" />
                <path
                  d="M13.2456 11.0227V9.60553H16.47V7.36993H7.52158V9.60553H10.7544V11.0227C8.04598 11.1535 6.01318 11.6971 6.01318 12.3427C6.01318 12.9883 8.04358 13.5343 10.7544 13.6627V18.3427H13.2456V13.6627C15.954 13.5331 17.9868 12.9895 17.9868 12.3427C17.9868 11.6959 15.96 11.1535 13.2456 11.0227ZM12 13.2499C9.06718 13.2499 6.68998 12.7963 6.68998 12.2503C6.68998 11.7811 8.42158 11.3863 10.752 11.2807V12.8815C11.1528 12.8995 11.5692 12.9103 11.9976 12.9103C12.426 12.9103 12.8448 12.8995 13.2432 12.8815V11.2807C15.5736 11.3863 17.3052 11.7811 17.3052 12.2503C17.31 12.8023 14.9328 13.2499 12 13.2499Z"
                  fill="white" />
              </g>
              <defs>
                <clipPath id="clip0_442_700">
                  <rect width="24" height="24" fill="white" transform="translate(0 0.499939)" />
                </clipPath>
              </defs>
            </svg>
            <div v-else class="rounded-full h-[32px] w-[32px] flex items-center justify-center">
              <img src="/images/usdcicon.png" alt="USDC Icon" class="w-full" style="object-fit: contain" />
            </div>
            <span class="text-[#E8E6DB] text-[16px] font-medium">
              {{ selectedToken }}
            </span>
          </div>
        </div>
        <div
          class="flex items-center justify-between mb-6 rounded-[16px] bg-[#F9F8F4] border border-[#D2D0CE] py-[20px] px-[28px]">
          <div class="mb-1 flex flex-col items-start justify-between">
            <span class="text-[16px] text-[#004322] font-normal">You receive</span>
            <span class="mt-3 text-[#004322] text-[18px] font-bold">{{
              receiveAmount
            }}</span>

          </div>
          <div
            class="flex items-center justify-center w-fit gap-2 bg-[#004322] rounded-[66px] pt-[5px] pr-[15px] pb-[5px] pl-[8px]">
            <div class="rounded-full bg-[#B2EBF2] h-[34px] w-[34px] flex items-center justify-center p-1">
              <img class="w-full" src="/images/CGS.svg" alt="CGS Token Icon" />
            </div>
            <span class="text-[#E8E6DB] text-[16px] font-medium"> CGS </span>
          </div>
        </div>

        <template v-if="isConnected">
          <Button @click="swap" :disabled="isSwapping || !agreedToTerms" :class="[
            'w-full h-[52px] py-[15px] text-[#E8E6DB] font-normal text-[18px] rounded-[27px] cursor-pointer',
            'bg-[#004322] hover:bg-green-800',
            isSwapping || !agreedToTerms ? 'opacity-50 cursor-not-allowed' : '',
          ]">
            <template v-if="isSwapping">
              <LoaderCircle class="animate-spin h-5 w-5" />
            </template>
            <template v-else> Swap </template>
          </Button>
          <p v-if="!agreedToTerms" class="text-red-500 text-sm text-center mt-2">
            Please accept the terms to continue
          </p>
        </template>
        <template v-else>
          <Button @click="open()"
            class="w-full h-[52px] py-[15px] text-[#E8E6DB] font-normal text-[18px] rounded-[27px] cursor-pointer bg-[#004322] hover:bg-green-800">
            Connect Wallet
          </Button>
        </template>
        <label class="flex items-center justify-center space-x-3 text-[#004322] text-lg font-medium mt-4">
          <input type="checkbox" class="input" v-model="agreedToTerms" />
          <span class="custom-checkbox"></span>
          <span class="cursor-pointer font-medium text-[14px] text-[#004322]">
            I agree to the
            <span @click="openLink('presaleterms')" class="underline">presale terms</span>
            and the <span @click="openLink('termsconditions')" class="underline">terms & conditions</span>
          </span>
        </label>
      </template>
      <div v-else-if="isPresalePausedPending" class="mb-4 rounded-md border-gray-300 bg-gray-50 p-4">
        <p class="text-lg font-bold text-center text-[#004322]">
          Checking presale status...
        </p>
      </div>
      <div v-else class="mb-4 rounded-md border-gray-300 bg-gray-50 p-4">
        <p class="text-lg font-bold text-center text-[#004322]">
          Presale is not live yet!
        </p>
      </div>

      <div v-if="feedbackMessage" class="my-4 rounded-md border-gray-300 bg-gray-50 p-4">
        <p class="text-lg font-bold text-center text-[#004322]">
          {{ feedbackMessage }}
        </p>
        <p v-if="feedbackMessageTxHash" class="text-sm text-[#004322] text-right">
          <a :href="`${etherscanUrl}/tx/${feedbackMessageTxHash}`" target="_blank" rel="noopener noreferrer"
            class="cursor-pointer underline flex items-center justify-center">
            View Transaction
            <ArrowUpRight class="h-3 w-3" />
          </a>
        </p>
      </div>
    </CardContent>
  </Card>
  <div @click.self="presaleTerms = false" v-if="presaleTerms"
    class="fixed inset-0 bg-[#EFEEE5E5] z-40 flex items-center justify-center px-2">
    <!-- Modal -->
    <div
      class="bg-[#E8E6DB] rounded-[25px] border border-[#D2D0CE] shadow-lg w-full max-w-[600px] p-[30px] md:p-[50px] text-[#004322] max-h-[90vh] flex flex-col"
      style="max-height:90vh;">
      <!-- Header -->
      <div class="flex items-center mb-4">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="21" viewBox="0 0 20 21" fill="none">
          <path
            d="M10 0.499878C4.47734 0.499878 0 4.97722 0 10.4999C0 16.0225 4.47734 20.4999 10 20.4999C15.5227 20.4999 20 16.0225 20 10.4999C20 4.97722 15.5227 0.499878 10 0.499878ZM11.2664 14.7022C11.2664 14.8685 11.2337 15.0332 11.17 15.1869C11.1064 15.3405 11.0131 15.4801 10.8955 15.5977C10.7779 15.7153 10.6383 15.8086 10.4846 15.8722C10.331 15.9359 10.1663 15.9686 10 15.9686C9.83369 15.9686 9.66901 15.9359 9.51537 15.8722C9.36172 15.8086 9.22211 15.7153 9.10452 15.5977C8.98692 15.4801 8.89364 15.3405 8.82999 15.1869C8.76635 15.0332 8.73359 14.8685 8.73359 14.7022V9.63621C8.73359 9.4699 8.76635 9.30522 8.82999 9.15157C8.89364 8.99793 8.98692 8.85832 9.10452 8.74072C9.22211 8.62313 9.36172 8.52984 9.51537 8.4662C9.66901 8.40256 9.83369 8.3698 10 8.3698C10.1663 8.3698 10.331 8.40256 10.4846 8.4662C10.6383 8.52984 10.7779 8.62313 10.8955 8.74072C11.0131 8.85832 11.1064 8.99793 11.17 9.15157C11.2337 9.30522 11.2664 9.4699 11.2664 9.63621V14.7022ZM10 7.56394C9.74953 7.56394 9.50468 7.48967 9.29642 7.35051C9.08816 7.21136 8.92584 7.01357 8.82999 6.78217C8.73414 6.55076 8.70906 6.29613 8.75793 6.05047C8.80679 5.80481 8.92741 5.57916 9.10452 5.40205C9.28163 5.22494 9.50728 5.10433 9.75294 5.05546C9.9986 5.0066 10.2532 5.03168 10.4846 5.12753C10.716 5.22338 10.9138 5.3857 11.053 5.59396C11.1921 5.80222 11.2664 6.04706 11.2664 6.29753C11.2665 6.46386 11.2337 6.62856 11.1701 6.78223C11.1065 6.9359 11.0132 7.07553 10.8956 7.19313C10.778 7.31074 10.6384 7.40402 10.4847 7.46765C10.331 7.53127 10.1663 7.56399 10 7.56394Z"
            fill="#004322" />
        </svg>
        <h2 class="text-lg font-bold text-[#004322] ml-2 mt-1">
          Fair Launch & Presale Policy
        </h2>
      </div>

      <!-- Body -->
      <div
        class="space-y-4 text-[15px] md:text-[16px] font-normal leading-relaxed text-[#29282D] overflow-y-auto pr-2 md:pr-6"
        style="max-height: 50vh; scrollbar-gutter: stable">
        <p class="mb-4">
          Community Grocery Store (CGS) is committed to fairness, transparency, and
          community-first values. Our tokenomics model, expertly designed by Chainforce,
          reflects our dedication to creating an equitable and stable ecosystem.
        </p>

        <p class="font-bold mb-2">Fair Launch Principles:</p>
        <ol class="list-decimal pl-6 space-y-2">
          <li>
            <h4 class="font-bold">Transparent Presale Allocation:</h4>
            <ul class="list-disc pl-6 mt-1 space-y-1 text-[#29282D]">
              <li>
                CGS has not conducted any private presale rounds. The only initial presale
                available is through our publicly accessible Token Presale, ensuring equal
                opportunity for all participants.
              </li>
              <li>
                For full transparency, our lawyers own 1% of the 5% legal allocation,
                vested linearly over 24 months in exchange for legal services.
              </li>
              <li>
                For full transparency, our developers own 1% of the 9% App & Ecosystem
                Development allocation, vested linearly over 60 months.
              </li>
              <li>
                As additional service providers join CGS and exchange their services for
                CGS tokens, their holdings will be documented in this policy.
              </li>
            </ul>
          </li>
          <li>
            <h4 class="font-bold">Open Market Access:</h4>
            <ul class="list-disc pl-6 mt-1 space-y-1 text-[#29282D]">
              <li>
                Following the initial presale allocation, CGS tokens will become openly
                accessible via decentralized exchanges like Uniswap, ensuring ongoing fair
                access without preferential treatment.
              </li>
            </ul>
          </li>
          <li>
            <h4 class="font-bold">Equal Opportunity:</h4>
            <ul class="list-disc pl-6 mt-1 space-y-1 text-[#29282D]">
              <li>
                Incentives are structured to reward active participation in governance and
                platform usage, fostering ongoing engagement.
              </li>
            </ul>
          </li>
          <li>
            <h4 class="font-bold">Community-driven Rewards:</h4>
            <ul class="list-disc pl-6 mt-1 space-y-1 text-[#29282D]">
              <li>
                Our fair launch policy provides equal opportunities for individuals from
                approved countries to join and benefit from the CGS ecosystem, emphasizing
                accessibility and inclusivity.
              </li>
            </ul>
          </li>
        </ol>
        <p class="mb-4">
          By adhering strictly to these principles, CGS aims to create a stable, fair, and
          transparent economic environment benefiting all stakeholders.
        </p>
      </div>

      <!-- Footer -->
      <div class="mt-6 flex justify-end border-t border-[#004322] pt-4">
        <button @click="presaleTerms = false"
          class="bg-[#004322] text-[#E8E6DB] text-[16px] font-normal px-6 py-2 rounded-full cursor-pointer hover:bg-[#00331A] transition duration-150">
          Accept
          <ArrowUpRight class="inline h-4 w-4 ml-1" />
        </button>
      </div>
    </div>
  </div>
</template>
<style lang="css">
/* From Uiverse.io by PriyanshuGupta28 */
.input[type="checkbox"] {
  display: none;
}

/* Style for the custom checkbox */
.custom-checkbox {
  display: inline-block;
  width: 20px;
  height: 20px;
  border: 2px solid #27272a;
  border-radius: 4px;
  position: relative;
  cursor: pointer;
}

/* Style for the custom checkmark */
.custom-checkbox::after {
  content: "";
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 10px;
  height: 10px;
  background-color: #27272a;
  border-radius: 2px;
  opacity: 0;
}

/* Show the checkmark when checkbox is checked */
.input[type="checkbox"]:checked+.custom-checkbox::after {
  opacity: 1;
}
</style>
<script lang="ts" setup>
import { useAppKit } from '@reown/appkit/vue'
import { useAccount, useChainId, useReadContract, useWriteContract } from '@wagmi/vue'
import { mainnet } from '@wagmi/vue/chains'
import { ArrowUpRight, LoaderCircle } from 'lucide-vue-next'
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

const agreedToTerms = ref(false)
const presaleTerms = ref(false)
const emit = defineEmits(['balance-clicked'])
const { address, isConnected } = useAccount()
const chainId = useChainId()
const { open } = useAppKit()
const { writeContractAsync } = useWriteContract()
const tokenContractAddress = import.meta.env.VITE_CGS_TOKEN_CONTRACT_ADDRESS as `0x${string}` | undefined
const vestingContractAddress = import.meta.env.VITE_CGS_VESTING_CONTRACT_ADDRESS as `0x${string}` | undefined
const presaleContractAddress = import.meta.env.VITE_CGS_PRESALE_CONTRACT_ADDRESS as `0x${string}` | undefined
const usdcContractAddress = import.meta.env.VITE_USDC_CONTRACT_ADDRESS as `0x${string}` | undefined
const usdtContractAddress = import.meta.env.VITE_USDT_CONTRACT_ADDRESS as `0x${string}` | undefined
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
const {
  data: isPresalePaused,
  isPending: isPresalePausedPending
} = useReadContract({
  address: presaleContractAddress!,
  abi: cgsTokenPresaleAbi,
  functionName: 'isPresalePaused' as const,
  query: {
    enabled: computed(() => !!presaleContractAddress)
  }
})
const { refetch: refetchUsdcBalance } = useReadContract({
  address: usdcContractAddress!,
  abi: erc20Abi,
  functionName: 'balanceOf' as const,
  args: [ computed(() => address.value!) ],
  query: {
    enabled: computed(() => !!address.value && !!usdcContractAddress)
  }
})
const {
  data: usdcPresaleContractAllowance,
  refetch: refetchUsdcPresaleContractAllowance,
} = useReadContract({
  address: usdcContractAddress!,
  abi: erc20Abi,
  functionName: 'allowance' as const,
  args: [ computed(() => address.value!), presaleContractAddress! ],
  query: {
    enabled: computed(
      () => !!address.value && !!usdcContractAddress && !!presaleContractAddress
    )
  }
})
const { refetch: refetchUsdtBalance } = useReadContract({
  address: usdtContractAddress!,
  abi: erc20Abi,
  functionName: 'balanceOf' as const,
  args: [ computed(() => address.value!) ],
  query: {
    enabled: computed(() => !!address.value && !!usdtContractAddress)
  }
})
const {
  data: usdtPresaleContractAllowance,
  refetch: refetchUsdtPresaleContractAllowance,
} = useReadContract({
  address: usdtContractAddress!,
  abi: erc20Abi,
  functionName: 'allowance' as const,
  args: [ computed(() => address.value!), presaleContractAddress! ],
  query: {
    enabled: computed(
      () => !!address.value && !!usdtContractAddress && !!presaleContractAddress
    )
  }
})
const { refetch: refetchCgsBalance } = useReadContract({
  address: tokenContractAddress!,
  abi: erc20Abi,
  functionName: 'balanceOf' as const,
  args: [ computed(() => address.value!) ],
  query: {
    enabled: computed(() => !!address.value && !!tokenContractAddress)
  }
})
const { refetch: refetchCgsVestingSchedule } = useReadContract({
  address: vestingContractAddress!,
  abi: cgsVestingAbi,
  functionName: 'vestingSchedules' as const,
  args: [ computed(() => address.value!) ],
  query: {
    enabled: computed(() => !!address.value && !!vestingContractAddress)
  }
})
const swap = async () => {
  if (!isConnected.value) {
    console.error('Wallet not connected')
    return
  }
  if (!presaleContractAddress) {
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
  const atomicPayAmount = ethers.parseUnits(payAmount.value.toString(), 6)
  const paymentTokenAddress =
    selectedToken.value === 'USDT' ? usdtContractAddress : usdcContractAddress
  try {
    const allowance =
      selectedToken.value === 'USDT'
        ? usdtPresaleContractAllowance.value
        : usdcPresaleContractAllowance.value
    if (!allowance || allowance < atomicPayAmount) {
      console.log(
        `Insufficient allowance for ${selectedToken.value}. ` +
        `Current allowance: ${allowance}, required: ${atomicPayAmount}`
      )
    }
    const remainingToApprove = allowance ? atomicPayAmount - allowance : atomicPayAmount
    if (remainingToApprove > 0n) {
      const approvalTxHash = await writeContractAsync({
        address: paymentTokenAddress!,
        abi: erc20Abi,
        functionName: 'approve' as const,
        args: [presaleContractAddress, remainingToApprove]
      })
      console.log(`Approval transaction hash: ${approvalTxHash}`)
    }

    const txHash = await writeContractAsync({
      address: presaleContractAddress,
      abi: cgsTokenPresaleAbi,
      functionName: 'buy' as const,
      args: [atomicPayAmount, paymentTokenAddress!],
    })
    console.log(`Swap transaction hash: ${txHash}`)

    feedbackMessage.value =
      `Swap successful! ` + `You received ${receiveAmount.value} $CGS!`
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

const openLink = (type: string) => {
  const links: any = {
    termsconditions: 'https://www.communitygrocerystore.com/terms-and-conditions',
    presaleterms: 'https://www.communitygrocerystore.com/presale-disclaimer'
  }

  const url: any = links[type.toLowerCase()]
  if (url) {
    window.open(url, '_blank')
  }
}
</script>
