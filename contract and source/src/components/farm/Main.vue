<template>
    <div class="farm">
        <section id="workingArea">
            <div class="p-lg-1">
                <div v-if="welcome" class="row welcome">
                    <div class="col-11">
                        <h3>Welcome to Diamond Farms!</h3>
                    </div>
                    <div class="col-1 justify-end q-mb-sm text-right">
                        <q-icon name="close" class="cursor-pointer" @click="welcome=false"></q-icon>
                    </div>
                    <p>To farm the precious Diamond coin you no longer have to visit multiple platforms. 
                        We've integrated all the available farming pools in different platforms in this one place. 
                        You're still interacting with respective platforms' contracts, but in an easier UI, to have access to everything in just one place! Still in Beta!
                    </p>
                </div>
                <div class="growth">
                    <div class="row justify-content-between">
                        <div class="col-md-12 col-lg-6 q-mt-md">
                            <div class="tabBg">
                                <h2>$ {{totalUserStakedInDollar()}}<br> <small>Total Staked</small></h2>
                            </div>
                        </div>
                        <div class="col-md-12 col-lg-6 q-mt-md">
                            <div class="tabBg">
                                <h2>$ {{totalUserEarnedInDollar()}}<br> <small>Total Earnings</small></h2>
                            </div>
                        </div>
                    </div>
                    <p>
                        <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 14 14">
                            <path d="M7,13 C3.6862915,13 1,10.3137085 1,7 C1,3.6862915 3.6862915,1 7,1 C10.3137085,1 13,3.6862915 13,7 C13,10.3137085 10.3137085,13 7,13 Z M7,3 C6.44771525,3 6,3.44771525 6,4 L6,7 C6,7.55228475 6.44771525,8 7,8 C7.55228475,8 8,7.55228475 8,7 L8,4 C8,3.44771525 7.55228475,3 7,3 Z M7,9 C6.44771525,9 6,9.44771525 6,10 C6,10.5522847 6.44771525,11 7,11 C7.55228475,11 8,10.5522847 8,10 C8,9.44771525 7.55228475,9 7,9 Z" transform="rotate(180 7 7)"/>
                        </svg>
                        Total earnings is the sum of the rewards you've got from all the active farming pools.
                    </p>
                </div><!--
                <div class="searchBar p-4">
                    <div class="row align-items-center">
                        <div class="col-6">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="gridCheck">
                                <label class="form-check-label" for="gridCheck">
                                    Hide zero balances
                                </label>
                            </div>
                        </div>
                        <div class="col-6">
                            <input type="search" class="form-control" placeholder="DIAMOND, FTM, ..." />
                        </div>
                    </div>
                </div>-->
                <div class="vaults">
                    <div class="overview">
                        <q-table
                                title="Available Farming Pools"
                                class="custom-table table"
                                :data="filteredFarm"
                                :columns="columns"
                                row-key="id"
                        >
                            <template v-slot:body="props">
                                <q-tr :props="props" 
                                    @click.native="props.row.id == 0 ? props.expand = !props.expand : null"  
                                    class="brdBtm" id="fstBtn">
                                    <q-td style="width:100px">
                                        <q-img :src="props.row.fromImage"
                                               class="rounded-borders q-mr-sm farm_avatar"></q-img>
                                        <q-img :src="props.row.toImage"
                                               class="rounded-borders q-mr-sm farm_avatar" ></q-img>
                                    </q-td>
                                    <q-td style="width:350px">
                                        <div class="label">{{props.row.pair}}</div>
                                        {{props.row.farm}}
                                    </q-td>
                                    <q-td class="text-right">
                                        <div class="label_sm">APR:</div>
                                        <span class="text-bold">{{props.row.apr}} %</span>
                                    </q-td>
                                    <q-td class="text-right">
                                        <div class="label_sm">Total Earnings</div>
                                        <span class="text-bold">{{props.row.earnings}} Diamond</span><br>
                                        <span class="text-bold">( ${{props.row.earningsInDollar}} )</span>
                                    </q-td>
                                    <q-td class="plus">
                                        +
                                    </q-td>
                                </q-tr>
                                <q-tr v-show="props.expand" :props="props" class="fstCollab" style="border: none">
                                    <q-td style="border: none"></q-td>
                                    <q-td style="border: none">
                                        <div class="label_sm" v-if="props.row.id == 0">
                                            Farm with LP Tokens. from SpiritSwap.
                                            <a href="https://swap.spiritswap.finance/#/add/FTM/0xDDa0F0E1081b8d64aB1D64621eb2679F93086705" 
                                                target="blank" class="text-bold">
                                            Add LP HERE</a>.
                                            <br>Harvesting has
                                            <a href="https://discord.gg/Gj7JqN2mXZ" target="blank">tax period</a>.
                                        </div>
                                        <div class="label_sm" v-if="props.row.id == 1">
                                            Farming on Solidex with LP tokens from Solidly.
                                        </div>
                                        <div class="label_sm" v-if="props.row.id == 2">
                                            Farming on OXDao with LP tokens from Solidly.
                                        </div>
                                    </q-td>
                                    <q-td class="text-right" style="border: none">
                                        Total Staked:<br>
                                        <div class="label_sm">
                                            <span class="text-bold">{{poolStaked(props.row.id)}}</span> LP Tokens<br>
                                            <span class="text-bold">( ${{poolStakedInDollar(props.row.id)}} )</span>
                                        </div>
                                    </q-td>
                                    <q-td class="text-right" style="border: none">
                                        TVL:<br>
                                        <div class="label_sm">
                                            <span class="text-bold">${{getTVL(props.row.id)}}</span></div>
                                    </q-td>
                                </q-tr>
                                <q-tr class="fstCollab" v-show="props.expand" :props="props">
                                    <q-td style="border: none"></q-td>
                                    <q-td style="border: none">
                                        <div class="label_sm">This pool is earning:</div>
                                        <div class="label value">
                                            <span class="text-bold">{{getAPR(props.row.id)}}%</span>
                                        </div>
                                    </q-td>
                                    <q-td class="text-right" style="border: none">
                                        <div class="label_sm">Available to harvest:</div>
                                        <div class="label value">{{claimableDiamond(props.row.id)}}<br>Diamond</div>
                                    </q-td>
                                    <q-td colspan="2" style="border: none">
                                        <div class="btn q-mt-lg" 
                                            @click="selection(props.row.id)">Harvest</div>
                                    </q-td>
                                </q-tr>
                                <q-tr class="fstCollab" v-show="props.expand" :props="props">
                                    <q-td style="border: none"></q-td>
                                    <q-td colspan="2" style="border: none">
                                        <div class="label_sm">
                                            Your wallet: {{balance(props.row.id)}} LP Tokens
                                            (${{balanceInDollar(props.row.id)}})</div>
                                        <q-input 
                                            type="number" class="farm_input"
                                            :key="'input'+rerender"
                                            standout="bg-red" placeholder="0.0" 
                                            v-model="amountStake[props.row.id]" min="0"
                                            :bottom-slots="false" :hide-bottom-space="true">
                                            <template v-slot:append>
                                                <div>
                                                    <q-btn rounded outline color="blue" size="sm" 
                                                        @click="getMaxStake(props.row.id)">
                                                        MAX
                                                    </q-btn>
                                                </div>
                                            </template>
                                        </q-input>
                                    </q-td>
                                    <q-td colspan="2" style="border: none">
                                        <div class="label_sm">
                                            Staked: {{maxUnstake(props.row.id).toFormat(5)}} LP Tokens 
                                            ( ${{maxUnstakeInDollar(props.row.id).toFormat(5)}})
                                        </div>
                                        <q-input 
                                            type="number" class="farm_input"
                                            standout="bg-red text-black" placeholder="0.0" 
                                            v-model="amountUnstake[props.row.id]" 
                                            value="" min="0">
                                            <template v-slot:append>
                                                <div>
                                                    <q-btn rounded outline color="blue" size="sm" 
                                                        @click="getMaxUnstake(props.row.id)">
                                                        MAX
                                                    </q-btn>
                                                </div>
                                            </template>
                                        </q-input>
                                    </q-td>
                                </q-tr>
                                <q-tr class="brdBtm fstCollab" v-show="props.expand" :props="props">
                                    <q-td></q-td>
                                    <q-td colspan="2">
                                        <div v-if="!isApproved(props.row.id)" class="btn" @click="approve(props.row.id)">Approve</div>
                                        <div v-if="isApproved(props.row.id)" class="btn" @click="stake(props.row.id)">Stake</div>
                                    </q-td>
                                    <q-td colspan="2">
                                        <div v-if="!isApproved(props.row.id)" class="btn" @click="approve(props.row.id)">Approve</div>
                                        <div v-if="isApproved(props.row.id)" class="btn" @click="unstake(props.row.id)">Unstake</div>
                                    </q-td>
                                </q-tr>
                            </template>
                        </q-table>
                    </div>
                </div>
            </div>
            <div v-if="showModal" class="modal">
                <div class="modal__content q-mx-sm">
                    <div class="model__content__item text-h5">
                        <div class="q-px-lg">Diamond - FTM Farming Information</div>
                        <q-btn icon="close" round flat dense @click="showModal = !showModal"/>
                    </div>
                    <div class="">
                        <div class="row lists">
                            <q-table
                                id="farming"
                                title=""
                                class="transparent custom-table1"
                                :data="filteredDeposite"
                                :columns="columns1"
                                row-key="id"
                                :rows="rows1"
                                table-class="my-custom"
                            >
                                <template v-slot:body-cell-action="props">
                                    <q-td :props="props">
                                        <q-btn
                                            class="q-mt-sm, q-mx-sm, q-my-sm q-px-sm harvest"
                                            color="white"
                                            no-caps
                                            label="Harvest"
                                            flat
                                            dense
                                            :disabled="!isClaimable(props.row.id)" 
                                            @click="harvest(indexPool, props.row.id)"
                                        />
                                    </q-td>
                                </template>
                            </q-table>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>
