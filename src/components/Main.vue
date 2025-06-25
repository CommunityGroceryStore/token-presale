<template>
  <div class="min-h-screen w-screen bg-[#EFEEE5] px-0 md:px-0 md:px-0">
    <!-- Header -->
    <header class="border-b border-gray-300 px-4 py-3">
      <div class="2xl:mx-[100px] flex items-center justify-between">
        <div class="flex items-center gap-2">
          <div>
            <img src="/images/Group 359.svg" alt="CGS Logo" class="w-[75px]" />
          </div>
          <div>
            <h1 class="font-bold text-[#004322]">Community</h1>
            <div class="flex items-center">
              <span class="font-bold text-[#004322]">Grocery</span>
              <span class="ml-1 rounded bg-[#004322] px-2 py-0.5 text-xs font-bold text-white">Store</span>
            </div>
          </div>
        </div>

        <div class="flex items-center gap-4">
          <template v-if="isConnected">
            <div class="hidden md:flex">
              <Button @click="tab = 'presale'"
                class="rounded-full bg-[#004322] mr-2 px-4 py-2 text-white hover:bg-green-800 cursor-pointer"
                :class="tab === 'presale' ? 'bg-[#004322]' : ''">Presale</Button>
              <Button @click="tab = 'cgs-balance'"
                class="rounded-full bg-[#004322] mr-2 px-4 py-2 text-white hover:bg-green-800 cursor-pointer"
                :class="tab === 'cgs-balance' ? 'bg-[#004322]' : ''">My $CGS</Button>
            </div>
          </template>

          <Button @click="
            isConnected
              ? open({ view: 'Account' })
              : open({ view: 'Connect', namespace: 'eip155' })
            "
            class="rounded-full bg-[#004322] px-4 py-2 text-white hover:bg-green-800 cursor-pointer flex items-center gap-2">
            <template v-if="isConnected">
              {{ walletAddress }}
              <svg xmlns="http://www.w3.org/2000/svg" width="7" height="12" viewBox="0 0 7 12" fill="none">
                <path fill-rule="evenodd" clip-rule="evenodd"
                  d="M0.183742 3.92782L2.33324 1.08532C2.46579 0.899064 2.68026 0.788452 2.90887 0.788452C3.13747 0.788452 3.35195 0.899064 3.48449 1.08532L5.83424 3.92782C6.02665 4.16829 6.07161 4.49494 5.95132 4.77845C5.83102 5.06196 5.56487 5.2566 5.25824 5.28532H0.758242C0.451879 5.25611 0.186197 5.06127 0.0662542 4.77786C-0.0536891 4.49444 -0.00858095 4.16808 0.183742 3.92782Z"
                  fill="white" />
                <path fill-rule="evenodd" clip-rule="evenodd"
                  d="M5.83424 8.14281L3.68324 10.9853C3.55073 11.1719 3.33607 11.2827 3.10724 11.2827C2.87841 11.2827 2.66375 11.1719 2.53124 10.9853L0.183742 8.14281C-0.00858095 7.90255 -0.0536891 7.57619 0.0662542 7.29277C0.186197 7.00936 0.451879 6.81452 0.758242 6.78531H5.25824C5.56487 6.81403 5.83102 7.00867 5.95132 7.29218C6.07161 7.57569 6.02665 7.90234 5.83424 8.14281Z"
                  fill="white" />
              </svg>
            </template>
            <template v-else> Connect Wallet </template>
          </Button>
        </div>
      </div>
    </header>

    <!-- Main Content -->
    <main class="2xl:mx-[100px] px-4 pt-6">
      <div class="grid gap-8 2xl:grid-cols-12">
        <!-- Left Column - Info -->
        <div class="space-y-6 2xl:col-span-7">
          <div class="flex items-center gap-4">
            <div class="bg-[#033f24] text-white rounded-2xl p-4 md:py-4 md:px-6 w-full mx-auto overflow-hidden">
              <!-- Timeline Row Container -->
              <div class="flex flex-row flex-direction-column items-center justify-between relative">
                <!-- Line Background -->
                <!-- Timeline Bar (50% height, only left side rounded, full length) -->
                <div
                  class="absolute d-time-line-none inset-y-1/2 w-[1200px] time-line-main-w top-[45%] left-0 right-0 transform -translate-y-1/2 h-4 z-0 flex overflow-hidden rounded-l-full">
                  <div class="bg-white time-line-w w-[16%]"></div>
                  <div class="bg-[#FFFFFF80] flex-1"></div>
                </div>

                <!-- Seedling -->
                <div class="flex flex-col items-center w-1/3 relative z-10 mb-sm-4">
                  <p class="font-semibold md:mb-1">Seedling</p>
                  <div
                    class="bg-[#033f24] w-[43px] h-[43px] border border-white rounded-full p-2 flex justify-center items-center mt-2 mt-sm-0">
                    <svg xmlns="http://www.w3.org/2000/svg" width="31" height="40" viewBox="0 0 31 40" fill="none">
                      <g clip-path="url(#clip0_1126_77)">
                        <path fill-rule="evenodd" clip-rule="evenodd"
                          d="M14.5694 22.6846C15.9877 20.1661 17.8198 17.6615 20.0806 16.0455C20.7819 15.5442 21.5664 15.1005 22.3873 14.8279C22.6932 14.7263 23.0887 14.6193 23.4146 14.6042C23.8517 14.584 24.222 14.9228 24.2421 15.3596C24.2619 15.7918 23.9278 16.1592 23.4973 16.1869C23.2809 16.2046 22.9819 16.3004 22.781 16.373C22.1211 16.6114 21.4878 16.9861 20.9231 17.3986C19.906 18.1416 18.9998 19.0935 18.216 20.0745C16.9491 21.6603 15.8946 23.4562 14.9988 25.2775C15.0849 25.9076 15.1578 27.6296 15.2196 28.2417C15.2634 28.6755 14.9445 29.0665 14.5105 29.1097C14.4503 29.1158 14.4857 29.1137 14.4301 29.1137C14.024 29.1133 13.6835 28.8051 13.6428 28.4008C13.575 27.7289 13.4943 25.9557 13.3983 25.2815C13.3958 25.2668 13.3937 25.252 13.392 25.2371C13.0873 23.1102 12.6308 20.9874 11.9512 18.9642C11.4098 17.3523 10.7012 15.7284 9.75953 14.3068C9.22528 13.5002 8.58508 12.7104 7.84594 12.0812C7.62042 11.8892 7.28431 11.6231 7.01301 11.493C6.61841 11.3111 6.44339 10.8417 6.62321 10.4458C6.80257 10.0509 7.27019 9.87237 7.66664 10.0491C8.02918 10.2107 8.44909 10.5229 8.75207 10.7712C9.62969 11.4905 10.3878 12.4003 11.019 13.3387C12.8295 16.0305 13.9158 19.3625 14.5694 22.6846Z"
                          fill="#EFEEE5" />
                        <path fill-rule="evenodd" clip-rule="evenodd"
                          d="M14.0314 27.6584C12.6661 27.6584 11.5553 28.7692 11.5553 30.1345C11.5553 30.178 11.5561 30.2212 11.5585 30.2642C11.5675 30.4266 11.4894 30.5818 11.3544 30.6725C11.2194 30.7632 11.0466 30.7763 10.8987 30.7068C10.5677 30.5505 10.2132 30.4715 9.84433 30.4715C8.47894 30.4713 7.36819 31.5822 7.36819 32.9474C7.36822 33.2155 7.41081 33.4792 7.49518 33.7311C7.54825 33.8911 7.51046 34.0674 7.39633 34.1913C7.28224 34.3153 7.10943 34.3672 6.94549 34.3271C6.75261 34.2798 6.55411 34.2559 6.35399 34.2558C4.98938 34.2558 3.87866 35.3667 3.87866 36.732C3.87874 38.0971 4.98936 39.2079 6.35396 39.2079L23.5679 39.2079C24.9333 39.2079 26.0439 38.0972 26.0439 36.732C26.0439 35.7292 25.446 34.8318 24.5201 34.4458C24.4053 34.3977 24.3144 34.3058 24.2686 34.1903C24.222 34.0746 24.2244 33.9455 24.275 33.8317C24.4141 33.5164 24.484 33.1806 24.484 32.8335C24.484 31.468 23.3733 30.3574 22.0087 30.3574C21.41 30.3574 20.8321 30.574 20.3812 30.9672C20.2848 31.051 20.1586 31.092 20.0316 31.0792C19.9047 31.0666 19.7881 31.0024 19.7102 30.9015C19.2368 30.2889 18.5224 29.9376 17.75 29.9376C17.5122 29.9375 17.2775 29.9713 17.0509 30.0378C16.9255 30.0748 16.7897 30.0567 16.6779 29.9881C16.5663 29.9196 16.4891 29.8071 16.465 29.6783C16.2472 28.5079 15.2241 27.6584 14.0314 27.6584ZM16.915 33.7581L19.6555 33.758C19.9111 33.758 20.1184 33.9654 20.1184 34.2211C20.1184 34.4766 19.9111 34.6839 19.6555 34.6838H16.915C16.6595 34.6838 16.4521 34.4767 16.4521 34.2211C16.4521 33.9654 16.6594 33.7581 16.915 33.7581ZM10.132 35.1508L12.8718 35.1507C13.1274 35.1507 13.3346 35.358 13.3346 35.6136C13.3347 35.8693 13.1273 36.0765 12.8718 36.0765H10.1321C9.87573 36.0765 9.6691 35.8693 9.6691 35.6136C9.66915 35.3579 9.87565 35.1508 10.132 35.1508Z"
                          fill="#EFEEE5" />
                        <path fill-rule="evenodd" clip-rule="evenodd"
                          d="M29.4273 10.2439C23.6842 10.4137 20.8561 11.8265 19.4891 13.0021C17.6084 14.6194 17.4518 16.6158 18.1678 18.1968C21.0534 15.0916 23.2945 14.9396 23.4311 14.9334C23.6875 14.9213 23.9029 15.1194 23.9141 15.3747C23.9262 15.6289 23.7301 15.8446 23.4761 15.858C23.4505 15.8598 22.3502 15.9488 20.73 17.1325C20.141 17.5628 19.4357 18.1748 18.6589 19.0396C18.7016 19.0984 18.7456 19.1562 18.7907 19.213C20.0774 20.8304 22.5399 21.7797 24.9051 20.0412C26.4087 18.9351 28.3929 16.3376 29.4273 10.2439Z"
                          fill="#EFEEE5" />
                        <path fill-rule="evenodd" clip-rule="evenodd"
                          d="M1.58167 0.792236C0.527286 7.04337 0.831834 12.0589 2.46891 15.3212C3.77816 17.9305 5.8893 19.3435 8.42167 19.302C9.70915 19.2804 10.9636 18.8758 12.029 18.1889C11.3718 16.3923 10.6615 15.0713 10.0346 14.1248C8.52454 11.8452 7.16632 11.2006 7.1527 11.1944C6.92128 11.0877 6.81836 10.814 6.92362 10.5821C7.02893 10.3503 7.29974 10.2464 7.53281 10.3501C7.59557 10.3781 9.09435 11.0672 10.7459 13.5227C11.5379 14.7002 12.227 16.0628 12.8113 17.6044C13.5252 16.9892 14.112 16.2316 14.507 15.3732C15.5937 13.0135 15.0568 10.3407 12.9945 7.84716C10.7676 5.15322 6.92923 2.78111 1.58167 0.792236Z"
                          fill="#EFEEE5" />
                      </g>
                      <defs>
                        <clipPath id="clip0_1126_77">
                          <rect width="30" height="40" fill="white" transform="translate(0.195068)" />
                        </clipPath>
                      </defs>
                    </svg>
                  </div>
                  <p class="text-[13px] text-[#FFF] mt-2 text-center">
                    Public Presale
                  </p>
                  <div
                    class="mt-1 text-[#004322] text-[12px] font-medium px-3 py-1 rounded-[5px] bg-[#FFF] text-center flex flex-col md:flex-row items-center justify-center">
                    <span class="hidden md:block">Up To $100,000</span>
                    <span class="block ml-2">@$0.04/token</span>
                  </div>
                </div>

                <!-- Sprout -->
                <div class="flex flex-col items-center w-1/3 relative z-10 mb-sm-4">
                  <p class="font-semibold mb-1">Sprout</p>
                  <div
                    class="bg-[#033f24] w-[34px] h-[34px] border border-[#EFEEE580] rounded-full p-1 flex justify-center items-center mt-4 mt-sm-0">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 17 17" fill="none">
                      <g clip-path="url(#clip0_1126_93)">
                        <path
                          d="M7.16267 5.16721C6.51686 4.5214 5.36898 4.41568 4.68661 4.43893C4.66614 5.0399 4.72336 6.22949 5.41186 6.91802C6.05767 7.56383 7.20551 7.66943 7.88795 7.6463C7.90842 7.04533 7.85117 5.85574 7.16267 5.16721Z"
                          fill="#EFEEE5" />
                        <path
                          d="M8.89854 1.0385C8.71942 0.817656 8.53826 0.633937 8.39498 0.5C8.25176 0.633875 8.07058 0.817656 7.89145 1.0385C7.55639 1.45166 7.15698 2.08644 7.15698 2.76416C7.15698 3.67766 7.89411 4.56391 8.39304 5.03016C8.53664 4.89609 8.71864 4.71166 8.89854 4.48981C9.23361 4.07666 9.63301 3.44187 9.63301 2.76416C9.63301 2.08641 9.23361 1.45166 8.89854 1.0385Z"
                          fill="#EFEEE5" />
                        <path
                          d="M12.0722 4.44209C11.4711 4.42168 10.2816 4.47884 9.59311 5.16737C8.94726 5.81321 8.84173 6.96093 8.86479 7.64346C9.46586 7.66393 10.6553 7.60674 11.3439 6.91818C11.9897 6.27234 12.0953 5.12462 12.0722 4.44209Z"
                          fill="#EFEEE5" />
                        <path d="M8.85871 10.1876V7.64648H7.92121V10.1876H4.45483V11.6459H12.3251V10.1876H8.85871Z"
                          fill="#EFEEE5" />
                        <path d="M5.33862 12.5833L5.73206 16.5H11.0477L11.4412 12.5833H5.33862Z" fill="#EFEEE5" />
                      </g>
                      <defs>
                        <clipPath id="clip0_1126_93">
                          <rect width="16" height="16" fill="white" transform="translate(0.390381 0.5)" />
                        </clipPath>
                      </defs>
                    </svg>
                  </div>
                  <p class="text-[13px] text-[#FFF] mt-2 text-center">
                    Public Presale
                  </p>
                  <div
                    class="mt-1 text-[#004322] text-[12px] font-medium px-3 py-1 rounded-[5px] bg-[#FFF] text-center flex flex-col md:flex-row items-center justify-center">
                    <span class="hidden md:block">Up To $300,000</span>
                    <span class="block ml-2">@$0.06/token</span>
                  </div>
                </div>

                <!-- Growth -->
                <div class="flex flex-col items-center w-1/3 relative z-10 mb-sm-4">
                  <p class="font-semibold mb-1">Growth</p>
                  <div
                    class="bg-[#033f24] w-[34px] h-[34px] border border-[#EFEEE580] rounded-full p-1 flex justify-center items-center mt-4 mt-sm-0">
                    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 17 17" fill="none">
                      <g clip-path="url(#clip0_1126_118)">
                        <path
                          d="M13.8307 4.01996L10.3963 5.77008L10.8149 6.18866C11.1296 6.50335 11.3647 6.87774 11.5278 7.28021L13.9576 7.20819C14.5894 7.20819 15.183 6.96222 15.6297 6.51556C16.2372 5.9079 16.2372 4.91937 15.6297 4.31183C15.1546 3.83673 14.4315 3.71954 13.8307 4.01996Z"
                          fill="#EFEEE5" />
                        <path
                          d="M11.805 0.486908C11.1974 -0.120636 10.2089 -0.120636 9.60138 0.486908C9.15472 0.933563 8.90863 1.52719 8.90863 2.15903L8.83673 4.58884C9.2392 4.75192 9.61359 4.98703 9.92828 5.30173L10.3467 5.72031L12.097 2.28598C12.3974 1.68515 12.2802 0.962006 11.805 0.486908Z"
                          fill="#EFEEE5" />
                        <path
                          d="M9.26545 5.96472C8.7812 5.48047 8.11213 5.23279 7.42939 5.28492C6.74653 5.33741 6.12275 5.68409 5.71809 6.23621L5.65107 6.32776L7.38862 8.06543L6.72578 8.7284L5.09016 7.09278L2.8465 10.1523L4.73701 12.043L4.07404 12.7058L2.28547 10.9172L0.390816 13.5439C-0.0682909 14.17 -0.00322742 15.0222 0.545723 15.5713C1.09467 16.1202 1.94709 16.1853 2.57307 15.7262L7.49445 12.1488L6.06281 10.717L6.72578 10.0542L8.25947 11.5878L9.88068 10.3989C10.4329 9.99427 10.7796 9.37049 10.8321 8.6875C10.8842 8.00489 10.6365 7.33582 10.1523 6.85157L9.26545 5.96472Z"
                          fill="#EFEEE5" />
                      </g>
                      <defs>
                        <clipPath id="clip0_1126_118">
                          <rect width="16" height="16" fill="white" transform="translate(0.0857544 0.5)" />
                        </clipPath>
                      </defs>
                    </svg>
                  </div>
                  <p class="text-[13px] text-[#FFF] mt-2 text-center">Public Launch</p>
                  <div
                    class="mt-1 text-[#004322] text-[12px] font-medium px-3 py-1 rounded-[5px] bg-[#FFF] text-center">
                    <span class="block">@$0.08/token</span>
                  </div>
                </div>
              </div>
            </div>

            <!-- </div> -->
          </div>
          <div class="space-y-4 text-[#29282D] text-[14px] md:text-[16px]">
            <h1 class="text-[#004323] text-[24px] md:text-[28px] font-bold">
              $CGS Crypto Token Presale
            </h1>
            <p class="mb-1">
              We are pleased to announce an exclusive opportunity to participate in the
              Community Grocery Store (CGS) token presale.
            </p>
            <p class="mb-1">
              The presale represents a small fraction of the total public token supply.
              Consistent with our principles of transparency, fairness, and equality, we
              have eliminated private seed rounds, ensuring this presale is open and
              accessible to all. To promote market stability and protect token value, a
              mandatory vesting period applies to all presale tokens. This aligns with the
              vesting schedules enforced on the CGS founders’ and CGS treasury wallets,
              demonstrating our commitment to the project’s sustained success.
            </p>
            <p class="my-0">
              Following the presale, CGS tokens will next become available during our
              public launch on Uniswap at an initial price of $0.08 per token. Token
              holders will have the opportunity to participate in DAO governance, with
              additional incentives available for active governance participants.
            </p>
          </div>
          <div class="space-y-4 text-[#29282D] text-[14px] md:text-[16px]">
            <h1 class="text-[#004323] text-[24px] md:text-[28px] font-bold">
              Our Vision & Mission
            </h1>
            <p>
              CGS is dedicated to creating an advanced platform that empowers individuals
              by promoting self-sufficiency and reducing dependence on large corporate
              entities. Our mission is to build an app that benefits humanity by restoring
              autonomy to everyday people and encouraging sustainable, community-driven
              practices. Through the CGS platform, we aim to foster a fairer, more
              equitable future, guided by principles of transparency, accountability, and
              community engagement.
            </p>
          </div>
          <div class="flex flex-wrap gap-3 mt-[40px] justify-center md:justify-start">
            <Button v-for="(btn, index) in buttons" :key="index"
              :variant="activeButton === btn.type ? 'default' : 'outline'" @click="handleButtonClick(btn.type)" :class="[
                'flex items-center gap-2 !px-[20px] !py-[10px] rounded-[27px] text-[16px] font-normal cursor-pointer',
                activeButton === btn.type
                  ? 'bg-[#004322] text-white hover:bg-green-800 '
                  : 'border border-[#004322] bg-transparent hover:bg-stone-200/50 text-[#004322] ',
              ]">
              <!-- Active Button: Show White Circle -->
              <div v-if="activeButton === btn.type" class="flex items-center gap-2">
                <svg width="12" height="12" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg" class="fill-white">
                  <circle cx="50" cy="50" r="50" />
                </svg>

                <!-- Button Label -->
                {{ btn.label }}
              </div>
              <div v-else class="flex items-center gap-2">
                <!-- Button Label -->
                {{ btn.label }}
                <!-- Inactive Button: Show Arrow Icon -->
                <svg width="12" height="12" viewBox="0 0 12 12" xmlns="http://www.w3.org/2000/svg" fill="none">
                  <path d="M10.5043 1.00432L10.5043 10.013M10.5043 1.00432L1.49568 1.00432M10.5043 1.00432L0.5 11.0086"
                    stroke="#004322" stroke-width="1.3" />
                </svg>
              </div>
            </Button>
          </div>

          <div class="flex flex-col lg:flex-row lg:items-center">
            <div>
              <h4 class="mb-2 text-[#004322] text-[14px] font-normal text-center md:text-left">
                Join Our Community
              </h4>
              <div class="flex gap-2 justify-center md:justify-start">
                <Button @click="openLink('Telegramofficial')" variant="outline"
                  class="h-[50px] w-[50px] rounded-[10px] border border-[#004322] bg-[#004322] hover:bg-green-800 hover:text-white p-0 text-white cursor-pointer">
                  <img class="w-[50%]" src="/images/telegramicon.png" />
                </Button>
                <Button @click="openLink('Telegramcommunity')" variant="outline"
                  class="h-[50px] w-[50px] rounded-[10px] border border-[#004322] bg-[#004322] hover:bg-green-800 hover:text-white p-0 text-white cursor-pointer">
                  <img class="w-[50%]" src="/images/telegramicon.png" />
                </Button>
                <Button @click="openLink('xcommunity')" variant="outline"
                  class="h-[50px] w-[50px] rounded-[10px] border border-[#004322] bg-[#004322] hover:bg-green-800 hover:text-white p-0 text-white cursor-pointer">
                  <img class="w-[50%]" src="/images/twitter.png" />
                </Button>
              </div>
            </div>

            <div class="mt-3 lg:mt-0 lg:ml-20">
              <h4 class="mb-2 text-[#004322] text-[14px] font-normal text-center md:text-left">
                Coming Soon!
              </h4>
              <div class="flex gap-4 justify-center md:justify-start">
                <a href="#">
                  <img class="h-[50px] w-auto rounded-[10px] opacity-50 grayscale" src="/images/google-play-icon.svg"
                    alt="" style="filter: grayscale(0) opacity(0.5)" />
                </a>
                <a href="#">
                  <img class="h-[50px] w-auto rounded-[10px] opacity-50 grayscale" src="/images/app-store-icon.svg"
                    alt="" style="filter: grayscale(0) opacity(0.5)" />
                </a>
              </div>
            </div>
          </div>
        </div>

        <!-- Right Column - Swap Interface -->
        <div class="flex justify-end items-start 2xl:col-span-5">
          <CGSBalanceCard v-if="tab === 'cgs-balance'" @back-to-presale-clicked="tab = 'presale'" />
          <PresaleCard v-else @balance-clicked="tab = 'cgs-balance'" />
        </div>
      </div>
    </main>
    <footer class="flex justify-center items-center w-full py-4">

      <div class="flex flex-col flex-wrap lg:flex-row items-center justify-center gap-2 md:gap-0 w-full">
        <div class="flex flex-row w-full md:w-auto justify-center">
          <div @click="openLink('termsconditions')" class="flex items-center justify-center cursor-pointer pr-2 py-1">
            <span class="text-[#004322] text-[16px] font-medium mr-1">
              Terms & Conditions
            </span>
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="14" viewBox="0 0 16 14" fill="none">
              <path
                d="M3.57574 11.0757C3.34142 11.3101 3.34142 11.6899 3.57574 11.9243C3.81005 12.1586 4.18995 12.1586 4.42426 11.9243L3.57574 11.0757ZM12.6 3.5C12.6 3.16863 12.3314 2.9 12 2.9L6.6 2.9C6.26863 2.9 6 3.16863 6 3.5C6 3.83137 6.26863 4.1 6.6 4.1L11.4 4.1L11.4 8.9C11.4 9.23137 11.6686 9.5 12 9.5C12.3314 9.5 12.6 9.23137 12.6 8.9L12.6 3.5ZM4 11.5L4.42426 11.9243L12.4243 3.92426L12 3.5L11.5757 3.07574L3.57574 11.0757L4 11.5Z"
                fill="#004322" />
            </svg>
          </div>
          <span class="block lg:hidden mx-2 text-[#004322] self-center">|</span>
          <div @click="openLink('privacypolicy')" class="flex items-center justify-center cursor-pointer py-1 px-4">
            <span class="text-[#004322] text-[16px] font-medium mr-1">
              Privacy Policy
            </span>
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="14" viewBox="0 0 16 14" fill="none">
              <path
                d="M3.57574 11.0757C3.34142 11.3101 3.34142 11.6899 3.57574 11.9243C3.81005 12.1586 4.18995 12.1586 4.42426 11.9243L3.57574 11.0757ZM12.6 3.5C12.6 3.16863 12.3314 2.9 12 2.9L6.6 2.9C6.26863 2.9 6 3.16863 6 3.5C6 3.83137 6.26863 4.1 6.6 4.1L11.4 4.1L11.4 8.9C11.4 9.23137 11.6686 9.5 12 9.5C12.3314 9.5 12.6 9.23137 12.6 8.9L12.6 3.5ZM4 11.5L4.42426 11.9243L12.4243 3.92426L12 3.5L11.5757 3.07574L3.57574 11.0757L4 11.5Z"
                fill="#004322" />
            </svg>
          </div>
        </div>
        <div class="flex flex-row w-full md:w-auto mt-1 md:mt-0 justify-center">
          <div @click="openLink('communitygrocerystore')"
            class="flex items-center justify-center cursor-pointer px-4 py-1">
            <span class="text-[#004322] text-[16px] font-medium mr-1">
              communitygrocerystore.com
            </span>
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="14" viewBox="0 0 16 14" fill="none">
              <path
                d="M3.57574 11.0757C3.34142 11.3101 3.34142 11.6899 3.57574 11.9243C3.81005 12.1586 4.18995 12.1586 4.42426 11.9243L3.57574 11.0757ZM12.6 3.5C12.6 3.16863 12.3314 2.9 12 2.9L6.6 2.9C6.26863 2.9 6 3.16863 6 3.5C6 3.83137 6.26863 4.1 6.6 4.1L11.4 4.1L11.4 8.9C11.4 9.23137 11.6686 9.5 12 9.5C12.3314 9.5 12.6 9.23137 12.6 8.9L12.6 3.5ZM4 11.5L4.42426 11.9243L12.4243 3.92426L12 3.5L11.5757 3.07574L3.57574 11.0757L4 11.5Z"
                fill="#004322" />
            </svg>
          </div>
        </div>
        <div class="flex flex-row w-full md:w-auto mt-1 md:mt-0 justify-center">
          <div @click="openLink('fairlaunchpolicy')" class="flex items-center justify-center cursor-pointer px-4 py-1">
            <span class="text-[#004322] text-[16px] font-medium mr-1">
              Fair Launch Policy
            </span>
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="14" viewBox="0 0 16 14" fill="none">
              <path
                d="M3.57574 11.0757C3.34142 11.3101 3.34142 11.6899 3.57574 11.9243C3.81005 12.1586 4.18995 12.1586 4.42426 11.9243L3.57574 11.0757ZM12.6 3.5C12.6 3.16863 12.3314 2.9 12 2.9L6.6 2.9C6.26863 2.9 6 3.16863 6 3.5C6 3.83137 6.26863 4.1 6.6 4.1L11.4 4.1L11.4 8.9C11.4 9.23137 11.6686 9.5 12 9.5C12.3314 9.5 12.6 9.23137 12.6 8.9L12.6 3.5ZM4 11.5L4.42426 11.9243L12.4243 3.92426L12 3.5L11.5757 3.07574L3.57574 11.0757L4 11.5Z"
                fill="#004322" />
            </svg>
          </div>
           <span class="block lg:hidden mx-2 text-[#004322] self-center">|</span>
          <div @click="openLink('presaleterms')" class="flex items-center justify-center cursor-pointer px-4 py-1">
            <span class="text-[#004322] text-[16px] font-medium mr-1">
              Presale Terms
            </span>
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="14" viewBox="0 0 16 14" fill="none">
              <path
                d="M3.57574 11.0757C3.34142 11.3101 3.34142 11.6899 3.57574 11.9243C3.81005 12.1586 4.18995 12.1586 4.42426 11.9243L3.57574 11.0757ZM12.6 3.5C12.6 3.16863 12.3314 2.9 12 2.9L6.6 2.9C6.26863 2.9 6 3.16863 6 3.5C6 3.83137 6.26863 4.1 6.6 4.1L11.4 4.1L11.4 8.9C11.4 9.23137 11.6686 9.5 12 9.5C12.3314 9.5 12.6 9.23137 12.6 8.9L12.6 3.5ZM4 11.5L4.42426 11.9243L12.4243 3.92426L12 3.5L11.5757 3.07574L3.57574 11.0757L4 11.5Z"
                fill="#004322" />
            </svg>
          </div>
        </div>
      </div>
      <!-- DISCLAIMER MODAL -->
      <div v-if="showDisclaimer" class="fixed inset-0 bg-[#EFEEE5E5] z-40 flex items-center justify-center px-2">
        <!-- Modal -->
        <div
          class="bg-[#E8E6DB] rounded-[25px] border border-[#D2D0CE] shadow-lg w-full max-w-[600px] p-[30px] md:p-[50px] text-[#004322] overflow-y-auto max-h-[90vh]">
          <!-- Header -->
          <div class="flex items-center mb-4">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="21" viewBox="0 0 20 21" fill="none">
              <path
                d="M10 0.499878C4.47734 0.499878 0 4.97722 0 10.4999C0 16.0225 4.47734 20.4999 10 20.4999C15.5227 20.4999 20 16.0225 20 10.4999C20 4.97722 15.5227 0.499878 10 0.499878ZM11.2664 14.7022C11.2664 14.8685 11.2337 15.0332 11.17 15.1869C11.1064 15.3405 11.0131 15.4801 10.8955 15.5977C10.7779 15.7153 10.6383 15.8086 10.4846 15.8722C10.331 15.9359 10.1663 15.9686 10 15.9686C9.83369 15.9686 9.66901 15.9359 9.51537 15.8722C9.36172 15.8086 9.22211 15.7153 9.10452 15.5977C8.98692 15.4801 8.89364 15.3405 8.82999 15.1869C8.76635 15.0332 8.73359 14.8685 8.73359 14.7022V9.63621C8.73359 9.4699 8.76635 9.30522 8.82999 9.15157C8.89364 8.99793 8.98692 8.85832 9.10452 8.74072C9.22211 8.62313 9.36172 8.52984 9.51537 8.4662C9.66901 8.40256 9.83369 8.3698 10 8.3698C10.1663 8.3698 10.331 8.40256 10.4846 8.4662C10.6383 8.52984 10.7779 8.62313 10.8955 8.74072C11.0131 8.85832 11.1064 8.99793 11.17 9.15157C11.2337 9.30522 11.2664 9.4699 11.2664 9.63621V14.7022ZM10 7.56394C9.74953 7.56394 9.50468 7.48967 9.29642 7.35051C9.08816 7.21136 8.92584 7.01357 8.82999 6.78217C8.73414 6.55076 8.70906 6.29613 8.75793 6.05047C8.80679 5.80481 8.92741 5.57916 9.10452 5.40205C9.28163 5.22494 9.50728 5.10433 9.75294 5.05546C9.9986 5.0066 10.2532 5.03168 10.4846 5.12753C10.716 5.22338 10.9138 5.3857 11.053 5.59396C11.1921 5.80222 11.2664 6.04706 11.2664 6.29753C11.2665 6.46386 11.2337 6.62856 11.1701 6.78223C11.1065 6.9359 11.0132 7.07553 10.8956 7.19313C10.778 7.31074 10.6384 7.40402 10.4847 7.46765C10.331 7.53127 10.1663 7.56399 10 7.56394Z"
                fill="#004322" />
            </svg>
            <h2 class="text-lg font-bold text-[#004322] ml-2 mt-1">Disclaimer</h2>
          </div>

          <!-- Body -->
          <div class="space-y-4 text-[16px] leading-relaxed text-[#29282D]">
            <p>
              Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex
              sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis
              convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus
              fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada
              lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti
              sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.
            </p>
            <p>
              Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex
              sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis
              convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus
              fringilla.
            </p>
          </div>

          <!-- Footer -->
          <div class="mt-6 flex justify-end border-t border-[#004322] pt-4">
            <button @click="showDisclaimer = false"
              class="bg-[#004322] text-[#E8E6DB] text-[16px] font-normal px-6 py-2 rounded-full cursor-pointer hover:bg-[#00331A] transition duration-150 w-full md:w-auto">
              Close
            </button>
          </div>
        </div>
      </div>
      <!-- fairlaunch -->
      <div @click="fairlaunch = false" v-if="fairlaunch"
        class="fixed inset-0 bg-[#EFEEE5E5] z-40 flex items-center justify-center px-2">
        <!-- Modal -->
        <div
          class="bg-[#E8E6DB] rounded-[25px] border border-[#D2D0CE] shadow-lg w-full max-w-[600px] p-[30px] md:p-[50px] text-[#004322] overflow-y-auto max-h-[90vh]">
          <!-- Header -->
          <div class="flex items-center mb-4">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="21" viewBox="0 0 20 21" fill="none">
              <path
                d="M10 0.499878C4.47734 0.499878 0 4.97722 0 10.4999C0 16.0225 4.47734 20.4999 10 20.4999C15.5227 20.4999 20 16.0225 20 10.4999C20 4.97722 15.5227 0.499878 10 0.499878ZM11.2664 14.7022C11.2664 14.8685 11.2337 15.0332 11.17 15.1869C11.1064 15.3405 11.0131 15.4801 10.8955 15.5977C10.7779 15.7153 10.6383 15.8086 10.4846 15.8722C10.331 15.9359 10.1663 15.9686 10 15.9686C9.83369 15.9686 9.66901 15.9359 9.51537 15.8722C9.36172 15.8086 9.22211 15.7153 9.10452 15.5977C8.98692 15.4801 8.89364 15.3405 8.82999 15.1869C8.76635 15.0332 8.73359 14.8685 8.73359 14.7022V9.63621C8.73359 9.4699 8.76635 9.30522 8.82999 9.15157C8.89364 8.99793 8.98692 8.85832 9.10452 8.74072C9.22211 8.62313 9.36172 8.52984 9.51537 8.4662C9.66901 8.40256 9.83369 8.3698 10 8.3698C10.1663 8.3698 10.331 8.40256 10.4846 8.4662C10.6383 8.52984 10.7779 8.62313 10.8955 8.74072C11.0131 8.85832 11.1064 8.99793 11.17 9.15157C11.2337 9.30522 11.2664 9.4699 11.2664 9.63621V14.7022ZM10 7.56394C9.74953 7.56394 9.50468 7.48967 9.29642 7.35051C9.08816 7.21136 8.92584 7.01357 8.82999 6.78217C8.73414 6.55076 8.70906 6.29613 8.75793 6.05047C8.80679 5.80481 8.92741 5.57916 9.10452 5.40205C9.28163 5.22494 9.50728 5.10433 9.75294 5.05546C9.9986 5.0066 10.2532 5.03168 10.4846 5.12753C10.716 5.22338 10.9138 5.3857 11.053 5.59396C11.1921 5.80222 11.2664 6.04706 11.2664 6.29753C11.2665 6.46386 11.2337 6.62856 11.1701 6.78223C11.1065 6.9359 11.0132 7.07553 10.8956 7.19313C10.778 7.31074 10.6384 7.40402 10.4847 7.46765C10.331 7.53127 10.1663 7.56399 10 7.56394Z"
                fill="#004322" />
            </svg>
            <h2 class="text-lg font-bold text-[#004322] ml-2 mt-1">
              Fair Launch & Seed Policy
            </h2>
          </div>

          <!-- Body -->
          <div class="space-y-4 text-[16px] font-normal leading-relaxed text-[#29282D]">
            <p class="mb-4">
              Community Grocery Store (CGS) is committed to fairness, transparency, and
              community-first values. Our tokenomics model, expertly designed by
              Chainforce, reflects our dedication to creating an equitable and stable
              ecosystem.
            </p>

            <p class="font-medium mb-2">Fair Launch Principles:</p>
            <ol class="list-decimal pl-6 space-y-2">
              <li>
                Transparent Presale Allocation:
                <ul class="list-disc pl-6 mt-1 space-y-1 text-[#29282D]">
                  <li>
                    CGS has not conducted any private seed rounds. The only initial seed
                    available is through our publicly accessible Token Presale, ensuring
                    equal opportunity for all participants.
                  </li>
                  <li>
                    For full transparency, our lawyers own 1% of the 5% legal allocation,
                    vested linearly over 24 months in exchange for legal services.
                  </li>
                  <li>
                    For full transparency, our developers own 1% of the 9% App & Ecosystem
                    Development allocation, vested linearly over 60 months.
                  </li>
                </ul>
              </li>
            </ol>
          </div>

          <!-- Footer -->
          <div class="mt-6 flex justify-end border-t border-[#004322] pt-4">
            <button @click="fairlaunch = false"
              class="bg-[#004322] text-[#E8E6DB] text-[16px] font-normal px-6 py-2 rounded-full cursor-pointer hover:bg-[#00331A] transition duration-150 w-full md:w-auto">
              Close
            </button>
          </div>
        </div>
      </div>
    </footer>
  </div>
