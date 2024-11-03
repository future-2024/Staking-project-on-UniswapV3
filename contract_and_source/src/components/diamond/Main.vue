<template>
    <div class="diamond">
        <q-banner dense inline-actions
                  class="text-white q-py-sm q-mb-lg q-mx-sm text-h6 text-center text-uppercase flex"
                  v-if="banner"
        >
            <div class="row">
                <div class="col-11">
                    <q-icon name="notification_important"></q-icon>
                    Add liquidity to FTM-Diamond pair on SpiritSwap. <b>Burn those LP tokens</b> to get new Diamonds. <b>Read docs: <a href="https://docs.pumpkitten.com/fantoon/diamond-emissions" style="color:rgb(255 239 176);">HERE</a></b>.
                </div>
                <div class="col-1 flex items-center justify-end">
                    <q-icon name="close" class="cursor-pointer" @click="banner=false"></q-icon>
                </div>
            </div>
        </q-banner>
        <div>
            <div class="text-center q-mb-sm text-bold text-h5">
                <h2>Welcome to the Diamond Reserve!</h2>
                <h5 style="padding-left:30px;padding-right:30px;">You can get new Diamonds every day, based on our advanced<br/>community balanced emission system. 
                <a href="https://swap.spiritswap.finance/#/add/FTM/0xDDa0F0E1081b8d64aB1D64621eb2679F93086705" target="blank">
                Add FTM-Diamonds LP HERE
                </a>.
                </h5>
            </div>
            <div class="text-center q-mb-sm text-bold text-h4">
              <span class="css-timeline">START TIME : {{startDate}}</span>
              <span class="css-timeline">CURRENT DAY : {{this.$store.state.diamond.currentDay}}</span>
            </div>
            <div class="css-block">
                <h4 class="css-subtitle">Time until you can claim diamonds</h4>
                <div class="q-px-md">
                    {{ dateTime.hours }}:{{ dateTime.minutes }}:{{ dateTime.seconds }}
                </div>
            </div>
            <div class="css-block">
                <h4 class="css-subtitle">Total LPs Received Today</h4>
                <div class="q-px-md">{{totalLPTokens.toFormat(5)}}
                    <span class="q-px-sm">LP Tokens</span>
                </div>
            </div>
            <div class="css-block">
                <h4 class="css-subtitle">Total DAILY Members</h4>
                <div class="q-px-md">{{this.$store.state.diamond.totalMember}}
                  <span class="q-px-sm">MEMBERS</span></div>
            </div>
            <div class="css-block">
                <h4 class="css-subtitle">Current DAILY Emission</h4>
                <div class="q-px-md">{{totalDiamond.toFormat(5)}}
                  <span class="q-px-sm">DIAMONDS</span></div>
            </div>
            <div class="css-buttons">
                <button class="action" @click="selectBurnModal">Send LP Tokens</button>
                <button class="action" @click="selectClaimModal">Claim Diamonds</button>
            </div>
            <div class="q-pt-sm" style="padding-top:15px;">
              <div class="css-block-transparent flex">
                <div class="css-block-another q-mt-sm">
                  <h4 class="css-subtitle">Current Token Price</h4>
                  <div class="q-px-sm css-sm-another">
                    <span class="css-diamond">DIAMONDS</span>
                     : 
                     <span class="css-USD">$ </span>
                     {{diamondPrice.toFormat(5)}} 
                  </div>
                  <div class="q-px-sm css-sm-another">
                    <span class="">LP</span>
                     TOKENS :  
                     <span class="css-USD">$ </span>
                     {{lpPrice.toFormat(5)}} 
                  </div>
                </div>
                <div class=" css-block-another q-mt-sm">
                  <h4 class="css-subtitle">Your Information</h4>
                  <div class="q-px-sm css-sm-another">
                    LPs Sent : {{totalUserLPTokens.toFormat(5)}} <span class="">LP</span>
                  </div>
                  <div class="q-px-sm css-sm-another">
                    Potential : {{potentialReward.toFormat(5)}} <span class="css-diamond">DIAMONDS</span>
                  </div>
                  <div class="q-px-sm css-sm-another">
                    Claimable : {{getPendingDiamond}} <span class="css-diamond">DIAMONDS</span>
                  </div>
                </div>
              </div>
            </div>
        </div>
        <div v-if="showModalBurn" class="modal">
            <div class="modal__content">
                <div class="model__content__item">
                    <div style="font-size: 1.5rem; color: #fff">Send LP to Get Diamonds</div>
                    <q-btn icon="close" flat round dense
                          @click="showModalBurn = !showModalBurn" color="white">
                    </q-btn>
                </div>
                <div class="model__content__item4">Select Your LP Token</div>
                <q-select 
                    id="BurnToken"
                    v-model="selectedTokenForBurn" 
                    class="selectBurnToken"
                    :options="items" 
                    label=""
                    @input="changeTokenForBurn()"
                    dense 
                    outlined 
                    autocomplete="off">
                </q-select>
                <div class="model__content__item">
                  <q-input type="text" v-model="amount" placeholder="🔥🔥🔥"
                    standout="bg-blue"
                    :error-message="errorMessage" :error="errorMessage!=null" 
                    @input="getPossibleDiamondRewards" 
                    :bottom-slots="false" :hide-bottom-space="true" class="search">
                    <template v-slot:append>
                        <div class="flex">
                            <span class="q-mr-sm balance">Balance: {{maxLP.toFormat(2)}}</span>
                            <q-btn rounded outline color="red" size="sm" @click="getMaxLP">
                                MAX
                            </q-btn>
                        </div>
                    </template>
                  </q-input>
                </div>
                <div class="model__content__item2">
                    {{totalPossibleDiamondRewards}} 
                    <span class="css_token">DIAMONDS</span>
                </div>
                <div class="text-center">
                    <div class="model__content__item3">
                        POTENTIAL SHARE ONLY
                    </div>
                </div>
                <div class="model__content__item">
                    <button v-if="isMetaMaskConnected && !isApproved" @click="approve" 
                      class="btn">Approve
                    </button>
                    <button v-if="isMetaMaskConnected && isApproved" @click="sendToken" 
                      class="btn"
                      :disabled="!isEnableSendLPToken">Send LP
                    </button>
                </div>
            </div>
        </div>
        <div v-if="showModalClaim" class="modal">
            <div class="modal__content">
                <div class="model__content__item">
                    <div style="font-size: 1.5rem; color: #fff">Get Diamonds</div>
                     <q-btn icon="close" flat round dense
                          @click="showModalClaim = !showModalClaim" color="white">
                    </q-btn>
                </div>
                <div class="model__content__item4">Select Your LP Token</div>
                <q-select 
                    class="selectBurnToken"
                    v-model="selectedTokenForClaim" 
                    :options="items" 
                    label="" 
                    item-text="name" 
                    @input="changeTokenForClaim()"
                    dense outlined solo autocomplete="off">
                </q-select>
                <div class="model__content__item2 q-my-sm">
                    {{getPendingDiamond}} 
                    <span class="css_token">DIAMONDS</span>
                </div>
                <div class="text-center">
                    <div class="model__content__item3">
                        YOUR CLAIMABLE DIAMONDS
                    </div>
                </div>
                <div class="model__content__item">
                    <button id="claim" :disabled="getPendingDiamond == 0" 
                            @click="claim" class="btn">Claim</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import BigNumber from 'bignumber.js'