<script>
import BigNumber from 'bignumber.js'
    export default {
        data() {
            return {
                rerender: 0,
                welcome: true,
                filter: 'all',
                showModal: false,
                indexPool: 0,
                columns: [
                    {
                        name: 'pool',
                        field: 'pool',
                        label: 'Pool',
                        align: 'left',
                        sortable: true
                    },
                    {
                        name: 'apr',
                        field: 'apr',
                        label: 'APR',
                        align: 'right',
                        sortable: true
                    },
                    {
                        name: 'earnings',
                        field: 'earnings',
                        label: 'Earnings',
                        align: 'right',
                        sortable: true
                    },
                ],
                amountStake: [],
                amountUnstake: [],
                columns1: [
                    {
                        name: 'Date',
                        field: 'date',
                        label: 'LOCKED DATE',
                        align: 'center',
                        sortable: true
                    },
                    {
                        name: 'staked token',
                        field: 'stakedToken',
                        label: 'STAKED LP',
                        align: 'right',
                        sortable: true
                    },
                    {
                        name: 'total earned',
                        field: 'totalEarned',
                        label: 'EARNED Diamond',
                        align: 'right',
                        sortable: true
                    },
                    {
                        name: 'tax',
                        field: 'tax',
                        label: 'TAX ( % )',
                        align: 'center',
                        sortable: true
                    },
                    {
                        name: 'action',
                        field: 'action',
                        label: '',
                        align: 'left',
                    },
                ],
                rows1: [
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
                if (this.filter === 'all') {
                    rows = this.rows;
                } else {
                    rows = this.rows.filter(item => item.farm_type === this.filter);
                }
                return rows;
            },
            filteredDeposite() {
                var rows = [];

                let length = this.$store.state.farming.depositInfo.length;
                for (let i = 0; i < length; i++) {
                    rows[i] = {
                        id : i,
                        date: this.getDate(this.$store.state.farming.depositInfo[i][3]),
                        stakedToken: this.getAmount(this.$store.state.farming.depositInfo[i][1]),
                        totalEarned: this.getAmount(this.$store.state.farming.earnedTokenInfo[i]),
                        tax: this.$store.state.farming.taxInfo[i] / 100,
                    }
                }

                return rows
            },
            rows() {
                return [
                    {
                        id: 0,
                        farm: "Diamond reserve's own farming pool.",
                        pair: 'DIAMOND-FTM',
                        fromImage: require('@/assets/icons/diamond.png'),
                        toImage: require('@/assets/icons/ftm.png'),
                        apr: this.getAPR(0),
                        earnings: this.getAmount(this.userEarned(0)),
                        earningsInDollar: this.userEarnedInDollar(0).toFormat(5),
                        farm_type: 'farm0'
                    },/*
                    {
                        id: 1,
                        farm: 'Solidex farming pool with Solidly LP tokens.',
                        pair: 'fBOMB-DIAMOND',
                        fromImage: require('@/assets/icons/fbomb.png'),
                        toImage: require('@/assets/icons/diamond.png'),
                        apr: '124.23',
                        earnings: 0,
                        earningsInDollar:0,
                        farm_type: 'farm1'

                    },
                    {
                        id: 2,
                        farm: 'OXDao farming pool with Solidly LP tokens.',
                        pair: 'fBOMB-DIAMOND',
                        fromImage: require('@/assets/icons/fbomb.png'),
                        toImage: require('@/assets/icons/diamond.png'),
                        apr: '235.13',
                        earnings: 0,
                        earningsInDollar: 0,
                        farm_type: 'farm2'
                    },
                    {
                        id: 3,
                        farm: 'SpiritSwap farming pool with Spirit LP Tokens.',
                        pair: 'DIAMOND-FTM',
                        fromImage: require('@/assets/icons/diamond.png'),
                        toImage: require('@/assets/icons/ftm.png'),
                        apr: '4356.13',
                        earmings: '$219.99',
                        farm_type: 'farm3'
                    },*/
                ]
            },
        },
        async mounted() {
        },
        methods: {
            forceUpdate() {
                this.rerender++;
            },
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
            isApproved(index) {
                if (index == 0) {
                    return this.$store.state.approvedDiamondPairMaster;
                }
            },
            approve(index) {
                if (index == 0) {
                    this.$store.dispatch('approvePairMaster');
                }
            },
            selection(index) {
                this.$store.dispatch('getDepositExtraInfo', index).then(()=>{
                    this.showModal = !this.showModal;
                    this.indexPool = index;
                });
            },
            isClaimable(index) {
                return (BigNumber(this.$store.state.farming.claimableTokenInfo[index])
                    .isGreaterThan(BigNumber(0)))
            },
            stake(index) {
                if (index == 0)
                    this.$store.dispatch('deposit',{
                        index:0,
                        amount:this.amountStake[index]
                    });
                else if (index == 1)
                    this.$store.dispatch('deposit',{
                        index:2,
                        amount:this.amountStake[index]
                    });

                this.forceUpdate();
//              this.amountStake[index] = 0;
            },
            unstake(index) {
                if (index == 0)
                    this.$store.dispatch('withdrawLPs',{
                        index:0,
                        amount:this.amountUnstake[index]
                    });
                else if (index == 1)
                    this.$store.dispatch('withdrawLPs',{
                        index:2,
                        amount:this.amountUnstake[index]
                    });

                this.forceUpdate();
 //             this.amountUnstake[index] = 0;
            },
            harvest(pid, index) {
                this.$store.dispatch('harvest', {
                    pid: pid,
                    depositIndex: index
                }).then((ret)=>{
                    if (ret.blockHash != null) {
                        var myTable = document.getElementById('farming').getElementsByClassName('q-table')[0];
                        myTable.rows[index+1].cells[2].innerHTML = '0.00';
                        myTable.rows[index+1].cells[4].getElementsByClassName('q-btn')[0].disabled = true;
                    }
                });
            },
            getTVL(index) {
                if (index == 0) {       // TVL of DIAMOND/FTM
                    let tvl = BigNumber(this.$store.state.liquidity.amountFTM).shiftedBy(-18)
                        .times(this.$store.state.price.FTM)
                        .plus(
                            BigNumber(this.$store.state.liquidity.amountDiamond).shiftedBy(-18)
                                .times(this.$store.state.price.Diamond));

                    if (BigNumber(tvl).isGreaterThan(0))
                        return BigNumber(tvl).toFormat(5);
                    else
                        return '0.00';
                }
                else if (index == 1) {  // TVL of Diamond/FTM
                /*
                    let tvl = BigNumber(this.$store.state.liquidity.amountFTMInSpirit).shiftedBy(-18)
                        .times(this.$store.state.price.FTM)
                        .plus(
                            BigNumber(this.$store.state.liquidity.amountDiamondInSpirit).shiftedBy(-18)
                                .times(this.$store.state.price.Diamond));

                    if (BigNumber(tvl).isGreaterThan(0))
                        return BigNumber(tvl).toFormat(6);
                    else
                    */
                        return '0.00';
                }
            },
            getAPR(index) {
                if (index == 0) {
                    let apr = BigNumber(this.$store.state.farming.dailyReward).shiftedBy(-18)
                        .times(365).times(this.$store.state.price.Diamond)
                        .div(
                            BigNumber(this.$store.state.farming.totalSupply[index]).shiftedBy(-18)
                                .times(this.$store.state.price.LP_FTM_Diamond)
                        )
                        .times(100);

                    if (BigNumber(apr).isGreaterThan(0))
                        return BigNumber(apr).toFormat(2);
                    else
                        return '0.00';
                }
                else if (index >= 1) {
                    return '0.00';
                }
            },
            poolStaked(index) {
                if(BigNumber(this.$store.state.farming.totalSupply[index]).isNaN())
                    return 0;

                if(this.$store.state.farming.totalSupply[index] != null)
                    return BigNumber(this.$store.state.farming.totalSupply[index])
                    .shiftedBy(-18)
                    .toFormat(5);
                else
                    return 0;
            },
            poolStakedInDollar(index) {
                if(BigNumber(this.$store.state.farming.totalSupply[index]).isNaN())
                    return 0;

                if(this.$store.state.farming.totalSupply[index] != null)
                    return BigNumber(this.$store.state.farming.totalSupply[index])
                    .times(this.$store.state.price.LP_FTM_Diamond)
                    .shiftedBy(-18)
                    .toFormat(5);
                else
                    return 0;
            },
            pendingDiamond(index) {
                if(BigNumber(this.$store.state.farming.pendingDiamond[index]).isNaN())
                    return 0;
                return BigNumber(this.$store.state.farming.pendingDiamond[index])
                    .shiftedBy(-18)
                    .toFormat(5);
            },
            claimableDiamond(index) {
                if(BigNumber(this.$store.state.farming.claimableDiamond[index]).isNaN())
                    return 0;
                return BigNumber(this.$store.state.farming.claimableDiamond[index])
                    .shiftedBy(-18)
                    .toFormat(5);
            },
            balance(index) {
                if (index == 0) {
                     if(this.$store.state.account && this.$store.state.liquidity.balance) {
                        return BigNumber(this.$store.state.liquidity.balance)
                            .shiftedBy(-18).toFormat(5);
                    }                   
                }
                else if (index == 1) {
                    /*
                    if(this.$store.state.account && this.$store.state.liquidity.balanceOfDiamondPair) {
                        return BigNumber(this.$store.state.liquidity.balanceOfDiamondPair)
                            .shiftedBy(-18).toFormat(5);
                    }
                    */
                }
                return 0
            },
            balanceInDollar(index) {
                if (index == 0) {
                     if(this.$store.state.account && this.$store.state.liquidity.balance) {
                        return BigNumber(this.$store.state.liquidity.balance)
                            .times(this.$store.state.price.LP_FTM_Diamond)
                            .shiftedBy(-18).toFormat(5);
                    }                   
                }
                else if (index == 1) {
                    /*
                    if(this.$store.state.account && this.$store.state.liquidity.balanceOfDiamondPair) {
                        return BigNumber(this.$store.state.liquidity.balanceOfDiamondPair)
                            .shiftedBy(-18).toFormat(5);
                    }
                    */
                }
                return 0
            },
            maxUnstake(index) {
                let balance;
                balance = this.$store.state.farming.balance[index];

                if(!balance)
                    return BigNumber(0);

                return BigNumber(balance).shiftedBy(-18);
            },
            maxUnstakeInDollar(index) {
                return this.maxUnstake(index)
                        .times(this.$store.state.price.LP_FTM_Diamond)
            },
            totalUserStakedInDollar() {
                let value = this.maxUnstakeInDollar(0);
                // value += this.maxUnstakeInDollar(1);
                // value += this.maxUnstakeInDollar(2);

                return value.toFormat(5);
            },
            userEarned(index) {
                return BigNumber(this.$store.state.farming.earnedToken[index])
                        .plus(BigNumber(this.$store.state.farming.pendingDiamond[index])); 
            },
            userEarnedInDollar(index) {
                return this.userEarned(index)
                        .times(this.$store.state.price.Diamond)
                        .shiftedBy(-18);
            },
            totalUserEarnedInDollar() {
                let value = this.userEarnedInDollar(0);
                // value += this.maxUnstakeInDollar(1);
                // value += this.maxUnstakeInDollar(2);

                return value.toFormat(5);
            },
            getMaxStake(index) {
                if (index == 0)
                    this.amountStake[index] = BigNumber(this.$store.state.liquidity.balance)
                    .shiftedBy(-18);
                    /*
                else if (index == 1) 
                    this.amountStake[index] = BigNumber(this.$store.state.liquidity.balanceOfDiamondPair)
                    .shiftedBy(-18);*/
                this.forceUpdate();
            },
            getMaxUnstake(index) {
                if (index == 0)
                    this.amountUnstake[index] = BigNumber(this.$store.state.farming.balance[index])
                        .shiftedBy(-18);
                this.forceUpdate();
            },
            getAmount(amount) {
                let value = BigNumber(amount).shiftedBy(-18);
                if (value.isGreaterThan(2000)) {
                    return value.shiftedBy(-3).toFormat(5) + "K";
                }
                else {
                    return value.toFormat(5);
                }
            },
            getDate(amount) {
                let date = amount * 1000;
                const options = { year: 'numeric', month: 'numeric', day: 'numeric', hour: 'numeric', minute: 'numeric' }
                const dtf = new Intl.DateTimeFormat('en-US', options);
                return dtf.format(date);
            }
        }
    }
</script>
<style scoped>
    .farm {
        background-color:#eefdfe;
        background-size:cover;
        padding:20px 30px;
        color:#000 !important;
    }

    .custom-table >>> .q-table__bottom {
        display: none !important;
    }

    .custom-table >>> thead {
        display: none !important;
    }

    .vaults >>> .q-table__card {
        color: #191919;
        background-color: #fff;
        border:1px solid #fff !important;
        box-shadow: none;
    }

    .farm_avatar {
        width: 40px;
        height: 40px;
    }
    .label {
        color:#F93800;
        font-weight:500;
        font-size: 18px !important;
    }

    .label_sm {
        color:#F93800;
        font-weight:500;
        font-size: 14px !important;
    }

    .value {
        margin-top:5px;
        font-weight: bold !important;
    }

    .custom-table >>> .plus {
        font-size:22px;
        color:#F93800;
        font-weight:500;
        vertical-align: middle;
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
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .modal__content {
        width: 800px;
        padding: 10px 20px;
        border: 1px double transparent;
        border-radius: 5px;
        background-image: linear-gradient(224deg, var(--q-color-secondary), var(--q-color-dark)),
        linear-gradient(224deg, var(--q-color-info), var(--q-color-primary));
        color: #fff;
        background-origin: border-box;
        background-clip: padding-box, border-box;
    }
    .model__content__item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin: 20px 0;
    }

    .model__content__item >>> div.row {
        margin:0 !important;
    }

    .custom-table1 {
        width:100%;
        margin:auto;
        color:white;
        padding: 0 20px;
        border:none !important;
    }

    .custom-table1 >>> div.row {
        margin:0 !important;
    }

    .custom-table1 >>> div.col {
        margin:0 !important;
    }

    .custom-table1 >>> thead tr:first-child th {
        color: rgb(255, 255, 0);
        font-size: 12px;
        font-weight: 500;
    }

    .custom-table1 >>> .q-field__control .col {
        padding:0 !important;
    }

    .custom-table1 >>> .q-field__control span {
        color:#fff !important;
    }

    .custom-table1 >>> .q-field__append {
        color:#fff !important;
    }

    .custom-table1 >>> .q-table thead {
        border-color: rgba(255, 255, 255, 0.5);
    }

    .harvest {
        border:1px solid grey; 
        background:#134d02;
        font-size:12px;
        text-align: right;
        padding:0 15px;
    }

</style>