</template>
<style>
@media ((max-width: 464px)) {
  .flex-direction-column {
    flex-direction: column;
  }

  .d-time-line-none {
    display: none;
  }

  .mb-sm-4 {
    margin-bottom: 4px;
  }

  .mt-sm-0 {
    margin-top: 0px;
  }
}

/* 480px – 767px */

@media ((min-width: 2501px)) {
  .time-line-main-w {
    width: 1500px;
  }
}

@media ((min-width: 2377px) and (max-width: 2499px)) {
  .time-line-main-w {
    width: 1500px;
  }

  .time-line-w {
    width: 16%;
  }
}

@media ((min-width: 2040px) and (max-width: 2376px)) {
  .time-line-main-w {
    width: 1500px;
  }

  .time-line-w {
    width: 12%;
  }
}

@media ((min-width: 1536px) and (max-width: 1656px)) {
  .time-line-w {
    width: 11%;
  }
}

@media ((min-width: 1196px) and (max-width: 1357px)) {
  .time-line-w {
    width: 14%;
  }
}

@media ((min-width: 1139px) and (max-width: 1195px)) {
  .time-line-w {
    width: 12%;
  }
}

@media ((min-width: 1996px) and (max-width: 2039px)) {
  .time-line-main-w {
    width: 1200px;
  }

  .time-line-w {
    width: 16%;
  }
}