export default {
  data() {
    return {
      banner: true,
      showModalBurn: false,
      showModalClaim: false,
      items: [],
      selectedTokenForBurn: null,
      amount: null,
      selectedTokenForClaim: null,
      dateTime: {
        hours: null,
        minutes: null,
        seconds: null,
      },
      timer: undefined,
      max: null
    };
  },
  beforeMount() {
    this.timer = setInterval(this.setNextHourTime, 1000);
  },
  beforeUnmount() {
    clearInterval(this.timer);
  },
  computed: {
      isMetaMaskInstalled() {
          const {ethereum} = window;
          return Boolean(ethereum && ethereum.isMetaMask)
      },
      isMetaMaskConnected() {
          return this.$store.state.account != null;
      },
      isApproved() {
          let tokenIndex = this.items.findIndex(x => x=== this.selectedTokenForBurn)
          if (tokenIndex == null)
            return false;
          let result
          if (tokenIndex == 0)
            result =  this.$store.state.approvedDiamond0
          else if (tokenIndex == 1)
            result = this.$store.state.approvedDiamond1
          return result
      },
      hasMessage() {
          return this.$store.state.messageContent!=null
      },
      errorMessage() {
          if (this.amount == null || this.amount == "")
              return;

          let index = this.items.findIndex(x => x=== this.selectedTokenForBurn);
          let max;
          if (index == 0) {
            max = BigNumber(this.$store.state.diamond.balanceLP0)
                    .shiftedBy(-18)
          }
          else if (index == 1) {
            max = BigNumber(this.$store.state.diamond.balanceLP1)
                    .shiftedBy(-18)
          }
          
          if(BigNumber(this.amount).isGreaterThan(max)) {
              return "INSUFFICIENT ACCOUNT BALANCE"
          }

          return null
      },
      startDate() {
          let date = this.$store.state.diamond.startTime;
          const options = { year: 'numeric', month: 'numeric', day: 'numeric', hour: 'numeric', minute: 'numeric' }
          const dtf = new Intl.DateTimeFormat('en-US', options);
          return dtf.format(date)
      },
      totalLPTokens() {
          if(this.$store.state.diamond.totalLPTokens > 0)
              return BigNumber(this.$store.state.diamond.totalLPTokens).shiftedBy(-18)
          return BigNumber(0)
      },
      totalDiamond() {
          if(this.$store.state.diamond.totalEmission > 0)
              return BigNumber(this.$store.state.diamond.totalEmission).shiftedBy(-18)
          return BigNumber(0)
      },
      totalPossibleDiamondRewards() {
          if(this.$store.state.diamond.currentPossibleRewards > 0)
              return BigNumber(this.$store.state.diamond.currentPossibleRewards).shiftedBy(-18).toFormat(5)
          return BigNumber(0)
      },
      getPendingDiamond() {
          if(this.$store.state.diamond.pendingDiamond > 0)
            return (this.$store.state.diamond.pendingDiamond).shiftedBy(-18).toFormat(5)
          return BigNumber(0)
      },
      isPendingDiamond() {
          if(this.$store.state.diamond.pendingDiamond > 0)
            return true
          return false
      },
      isEnableSendLPToken() {
          let endTime = this.$store.state.diamond.nextDay;
          let currentTime = Date.now();
          var difference = currentTime - endTime;

          if (difference > 0)
            return false;
          else
            return true;
      },
      maxLP() {
        let index = this.items.findIndex(x => x=== this.selectedTokenForBurn)
        if (index == -1)
          return BigNumber(0)

        if(this.$store.state.account) {
          if (index == 0) {
            return BigNumber(this.$store.state.diamond.balanceLP0)
                    .shiftedBy(-18)
          }
          else if (index == 1)
            return BigNumber(this.$store.state.diamond.balanceLP1)
                    .shiftedBy(-18)
        }

        return BigNumber(0)
      },
      totalUserLPTokens() {
          if(this.$store.state.diamond.userSentLP > 0)
              return BigNumber(this.$store.state.diamond.userSentLP).shiftedBy(-18)
          return BigNumber(0)
      },
      diamondPrice() {
          if(this.$store.state.price.Diamond > 0)
              return BigNumber(this.$store.state.price.Diamond)
          return BigNumber(0)
      },
      lpPrice() {
          if(this.$store.state.price.LP_FTM_Diamond > 0)
              return BigNumber(this.$store.state.price.LP_FTM_Diamond)
          return BigNumber(0)
      },
      potentialReward() {
        let memberUnits = BigNumber(this.$store.state.diamond.userSentLP);
        let totalEmission = BigNumber(this.$store.state.diamond.totalEmission);
        let totalUnits = BigNumber(this.$store.state.diamond.totalLPTokens);

        let reward = totalEmission.times(memberUnits).div(totalUnits);

        if (reward > 0)
            return BigNumber(reward).shiftedBy(-18)
        return BigNumber(0)
      }
  },
  async mounted() {
  },
  methods: {
      getMaxLP() {
        this.amount = this.maxLP;
        this.getPossibleDiamondRewards();
      },
      setNextHourTime() {
          let endTime = this.$store.state.diamond.nextDay;

          let currentTime = Date.now();
          var difference = endTime - currentTime - 60 * 2 * 1000;   // not sure why subside 1 minutes.
          if (difference < 0) {
            this.dateTime = {
              hours: "00",
              minutes: "00",
              seconds: "00",
            };

            return; 
          }

          var daysDifference = Math.floor(difference/1000/60/60/24);
          difference -= daysDifference*1000*60*60*24;
          var hoursDifference = Math.floor(difference/1000/60/60);
          var hourString;
          if (hoursDifference < 10)
            hourString = "0" + hoursDifference.toString();
          else
            hourString = hoursDifference.toString();
          difference -= hoursDifference*1000*60*60;
          var minutesDifference = Math.floor(difference/1000/60);
          var minutesString;
          if (minutesDifference < 10)
            minutesString = "0" + minutesDifference.toString();
          else
            minutesString = minutesDifference.toString();
          difference -= minutesDifference*1000*60;
          var secondDifference = Math.floor(difference/1000);
          var secondString;
          if (secondDifference < 10)
            secondString = "0" + secondDifference.toString();
          else
            secondString = secondDifference.toString();
          this.dateTime = {
            hours: hourString,
            minutes: minutesString,
            seconds: secondString,
          };
      },
      selectBurnModal() {
        if(!this.$store.state.account)
        {
          this.$store.commit('show_warning','Please connect a wallet.')
          return;
        }
        this.amount = null;
        this.$store.state.diamond.currentPossibleRewards = 0;

        if (this.$store.state.contracts.tokenLP[0] != null) {
          this.items[0] = "FTM/Diamond";
        }

        if (this.$store.state.contracts.tokenLP[1] != null) 
        {
          this.items[1] = "DIAMOND/BNB";
        }

        this.selectedTokenForBurn = this.items[0];
        this.showModalBurn = !this.showModalBurn;
      },
      selectClaimModal() {
        if(!this.$store.state.account)
        {
          this.$store.commit('show_warning','Please connect a wallet.')
          return;
        }
        this.$store.state.diamond.pendingDiamond = 0;

        if (this.$store.state.contracts.tokenLP[0] != null) {
          this.items[0] = "FTM/Diamond";
        }

        if (this.$store.state.contracts.tokenLP[1] != null) 
        {
          this.items[1] = "DIAMOND/BNB";
        }

        this.selectedTokenForClaim = this.items[0];
        this.showModalClaim = !this.showModalClaim;
        
        this.changeTokenForClaim();
      },
      async approve() {
        if (this.selectedTokenForBurn == null)
        {
          this.$store.commit('show_warning','Please select a LP token.')
          return;
        }
        await this.$store.dispatch('approveDiamond', {
          tokenIndex:this.items.findIndex(x => x=== this.selectedTokenForBurn)
        })
      },
      sendToken() {
        if (this.selectedTokenForBurn == null)
        {
          this.$store.commit('show_warning','Please select a LP token.')
          return;
        }
        if (this.amount == null)
        {
           this.$store.commit('show_warning','Please input token amount.')
            return;         
        }
        this.$store.dispatch("sendToken", {
            tokenIndex:this.items.findIndex(x => x=== this.selectedTokenForBurn),
            amount:this.amount
        })
      },
      changeTokenForBurn() {
        this.amount = "";
        let index = this.items.findIndex(x => x=== this.selectedTokenForBurn);
        
        this.$store.dispatch("getDiamondRewards", {
          tokenIndex:this.items.findIndex(x => x=== this.selectedTokenForBurn),
          amount:this.amount
        })
      },
      getPossibleDiamondRewards() {
        if (this.selectedTokenForBurn == null) {
          return;
        }
        this.$store.dispatch("getDiamondRewards", {
          tokenIndex:this.items.findIndex(x => x=== this.selectedTokenForBurn),
          amount:this.amount
        })
      },
      changeTokenForClaim() {
        let index = this.items.findIndex(x => x=== this.selectedTokenForClaim);

        this.$store.dispatch("pendingDiamondRewards", {
          tokenIndex:this.items.findIndex(x => x=== this.selectedTokenForClaim)
        })
      },
      claim() {
        if (this.selectedTokenForClaim == null)
        {
          this.$store.commit('show_warning','Please select a LP token.')
          return;
        }
        if (this.$store.state.diamond.pendingDiamond == 0)
        {
          this.$store.commit('show_warning','No Diamond Rewards.')
          return;
        }
        this.$store.dispatch("withdraw", {
            tokenIndex:this.items.findIndex(x => x=== this.selectedTokenForClaim),
        })
      }
  }
};
</script>

