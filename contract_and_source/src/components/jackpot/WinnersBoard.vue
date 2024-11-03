<template>
    <div class="jackpot">
        <q-banner dense inline-actions
                  class="text-white q-py-sm q-mt-md q-mx-lg text-h6 text-center text-uppercase flex"
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
        <div class="row q-py-lg q-px-lg">
            <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4 justify-center flex">
                <div class="text-center q-mb-sm text-bold text-h5">
            Game Stats
                </div>
                <div class="treasury__status">
                    <div class="row">
                        <div class="col-xs-2 q-my-lg text-center">
                            <img :src="require(`@/assets/user.png`)" style="width: 25px;height:25px"/>
                        </div>
                        <div class="col-xs-6 q-my-lg">
                            Total Players
                        </div>
                        <div class="col-xs-4 q-my-lg text-yellow">
                            {{getTotalPlayers}}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-2 q-mt-md q-mb-lg text-center">
                            <img :src="require(`@/assets/spin.png`)" style="width: 25px;height:25px"/>
                        </div>
                        <div class="col-xs-6 q-mt-md q-mb-lg">
                            <div>
                                Total Spins
                            </div>
                            <div class="q-my-sm text-green">
                                My Spins
                            </div>
                        </div>
                        <div class="col-xs-4 q-mt-md q-mb-lg text-yellow">
                            <div>
                                {{getTotalSpins}}
                            </div>
                            <div class="q-my-sm">
                                {{getMySpins}}
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-2 text-center">
                            <img :src="require(`@/assets/cup.png`)" style="width: 25px;height:25px"/>
                        </div>
                        <div class="col-xs-6">
                            <div>
                                Total Wins
                            </div>
                            <div class="q-my-sm text-green">
                                My Wins
                            </div>
                        </div>
                        <div class="col-xs-4 text-yellow">
                            <div>
                                {{getTotalWins}}
                            </div>
                            <div class="q-my-sm">
                                {{getMyWins}}
                            </div>
                        </div>
                    </div>
                </div>
                 <div class="text-center q-mb-sm text-bold text-h5">
            Claim 💎 Founders Rewards
        </div>
                <div class="claim__status">
                    
                    <div class="status">
                        
                        <div class="row">
                            
                            <div class="col-xs-2 q-mt-md q-mb-sm text-center">
                                <img :src="require(`@/assets/ftm.png`)" style="width: 25px;height:25px"/>
                            </div>
                            <div class="col-xs-6 q-mt-md q-mb-sm">
                                <div>
                                    Total FTM Claimed
                                </div>
                                <div class="q-my-sm text-green">
                                    Claimable FTM
                                </div>
                            </div>
                            <div class="col-xs-4 q-mt-md q-mb-sm text-yellow">
                                <div>
                                    <span v-if="getWithdrawnFTM.isGreaterThan(2000)">{{getWithdrawnFTM.shiftedBy(-3).toFormat(2)}}k</span>
                                    <span v-else>{{getWithdrawnFTM.toFormat(5)}}</span>
                                </div>
                                <div class="q-my-sm">
                                    <span v-if="getWithdrawableFTM.isGreaterThan(2000)">{{getWithdrawableFTM.shiftedBy(-3).toFormat(2)}}k</span>
                                    <span v-else>{{getWithdrawableFTM.toFormat(5)}}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="claim_btn">
                        <button @click="claimFTM" class="btn" 
                                :disabled="getWithdrawableFTM == 0">Claim FTM</button>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8 q-py-md" style="min-height:500px;">
                <q-table
                    title="Winners Board"
                    class="transparent custom-table"
                    :data="filteredFarm"
                    :columns="columns"
                    row-key="id"
                    :rows="rows"
                    table-class="my-custom"
                >
                </q-table>
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
                filter: 'all',
                columns: [
                    {
                        name: 'Owner',
                        field: 'owner',
                        label: 'Winner Address',
                        align: 'left',
                        sortable: true
                    },
                    {
                        name: 'Date',
                        field: 'date',
                        label: 'Date',
                        align: 'center',
                        sortable: true
                    },
                    {
                        name: 'NFT Address',
                        field: 'nft',
                        label: 'NFT Address',
                        align: 'center',
                        sortable: true
                    },
                    {
                        name: 'Token ID',
                        field: 'tokenId',
                        label: 'Token ID',
                        align: 'center',
                        sortable: true
                    },
                    {
                        name: 'Reward Token',
                        field: 'rewardToken',
                        label: 'Reward Token',
                        align: 'right',
                        sortable: true
                    },
                ],
                rows: [
                ]
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
            filteredFarm() {
                var rows = [];
                let length = this.$store.state.Jackpot.rewards.length;
                for (let i = 0; i < length; i++) {
                    rows[i] = {
                        id : i,
                        owner: this.showWallet(this.$store.state.Jackpot.rewards[i].buyer),
                        date: this.getDate(this.$store.state.Jackpot.rewards[i].purchasedTime),
                        nft: this.showWallet(this.$store.state.Jackpot.rewards[i].nftAddress),
                        tokenId: this.getTokenId(this.$store.state.Jackpot.rewards[i].tokenId),
                        rewardToken: this.getRewardToken(this.$store.state.Jackpot.rewards[i].rewardTokenAmount)
                    }
                }
                return rows
            },
            getTotalPlayers() {
                return this.$store.state.Jackpot.totalPlayers
            },
            getTotalSpins() {
                return this.$store.state.Jackpot.totalPlays
            },
            getMySpins() {
                return this.$store.state.Jackpot.mySpins
            },
            getTotalWins() {
                return this.$store.state.Jackpot.rewards.length
            },
            getMyWins() {
                return this.$store.state.Jackpot.myWins
            },
            getWithdrawableFTM() {
                if(this.$store.state.reward.withdrawableFTMfromJackpot > 0)
                    return BigNumber(this.$store.state.reward.withdrawableFTMfromJackpot).shiftedBy(-18)
                return BigNumber(0)
            },
            getWithdrawnFTM() {
                if(this.$store.state.reward.withdrawnFTMfromJackpot > 0)
                    return BigNumber(this.$store.state.reward.withdrawnFTMfromJackpot).shiftedBy(-18)
                return BigNumber(0)
            }
        },
        async mounted() {
            await this.$store.dispatch('getPurchedInfo')
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
            getDate(amount) {
                let date = amount * 1000
                const options = { year: 'numeric', month: 'numeric', day: 'numeric', hour: 'numeric', minute: 'numeric' }
                const dtf = new Intl.DateTimeFormat('en-US', options);
                return dtf.format(date)
            },
            getTokenId(amount) {
                if (amount == '0')
                    return '';
                else
                    return amount;
            },
            getRewardToken(amount) {
                if (amount == '0')
                    return '';
                else
                    return BigNumber(amount).shiftedBy(-18).toFormat(3);
            },
            claimFTM() {
                this.$store.dispatch('claimFTMfromJackpot')
            },
        }
    }