@media ((min-width: 1196px) and (max-width: 1224px)) {
  .time-line-w {
    width: 13%;
  }
}

/* @media ((max-width: 1639px)) {
  .time-line-w {
    width: 11%;
  }
} */

@media ((min-width: 1640px) and (max-width: 1995px)) {
  .time-line-w {
    width: 12%;
  }
}

@media ((min-width: 1053px) and (max-width: 1535px)) {
  .time-line-main-w {
    width: 1500px;
  }
}

@media ((min-width: 1495px) and (max-width: 1535px)) {
  .time-line-w {
    width: 16%;
  }
}

@media ((min-width: 1358px) and (max-width: 1494px)) {
  .time-line-w {
    width: 15%;
  }
}

/* @media ((max-width: 1145px)) {
  .time-line-w {
    width: 15%;
  }
} */
@media ((max-width: 1138px) and (min-width: 1053px)) {
  .time-line-w {
    width: 12%;
  }
}

@media ((min-width: 872px) and (max-width: 1052px)) {
  .time-line-w {
    width: 12%;
  }
}

@media ((min-width: 734px) and (max-width: 871px)) {
  .time-line-w {
    width: 10%;
  }
}

@media ((min-width: 973px) and (max-width: 1025px)) {
  .time-line-w {
    width: 12%;
  }
}

