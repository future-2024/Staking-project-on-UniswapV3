<template>
    <div class="lge">
        <q-banner dense inline-actions
                  class="text-white q-py-sm q-mb-lg q-mx-sm text-h6 text-center text-uppercase flex"
                  v-if="banner"
        >
            <div class="row">
                <div class="col-11">
                    <q-icon name="notification_important"></q-icon>
                    Using smart contracts, tokens and crypto has always its risks.
                    DYOR before using our beta.
                </div>
                <div class="col-1 flex items-center justify-end">
                    <q-icon name="close" class="cursor-pointer" @click="banner=false"></q-icon>
                </div>
            </div>
        </q-banner>
        <h4 class="text-center q-mb-sm text-bold text-h5">A 100% community driven Liquidity Generation Event organised with SpiritSwap</h4>
        <p v-if="!isMetaMaskConnected" class="text-center q-mt-sm event-message">
            Please connect wallet to check the status.
        </p>
        <p v-if="isMetaMaskConnected && resultPeriodEndDate != '0'" class="text-center q-mt-sm event-message">
            Event ends in 
            <span class="pb-1 font-weight-bold text-blue">
                {{
                    this.dateTime.days || "00"
                }}
            </span>
            <span>Days</span>
            <span class="h1 pb-1 font-weight-bold text-blue">
                {{
                    this.dateTime.hours || "00"
                }}
            </span>
            <span>Hours</span>
            <span class="h1 pb-1 font-weight-bold text-blue">
                {{
                    this.dateTime.minutes || "00"
                }}
            </span>
            <span>Min</span>
            <span class="h1 pb-1 font-weight-bold text-blue">
                {{
                    this.dateTime.seconds || "00"
                }}</span>
            <span> Sec</span>
        </p>
        <p v-if="isMetaMaskConnected && resultPeriodEndDate == '0'" class="text-center q-mt-sm event-message">
            The event has ended.
        </p>
        <div class="q-mt-md flex justify-center items-baseline">
            <button class="button" @click="detail">Details</button>
            <button class="button" @click="contract">Contract</button>
            <button class="button" @click="claim">Claim</button>
        </div>
        <p v-if="isMetaMaskConnected" class="text-center q-mt-sm text-bold text-pink">Vesting Period: {{resultBeginDate}} ~ {{resultEndDate}}</p>
        <div class="text-center flex justify-center q-pt-md">
          <!--  <p style="max-width: 650px"><b>A total of 12500 Diamond tokens are available</b> during this 3 days event and <b>claiming starts in 15 days</b>. The collected FTM + 10K Diamonds will be added to Spirit LP, <b>giving you, the LGE participants a 25%</b> price gain instantly. <b><a href="https://discord.gg/Gj7JqN2mXZ">More Details HERE</a></b>.
            </p>
        </div>
        <div class="justify-center flex items-center text-bold">
            <div class="q-pa-lg q-mx-lg">
                <div class="flex items-center q-mb-md">
                    <div>
                        <img :src="require(`@/assets/ftm.png`)" class="avatar" />
                    </div>
                    <div class="flex items-baseline q-pl-sm">
                        <h4 class="q-my-none">
                            <div v-if="totalFTM.isGreaterThan(2000)">{{totalFTM.shiftedBy(-3).toFormat(2)}}k</div>
                            <div v-else>{{totalFTM.toFormat(2)}}</div>
                        </h4>
                        <div class="q-pl-sm">FTM</div>
                    </div>
                </div>
                <p class="text-center">Total Collected</p>
            </div>
            <div class="q-pa-lg q-mx-lg">
                <div class="flex items-center q-mb-md">
                    <div>
                        <img :src="require(`@/assets/diamond.png`)" class="avatar" />
                    </div>
                    <div class="flex items-baseline q-pl-sm">
                        <h4 class="q-my-none">{{parseFloat(diamondPrice).toFixed(7)}}</h4>
                        <div class="q-pl-sm">FTM</div>
                    </div>
                </div>
                <p class="text-center">Current Price</p>
            </div>-->
        </div>
        <div class="justify-center flex" style="font-size:12px;">
            <div class="label_left text-bold">
                <div>
                    FTM You Spent : 
                </div>
                <div>
                    <span v-if="userSharedFTM.isGreaterThan(2000)">{{userSharedFTM.shiftedBy(-3).toFormat(2)}}k FTM</span>
                    <span v-else>{{userSharedFTM.toFormat(2)}}</span>
                    <img :src="require(`@/assets/ftm.png`)" class="avatar_sm q-mx-sm" />
                </div>
            </div>
            <div class="label_right text-bold">
                <div>
                    <span>DIAMOND (</span>
                    <span>Claimed / </span>
                    <span class="hilight">Claimable</span>
                    <span> / </span>
                    <span class="blue_hilight">Total</span>
                    <span> ) </span>    
                </div>
                <div>
                    <span v-if="userClaimedDiamond.isGreaterThan(2000)">{{userClaimedDiamond.shiftedBy(-3).toFormat(2)}}k</span>
                    <span v-else>{{userClaimedDiamond.toFormat(2)}}</span>
                    <span class="hilight" v-if="userSharedDiamond.isGreaterThan(2000)"> / {{userSharedDiamond.shiftedBy(-3).toFormat(2)}}k</span>
                    <span class="hilight" v-else> / {{userSharedDiamond.toFormat(2)}}</span>
                    <span class="blue_hilight" v-if="userTotalSharedDiamond.isGreaterThan(2000)"> / {{userTotalSharedDiamond.shiftedBy(-3).toFormat(2)}}k DIAMOND</span>
                    <span class="blue_hilight" v-else> / {{userTotalSharedDiamond.toFormat(2)}}</span>
                    <img :src="require(`@/assets/diamond.png`)" class="avatar_sm q-mx-sm" />
                </div>
            </div>
        </div>
        <div v-if="resultPeriodEndDate != '0'" 
                class="justify-center flex ftm q-mt-sm q-mb-lg" >
            <q-input type="text" prefix="FTM" v-model="amountFTM"
                standout="bg-blue text-black" placeholder="0.0"
                :error-message="errorMessage" :error="errorMessage!=null" 
                :bottom-slots="false" :hide-bottom-space="true" class="q-px-mdlg ftmInput">
                <template v-slot:append>
                    <div class="flex">
                        <span class="q-mr-sm balance">Balance: {{maxFTM}}</span>
                        <q-btn rounded outline color="red" size="sm" @click="getMaxFTM">
                            MAX
                        </q-btn>
                    </div>
                </template>
            </q-input>
            <button class="button" @click="depositFTM"> Send FTM </button>
        </div>
    </div>