</script>

<style scoped>
    .treasury__status {
        width: 90%;
        height:260px;
        margin:20px 10px;
        border: 1px double transparent;
        border-radius: 10px;
        background-image: linear-gradient(224deg, var(--q-color-secondary), var(--q-color-dark)),
        linear-gradient(224deg, var(--q-color-info), var(--q-color-primary));
        color: #fff;
        background-origin: border-box;
        background-clip: padding-box, border-box;
        padding-top:10px;
        padding-left:40px;
        font-size: 14px;
    }

    .claim__status {
        width: 90%;
        height:150px;
        margin:20px 10px;
        border: 1px double transparent;
        border-radius: 10px;
        background-image: linear-gradient(224deg, var(--q-color-secondary), var(--q-color-dark)),
        linear-gradient(224deg, var(--q-color-info), var(--q-color-primary));
        color: #fff;
        background-origin: border-box;
        background-clip: padding-box, border-box;
        padding-top:10px;
        font-size: 14px;
    }

    .claim__status .status {
        padding-left:40px;
    }

    .claim__status .claim_btn {
        text-align: center;
    }

   .claim__status .btn {
      background: #f36128;
      width: 75%;
      border: none;
      border-radius: 10px;
      font-size: 1rem;
      font-weight:bold;
      color: #fff;
      cursor: pointer;
    }

    .claim__status .btn:hover {
        background-color: #faa786;
    }

    .custom-table {
        padding: 20px 10px;
        width:100%;
        margin:auto;
        margin-top:10px;
        margin-bottom:50px !important;
        border: 1px double transparent;
        border-radius: 10px;
        box-shadow: 3px 3px 3px 3px rgb(0 0 0 / 20%), 0 2px 2px rgb(0 0 0 / 14%), 0 3px 1px -2px rgb(0 0 0 / 12%);
    }

    .custom-table >>> tbody {
        padding: 20px 10px;
    }

    .custom-table >>> .q-table__title {
        font-size: 26px !important;
        font-weight: bold !important;
    }

    .custom-table >>> .q-table__top {
        color:red;
        margin:auto;
        justify-content: center;
        text-shadow: 1px 1px 1px white; 
    }
    .custom-table >>> thead tr:first-child th {
        color: rgb(1, 107, 1);
        opacity: 0.8;
        font-size: 16px;
        font-weight: bold;
        text-shadow: 1px 0px 1px #fff; 
    }
    /*
    .custom-table >>> .q-table__bottom {
        width:100%;
        margin:auto;
        justify-content: center;
    }*/
    .custom-table >>> .q-table__control span {
        padding-right:20px;
    }

    .custom-table >>> .q-select {
        margin-left: 1rem !important;
        width:20px;
    }

    .custom-table >>> .q-field__native span {
        font-size: 12px;
    }

    .custom-table >>> .q-btn .q-icon {
        padding-left: 15px !important;
    }

    .jackpot > .q-banner .row {
        display: flex;
        flex-wrap: wrap;
        margin-right: -12px;
    }
</style>
