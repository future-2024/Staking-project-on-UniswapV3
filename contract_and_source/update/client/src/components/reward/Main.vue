<template>
    <div class="reward">
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
        <div class="text-center q-mb-sm text-bold text-h5">
            Claim Rewards
        </div>
        <div class="status">
            <div class="row q-py-sm q-px-lg">
                <div class="col-xs-12 col-sm-12 col-md-5 col-lg-4" 
                    style="margin-inline: auto;">
                    <div class="reward__status" >
                        <div class="row q-pl-lg text-bold">
                            <div class="col-xs-2 q-my-md text-center">
                                <img :src="require(`@/assets/ftm.png`)" class="avatar_sm"/>
                            </div>
                            <div class="col-xs-6 q-my-md">
                                <div class="q-pb-md">
                                    Total Claimed
                                </div>
                                <div class="q-my-lg text-green">
                                    Claimable
                                </div>
                            </div>
                            <div class="col-xs-4 q-my-md text-yellow">
                                <div class="q-pb-md">
                                    <span v-if="getClaimedJackpotReward.isGreaterThan(2000)">$ {{getClaimedJackpotReward.shiftedBy(-3).toFormat(2)}}k</span>
                                    <span v-else>{{getClaimedJackpotReward.toFormat(5)}} FTM</span>
                                </div>
                                <div class="q-my-lg">
                                    <span v-if="getClaimableJackpotReward.isGreaterThan(2000)">$ {{getClaimableJackpotReward.shiftedBy(-3).toFormat(2)}}k</span>
                                    <span v-else>{{getClaimableJackpotReward.toFormat(5)}} FTM</span>
                                </div>
                            </div>
                        </div>
                        <div class="claim_btn">
                            <button @click="claimFTMfromJackpot" class="btn" 
                                    :disabled="!isMetaMaskConnected || getClaimableJackpotReward == 0">Claim Jackpot Reward</button>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-5 col-lg-4" 
                        style="margin-inline: auto;">
                    <div class="reward__status">
                        <div class="row q-pl-lg text-bold">
                            <div class="col-xs-2 q-my-md text-center">
                                <img :src="require(`@/assets/ftm.png`)" class="avatar_sm"/>
                            </div>
                            <div class="col-xs-6 q-my-md">
                                <div class="q-pb-md">
                                    Total Claimed
                                </div>
                                <div class="q-my-lg text-green">
                                    Claimable
                                </div>
                            </div>
                            <div class="col-xs-4 q-my-md q-mb-sm text-yellow">
                                <div class="q-pb-md">
                                    <span v-if="getClaimedNftReward.isGreaterThan(2000)">$ {{getClaimedNftReward.shiftedBy(-3).toFormat(2)}}k</span>
                                    <span v-else>{{getClaimedNftReward.toFormat(5)}} FTM</span>
                                </div>
                                <div class="q-my-lg">
                                    <span v-if="getClaimableNftReward.isGreaterThan(2000)">$ {{getClaimableNftReward.shiftedBy(-3).toFormat(2)}}k</span>
                                    <span v-else>{{getClaimableNftReward.toFormat(5)}} FTM</span>
                                </div>
                            </div>
                        </div>
                        <div class="claim_btn">
                            <button @click="claimNFTReward" class="btn" 
                                    :disabled="!isMetaMaskConnected || getClaimableNftReward == 0">Claim NFT Reward</button>
                        </div>
                    </div>
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
            }
        },
        computed: {
            isMetaMaskInstalled() {
                const {ethereum} = window;
                return Boolean(ethereum && ethereum.isMetaMask)
            },
            isMetaMaskConnected() {
                return this.$store.state.account != null;
            },
            getClaimableJackpotReward() {
                if(this.$store.state.reward.withdrawableFTMfromJackpot > 0)
                    return BigNumber(this.$store.state.reward.withdrawableFTMfromJackpot).shiftedBy(-18)
                return BigNumber(0)
            },
            getClaimedJackpotReward() {
                if(this.$store.state.reward.withdrawnFTMfromJackpot > 0)
                    return BigNumber(this.$store.state.reward.withdrawnFTMfromJackpot).shiftedBy(-18)
                return BigNumber(0)
            },
            getClaimableNftReward() {
                if(this.$store.state.reward.withdrawableFTMfromNFT > 0)
                    return BigNumber(this.$store.state.reward.withdrawableFTMfromNFT).shiftedBy(-18)
                return BigNumber(0)
            },
            getClaimedNftReward() {
                if(this.$store.state.reward.withdrawnFTMfromNFT > 0)
                    return BigNumber(this.$store.state.reward.withdrawnFTMfromNFT).shiftedBy(-18)
                return BigNumber(0)
            },
        },
        async mounted() {
        },
        methods: {
            showWallet(wallet) {
                if (wallet == '0x0000000000000000000000000000000000000000')
                    return '';
                else
                    return (
                        wallet.substring(0, 12) +
                        "..." +
                        wallet.substring(wallet.length - 6, wallet.length)
                    );
            },
            claimFTMfromJackpot() {
                this.$store.dispatch('claimFTMfromJackpot')
            },
            claimNFTReward() {
                this.$store.dispatch('claimFTMfromNFT')
            },
        }
    }
</script>

<style scoped>
    .reward {
        background-color:#eefdfe;
        background-size:cover;
        padding:20px 5px;
        color:#000 !important;
    }

    .status .row {
        margin-right:0 !important
    }
    .reward__status {
        width: 100%;
        height:210px;
        margin:20px 10px;
        border: 1px double transparent;
        border-radius: 10px;
        background: rgba(7, 38, 51, 1);
        color: #fff;
        background-origin: border-box;
        background-clip: padding-box, border-box;
        padding:10px 0;
        font-size: 14px;
        box-shadow: 0px 0px 1px 1px #202323;
    }

    .reward__status .claim_btn {
        text-align: center;
    }

   .reward__status .btn {
      background: #f36128;
      width: 75%;
      border: none;
      border-radius: 10px;
      font-size: 1rem;
      font-weight:bold;
      color: #fff;
      cursor: pointer;
      text-shadow: 0px 1px 1px rgb(0, 0, 0); 
    }

    .reward__status .btn:hover {
        background-color: #fc9870;
    }

    .avatar_sm {
        width:25px;
        height:25px;
    }
</style>