</template>

<script>
import BigNumber from 'bignumber.js'
    export default {
        components: {},
        data() {
            return {
                banner: true,
                tab: 'stake',
                amountFTM: null,
                dateTime: {
                        days: 0,
                        hours: 0,
                        minutes: 0,
                        seconds: 0,
                    },
            }
        },
        beforeMount() {
            this.timer = setInterval(this.getUnlockTime, 1000);
        },
        computed: {
            maxFTM() {
                if(this.$store.state.account) {
                    return BigNumber(this.$store.state.balance)
                        .shiftedBy(-18).toFormat(2)
                }
                return 0
            },
            isMetaMaskConnected() {
                return this.$store.state.account!=null;
            },
            resultBeginDate() {
                let date = this.$store.state.liquiditygenerator.vestingBegin;
                const options = { year: 'numeric', month: 'numeric', day: 'numeric', hour: 'numeric', minute: 'numeric' }
                const dtf = new Intl.DateTimeFormat('en-US', options);
                return dtf.format(date)
            },
            resultEndDate() {
                let date = this.$store.state.liquiditygenerator.vestingEnd;
                const options = { year: 'numeric', month: 'numeric', day: 'numeric', hour: 'numeric', minute: 'numeric' }
                const dtf = new Intl.DateTimeFormat('en-US', options);
                return dtf.format(date)
            },
            resultPeriodEndDate() {
                let enddate = this.$store.state.liquiditygenerator.periodEnd;

                let currentTime = Date.now();

                var difference=enddate - currentTime;

                if (difference < 0)
                    return "0"; 

                var daysDifference = Math.floor(difference/1000/60/60/24);
                difference -= daysDifference*1000*60*60*24;

                var hoursDifference = Math.floor(difference/1000/60/60);
                difference -= hoursDifference*1000*60*60;

                var minutesDifference = Math.floor(difference/1000/60);
                difference -= minutesDifference*1000*60;

                var result = daysDifference.toString() + " days " +  hoursDifference.toString() + " hours " + minutesDifference.toString() + " minutes"

                return result
            },
            errorMessage() {
                if (this.amountFTM == null || this.amountFTM == "")
                    return;
                    
                if(BigNumber(this.amountFTM).isGreaterThan(this.maxFTM)) {
                    return "INSUFFICIENT ACCOUNT BALANCE"
                }
                else if (BigNumber(this.amountFTM) < 0.1){
                    return "MINIMAL AMOUNT VALUE IS 0.1 FTM"
                }
                else if (BigNumber(this.amountFTM) > 10000){
                    return "MAXIMAL AMOUNT VALUE IS 10K FTM"
                }
                return null
            },
            totalFTM() {
                if(this.$store.state.liquiditygenerator.totalFTMShares > 0)
                    return BigNumber(this.$store.state.liquiditygenerator.totalFTMShares).shiftedBy(-18)
                return BigNumber(0)
            },
            diamondPrice() {
                if(this.$store.state.liquiditygenerator.diamondPriceInLGE > 0)
                    return BigNumber(this.$store.state.liquiditygenerator.diamondPriceInLGE)
                return BigNumber(0)
            },
            userSharedFTM() {
                if(this.$store.state.liquiditygenerator.RecipientInfo != null)
                    return BigNumber(this.$store.state.liquiditygenerator.RecipientInfo.shares).shiftedBy(-18)
                return BigNumber(0)
            },
            userTotalSharedDiamond() {
                let total;
                let userShare;
                if(this.$store.state.liquiditygenerator.totalFTMShares > 0)
                    total = BigNumber(this.$store.state.liquiditygenerator.totalFTMShares).shiftedBy(-18);
                else
                    return BigNumber(0);

                if(this.$store.state.liquiditygenerator.RecipientInfo != null)
                    userShare = BigNumber(this.$store.state.liquiditygenerator.RecipientInfo.shares).shiftedBy(-18);
                else
                    return BigNumber(0);

                var share = userShare * 100 / total;
                var balance = this.$store.state.liquiditygenerator.normalVestingDiamond * share / 100;

                return BigNumber(balance).shiftedBy(-18);
            },
            userSharedDiamond() {
                let currentTime = Date.now();
                let date = this.$store.state.liquiditygenerator.vestingBegin;

                if (currentTime < date)
                    return BigNumber(0);

                if(this.$store.state.liquiditygenerator.totalFTMShares < 0)
                    return BigNumber(0);

                if(this.$store.state.liquiditygenerator.RecipientInfo != null)
                    return BigNumber(this.$store.state.liquiditygenerator.ClaimableRewards).shiftedBy(-18);
                else
                    return BigNumber(0);
            },
            userClaimedDiamond() {
                if(this.$store.state.liquiditygenerator.RecipientInfo != null)
                    return BigNumber(this.$store.state.liquiditygenerator.RecipientInfo.credit).shiftedBy(-18);
                else
                    return BigNumber(0);
            },
        },
        mounted() {
    //        this.$store.commit('read_liquiditygenerator')
        },
        methods: {
            connectWallet() {                
                this.$store.dispatch('connect')              
            },
            getMaxFTM() {
                this.amountFTM = this.maxFTM
            },
            depositFTM() {
                if (!this.isMetaMaskConnected) {
                    this.$store.commit('show_warning','Please connect a wallet.')
                        return;
                }
                this.$store.dispatch('depositFTM',{
                    amount:this.amountFTM
                })
            },    
            detail() {
                window.open('https://docs.pumpkitten.com/fantoon/diamond-token-lge', '_blank')
            },   
            contract() {
                this.$store.dispatch('contractLink')
            },   
            claim() {
                this.$store.dispatch('claimDiamond')
            },
            getUnlockTime() {
                let endTime = this.$store.state.liquiditygenerator.periodEnd;
                let currentTime = Date.now();

                var difference = endTime - currentTime;
                this.countdown = difference;

                if (difference < 0)
                    return "0"; 

                var daysDifference = Math.floor(difference/1000/60/60/24);
                var dayString;
                if (daysDifference < 10)
                    dayString = "0" + daysDifference.toString();
                else
                    dayString = daysDifference.toString();

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
                    days:dayString,
                    hours: hourString,
                    minutes: minutesString,
                    seconds: secondString,
                };
            },
        }
    }
