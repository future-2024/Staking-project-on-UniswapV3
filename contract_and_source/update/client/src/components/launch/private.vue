<template>
    <div class="dx">
       <br /><br /><br />
        <h4 class="text-center q-mb-sm text-bold text-h5">Diamond Token Private Early Access</h4>
        <p v-if="!isMetaMaskConnected" class="text-center q-mt-sm event-message">
            Please connect wallet to check the status.
        </p>
        <div class="text-center flex justify-center">
            <p style="max-width: 550px">This event is completed successfully!.
            </p>
            
        </div>
       
        <div class="justify-center flex items-center text-bold">
           
            <div class="q-pa-lg q-mr-lg">
                <div class="flex items-center q-my-md">
                    <div>
                        <img :src="require(`@/assets/diamond.png`)" class="avatar" />
                    </div>
                    <div class="flex items-baseline q-pl-sm">
                        <h4 class="q-my-none">
                            <div v-if="userClaimedDiamond.isGreaterThan(2000)">{{userClaimedDiamond.shiftedBy(-3).toFormat(2)}}k</div>
                            <div v-else>{{userClaimedDiamond.toFormat(2)}}</div>
                        </h4>
                        
                    </div>
                </div>
                <p class="text-center">Diamonds Claimed</p>
            </div>
            <div class="q-pa-lg q-ml-lg">
                <div class="flex items-center q-my-md">
                    <div class="flex items-baseline">
                        <h4 class="q-my-none">
                            <div v-if="userFTM.isGreaterThan(2000)">{{userFTM.shiftedBy(-3).toFormat(2)}}k FTM</div>
                    <div v-else>{{userFTM.toFormat(2)}}</div>
                        </h4>
                        
                    </div>
                    <div class="q-pl-sm">
                        <img :src="require(`@/assets/ftm.png`)" class="avatar" />
                    </div>
                </div>
                <p class="text-center">FTM Spent</p>
            </div>
        </div>
        <div class="justify-center flex" style="font-size:12px;">
            <div class="label_left_sm text-bold">
                
            </div>
            <div class="label_right text-bold">
                
            </div>
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
                amountFTM: null
            }
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
            errorMessage() {
                if (this.amountFTM == null || this.amountFTM == "")
                    return;
                    
                let max = this.$store.state.diamondExchanger.maxFTM;
                let min = this.$store.state.diamondExchanger.minFTM;

                if(BigNumber(this.amountFTM).isGreaterThan(this.maxFTM)) {
                    return "INSUFFICIENT ACCOUNT BALANCE"
                }
                else if (BigNumber(min).shiftedBy(-18).isGreaterThan(BigNumber(this.amountFTM))) {
                    return "A MINIMUM OF " +  BigNumber(min).shiftedBy(-18) + "FTM IS REQUIRED"
                }
                else if (BigNumber(this.amountFTM).isGreaterThan(BigNumber(max).shiftedBy(-18))) {
                    return "MAXIMUM 3000 FTM PER KITTEN"
                }
                return null
            },
            remainingDiamond() {
                if(this.$store.state.diamondExchanger.remainingDiamond > 0)
                    return BigNumber(this.$store.state.diamondExchanger.remainingDiamond).shiftedBy(-18)
                return BigNumber(0)
            },
            diamondPrice() {
                if(this.$store.state.diamondExchanger.diamondPrice > 0)
                    return BigNumber(this.$store.state.diamondExchanger.diamondPrice).shiftedBy(-18)
                return BigNumber(0)
            },
            userFTM() {
                if (this.$store.state.account != null)
                    return BigNumber(this.$store.state.diamondExchanger.userFTM).shiftedBy(-18)
                else
                    return BigNumber(0)
            },
            userClaimedDiamond() {
                if (this.$store.state.account != null)
                    return BigNumber(this.$store.state.diamondExchanger.userDiamond).shiftedBy(-18);
                else
                    return BigNumber(0)
            },
        },
        mounted() {
//          this.$store.commit('read_liquiditygenerator')
        },
        methods: {
            connectWallet() {                
                this.$store.dispatch('connect')              
            },
            getMaxFTM() {
                this.amountFTM = this.maxFTM
            },
            depositFTM() {
                this.$store.dispatch('depositFTMinDiamondExchanger',{
                    amount:this.amountFTM
                })
            }
        }
    }
</script>

<style>
    .dx {
        background-color:#eefdfe;
        background-size:cover;
        padding:20px 5px;
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
        margin: 0 5px;
        width: 160px;
        height:44px;
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

    .label_left_sm {
        float:left;
        text-align: left;
        margin-right: 230px;
    }

    .ftm .row {
        margin-right:0 !important;
        margin-left:0 !important;
    }

    .deposit {
        border-radius: 5px;
        padding:0px;
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