<style>
  .diamond {
      background-color:#eefdfe;
      background-size:cover;
      padding:20px 5px;
      color:#000 !important;
  }
  .action {
    background: #000;
    margin: 0 10px;
    border: none;
    border-radius: 10px;
    padding: 10px;
    font-size: 1rem;
    color: #fff;
    font-weight: 600;
    cursor: pointer;
    width: 22ch;
  }
  .action:hover {
      background-color: #524b48;
  }
  .css-buttons {
      margin-inline: auto;
      width: 40ch;
      font-size: 22px;
      text-align: center;
  }
  .hilight {
      color:rgb(255, 255, 0)
  }
  .css-block {
      margin-inline: auto;
      width: 35rem;
      background:#f36128;
      border-radius: 10px;
      border: 1px solid rgba(255, 255, 255, 0.2);
      margin-bottom: 15px;
      padding: 15px;
      color: white;
      font-size: 22px;
      font-weight: normal;
      font-family: Arial,sans-serif;
  }

  .css-block-transparent {
      margin-inline: auto;
      width: 35rem;
      border-radius: 10px;
      border: none;
      background: #f36128;
      margin-bottom: 15px;
      padding: 10px 15px 18px 15px;
      color: white;
      font-size: 22px;
      font-weight: normal;
      font-family: Arial,sans-serif;
  }

  .css-subtitle {
      text-transform: uppercase;
      font-weight: bold;
      font-size: 16px;
      font-style: italic;
      margin-bottom: 10px;
      opacity: 0.7;
  }
  .css-block-another {
      margin-inline: auto;
      width: 16rem !important;
      background: rgb(42 71 68);
      border-radius: 10px;
      border: 1px solid rgb(36 50 49);
      padding: 15px;
      color: white;
      font-weight: normal;
      font-family: Arial,sans-serif;
  }

  .css-USD {
    color:rgba(255, 255, 0, 0.8)
  }

  .css-diamond {
    color:rgb(0, 255, 0, 0.8)
  }

  .css-lp {
    color:rgb(255, 0, 0, 0.8)
  }

  .css-sm-another {
      font-weight: bold;
      font-size: 12px;
      margin-bottom: 10px;
  }
  .css-overview {
      font-weight: bold;
      font-size: 30px;
      margin-inline: auto;
      width: 100%;
      margin-bottom: 30px;
      text-align: center;
  }
  .css-timeline {
      font-size: 14px;
      font-weight: bold;
      padding: 6px 8px;
  }
  .css-timeblock {
      display: flex;
      max-width: 60ch;
      padding: 0px 6px;
      margin: 5px auto;
  }
  .modal {
      position: fixed;
      top: 0;
      bottom: 0;
      left: 0;
      right: 0;
      background-color: #0000006c;
      backdrop-filter: blur(10px);
      z-index: 2000;
      display: flex !important;
      justify-content: center;
      align-items: center;
  }
  .modal__content {
      width: 450px;
      padding: 20px 30px;
      border: 2px solid rgba(63, 210, 255, 0.308);
      border-radius: 10px;
      background-color:rgb(37, 34, 34);
      font-weight: bold;
      color: #fff;
      background-origin: border-box;
      background-clip: padding-box, border-box;
  }
  .model__content__item {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin: 10px 0;
      font-family: Arial,sans-serif;
  }
  .model__content__item2 {
      margin-inline: auto;
      font-weight: bold;
      font-family: Arial,sans-serif;
      text-align: center;
      padding: 10px 20px 0px 20px;
      font-size: 1.5rem;
  }
  .model__content__item3 {
      display: inline-block;
      background-color: rgb(216, 210, 129);
      margin: 2px;
      border: none;
      border-radius: 5px;
      padding: 2px 20px;
      font-size: 0.6rem;
      font-weight:bold;
      color: rgb(76, 69, 69);
      font-family: Arial,sans-serif;
      text-align: center;
  }
  .model__content__item4
  {
    font-size: 0.8rem; 
    color: #ccc; 
    font-weight:500;
    margin-left:5px;
  }
  .model__content__item > .btn {
      background: #f36128;
      width: 100%;
      margin-top: 15px;
      border: none;
      border-radius: 5px;
      padding: 10px;
      font-size: 1rem;
      font-weight:bold;
      color: #fff;
      cursor: pointer;
  }
  .model__content__item > .btn:hover {
      background-color: #faa786;
  }
  .modal__content .row{
      margin-right: 0px !important;
      margin-left: 0px !important;
  }
  .search {
      width: 100%;
      border: 1px solid rgba(63, 210, 255, 0.308);
      border-radius: 5px;
      padding: 0px;
      font-weight: bold;
      color: white !important;
      background-origin: border-box;
      background-clip: padding-box, border-box;
  }

  .search .q-field__native {
      color: white;
  }

  .search .q-field__control, .q-field__marginal {
      color: black;
      height: 45px !important;
  }

  .balance {
      margin-top:5px; 
      color:grey; 
      font-size:12px
  }

  .selectBurnToken {
      border-radius: 5px;
      font-weight: bold;
      color: #fff;
      background-color: #fff;
      padding: 0;
      font-size:14px;
  }

  .col {
      padding:0 !important;
  }
  .css_token {
    color:rgb(35, 173, 16);
  }
  .q-btn--dense.q-btn--round {
      height: 2.4em;
      width: 2.4em;
      min-height: 2.4em;
      min-width: 2.4em;
  }

  .q-menu, .q-select__dialog {
    font-size: 14px;
    padding-left:10px;
    background: #000;
    border: 0.1rem solid grey;
    color:#fff;
    border-radius: 2px;
  }

  .q-menu .row {
    margin-right:0px !important;
    padding-right:7px !important;
    padding-left:10px !important;
  }

  .q-select__dialog .row {
    margin-right:0 !important;
  }

  .q-item.q-router-link--active, .q-item--active {
    color: #ffffff;
  }
</style>