</script>

<style>
    .box-counter {
        background: #000303;
        margin-top: 40px !important;
        max-width: 380px;
        display: -webkit-box;
        display: -ms-flexbox;
        display: flex;
        -webkit-box-orient: vertical;
        -webkit-box-direction: normal;
        -ms-flex-direction: column;
        flex-direction: column;
        -webkit-box-align: center;
        -ms-flex-align: center;
        align-items: center;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        justify-content: center;
        margin: 0 auto;
        box-shadow: inset 0px 0px 4px 6px #202323;
        border-radius: 14px;
    }

    .lge {
        background-color:#eefdfe;
        background-size:cover;
        padding:20px 5px 50px 0;
        color:#000 !important;
    }

    .button {
        background-color:black;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 15px;
        padding: 10px 5px;
        border-radius: 5px;
        margin: 5px 5px;
        width: 160px;
        font-weight: bold;
        color: #fff;
        border: none;
        box-shadow: 1px 1px 2px .2px var(--q-color-secondary);
        cursor: pointer;
    }

    .button:hover {
        background-color: #524b48;
    }
    
    .avatar {
        width:30px;
        height:30px;
    }

    .avatar_sm {
        width:20px;
        height:20px;
    }

    .ftm .row {
        margin-right:0 !important;
        margin-left:0 !important;
    }

    .deposit {
        border-radius: 5px;
        padding:0px;
    }

    .label_left {
        float:left;
        text-align: left;
        margin-right: 120px;
    }

    .label_right {
        float:right;
        text-align: right;
    }
    
    .event-message {
        font-size: 18px;
        margin-top:20px;
        opacity: 0.7;
    }

    .event-message span{
        font-size: 18px;
    }

    .hilight {
        color:red !important;       
    }
    .blue_hilight {
        color: blue;       
    }

    .q-field__native {
        width:80% !important;
        min-width: 0;
        outline: 0 !important;
    }

    .q-field__control, .q-field__marginal {
        color: black;
        height: 45px !important;
    }

    .col {
        padding-right:0 !important;
        padding-left:0 !important;
    }

    .ftmInput {
    /*    border: 1px solid rgba(180, 180, 180, 0.3);*/
        border-radius: 5px;
    }

    .balance {
        margin-top:5px; 
        color:rgb(97, 93, 93); 
        font-size:12px
    }

    img.avatar {
        filter: drop-shadow(1px 2px 0px rgb(80, 80, 80) ) !important;
    }

    img.avatar_sm {
        filter: drop-shadow(1px 1px 0px rgb(80, 80, 80) ) !important;
    }
</style>