@media ((max-width: 723px)) {
  .time-line-w {
    width: 8%;
  }
}

@media ((min-width: 724px) and (max-width: 733px)) {
  .time-line-w {
    width: 10%;
  }
}

@media ((max-width: 550px)) {
  .time-line-w {
    width: 7%;
  }
}

@media ((max-width: 435px)) {
  .time-line-w {
    width: 7%;
  }
}
</style>
<script lang="ts" setup>
import { computed, ref } from 'vue'
import { useAccount } from '@wagmi/vue'
import { useAppKit } from '@reown/appkit/vue'

import CGSBalanceCard from './CGSBalanceCard.vue'
import PresaleCard from './PresaleCard.vue'
import { Button } from '@/components/ui/button'
import { abbreviateAddress } from '@/utils'

const { address, isConnected } = useAccount()
const { open } = useAppKit()
const showDisclaimer = ref(false)
const fairlaunch = ref(false)
const walletAddress = computed(() =>
  address.value ? abbreviateAddress({ address: address.value }) : ''
)
const tab = ref('presale')
const buttons = [
  { type: 'audits', label: 'Audits' },
  { type: 'strategy', label: 'Strategy' },
  { type: 'incentives', label: 'Incentives' },
  { type: 'revenue', label: 'Revenue' },
  { type: 'tokenomics', label: 'Tokenomics' },
  { type: 'timeline', label: 'Timeline' }
]

const activeButton = ref('audits')

const handleButtonClick = (type: string) => {
  activeButton.value = type
  openLink(type)
}
const openLink = (type: string) => {
  const links: any = {
    strategy:
      'https://www.communitygrocerystore.com/holders/community-grocery-store-holder-market-strategy',
    incentives:
      'https://www.communitygrocerystore.com/holders/community-grocery-store-holder-voting-incentives',
    revenue:
      'https://www.communitygrocerystore.com/holders/community-grocery-store-holder-revenue-streams',
    tokenomics:
      'https://www.communitygrocerystore.com/holders/community-grocery-store-holder-tokenomics',
    timeline:
      'https://www.communitygrocerystore.com/holders/community-grocery-store-holder-project-timeline',
    telegramofficial: 'https://t.me/commgroceryofficial',
    telegramcommunity: 'https://t.me/commgrocerycommunity',
    xcommunity: 'https://x.com/commgrocery',
    communitygrocerystore: 'https://www.communitygrocerystore.com/',
    privacypolicy: 'https://www.communitygrocerystore.com/privacy-policy',
    termsconditions: 'https://www.communitygrocerystore.com/terms-and-conditions',
    fairlaunchpolicy: 'https://www.communitygrocerystore.com/fair-launch-policy',
    presaleterms: 'https://www.communitygrocerystore.com/presale-disclaimer',
    audits: 'https://www.communitygrocerystore.com/community-grocery-store-smart-contract-kyc-audit'
  }

  const url: any = links[type.toLowerCase()]
  if (url) {
    window.open(url, '_blank')
  }
}
</script>
