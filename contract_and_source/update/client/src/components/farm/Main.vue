<template>
  <div class="farm">
    <section id="workingArea">
      <div class="p-lg-1">
        <div v-if="welcome" class="row welcome">
          <div class="col-11">
            <h3>Welcome to HAHA Farms!</h3>
          </div>
          <div class="col-1 justify-end q-mb-sm text-right">
            <q-icon
              name="close"
              class="cursor-pointer"
              @click="welcome = false"
            ></q-icon>
          </div>
          <p>
            To farm the precious Haha coin you no longer have to visit multiple
            platforms. We've integrated all the available farming pools in
            different platforms in this one place. You're still interacting with
            respective platforms' contracts, but in an easier UI, to have access
            to everything in just one place! Still in Beta!
          </p>
        </div>
        <div class="growth">
          <div class="d-flex justify-content-center">
            <div class="blog">
              <div class="tabBg">
                <h2>
                  {{ totalStaked() }}<br />
                  <small>Total Staked</small>
                </h2>
              </div>
            </div>
            <div class="blog">
              <div class="tabBg">
                <h2>
                  {{ totalEarned() }}<br />
                  <small>Total Earnings</small>
                </h2>
              </div>
            </div>
            <div class="blog">
              <div class="tabBg">
                <h2>
                  {{ getAPR() }} %<br />
                  <small>APR</small>
                </h2>
              </div>
            </div>
          </div>
          <p>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="14"
              height="14"
              viewBox="0 0 14 14"
            >
              <path
                d="M7,13 C3.6862915,13 1,10.3137085 1,7 C1,3.6862915 3.6862915,1 7,1 C10.3137085,1 13,3.6862915 13,7 C13,10.3137085 10.3137085,13 7,13 Z M7,3 C6.44771525,3 6,3.44771525 6,4 L6,7 C6,7.55228475 6.44771525,8 7,8 C7.55228475,8 8,7.55228475 8,7 L8,4 C8,3.44771525 7.55228475,3 7,3 Z M7,9 C6.44771525,9 6,9.44771525 6,10 C6,10.5522847 6.44771525,11 7,11 C7.55228475,11 8,10.5522847 8,10 C8,9.44771525 7.55228475,9 7,9 Z"
                transform="rotate(180 7 7)"
              />
            </svg>
            Total earnings is the sum of the rewards you've got from all the
            active farming pools.
          </p>
        </div>
        <div class="vaults">
          <div class="overview">
            <div class="d-flex justify-content-between">
              <div class="align-self-center">
                <h4 class="text-warning">
                  {{ this.userEarnedAmount }}
                  <small class="text-blue">Your Earnings</small>
                </h4>
              </div>
              <div class="align-self-center">
                <h4 class="text-warning">
                  {{ this.userStakedAmount }}
                  <small class="text-pink">Your Staked</small>
                </h4>
              </div>
              <div class="align-self-center">
                <h6 class="text-black">LP Tokens to Stake:</h6>
              </div>
              <q-select
                class="selectBurnToken w-25"
                v-model="selectedDepositItem"
                :options="getNFTInfo"
                label="Available Deposit Token"
                item-text="name"
                @input="changeHarvestForDeposit()"
                dense
                outlined
                solo
                autocomplete="off"
              >
              </q-select>
              <q-td colspan="2">
                <div
                  v-if="!isMetaMaskConnected"
                  class="btn btn-default text-white"
                  @click="connectWallet"
                >
                  Connect
                </div>
                <div v-show="isMetaMaskConnected">
                  <div
                    v-if="!isApproved()"
                    class="btn btn-warning text-white"
                    @click="approve()"
                  >
                    Approve
                  </div>
                  <div
                    v-if="isApproved()"
                    class="btn btn-primary text-white"
                    @click="stake()"
                  >
                    Stake
                  </div>
                </div>
              </q-td>
            </div>
            <q-table
              title="Farming Pools"
              class="custom-table table"
              :data="getDepositInfoPerUser()"
              :columns="columns"
              row-key="id"
            >
              <template v-slot:body="props">
                <q-tr
                  :props="props"
                  @click.native="
                    props.row.id == 0 ? (props.expand = !props.expand) : null
                  "
                  class="brdBtm"
                  id="fstBtn"
                >
                  <q-td style="width: 70px">
                    <q-img
                      :src="props.row.fromImage"
                      class="rounded-borders q-mr-sm farm_avatar"
                    ></q-img>
                    <q-img
                      :src="props.row.toImage"
                      class="rounded-borders q-mr-sm farm_avatar"
                    ></q-img>
                  </q-td>
                  <q-td style="width: 250px">
                    <div class="label text-primary">
                      {{ props.row.pair }} :
                      <span class="text-warning">{{ props.row.tokenId }}</span>
                    </div>
                    Tax Fee: {{ props.row.taxFee }} % - {{ props.row.farm }}
                  </q-td>
                  <q-td style="width: 200px">
                    <div class="label text-red">
                      Earned: {{ props.row.earnedAmount }}
                    </div>
                    Staked : {{ props.row.stakedAmount }} (HAHA)
                  </q-td>
                  <q-td style="width: 150px">
                    <div class="label text-success">
                      {{ props.row.rewardAmount }} HAHA
                    </div>
                    Available reward
                  </q-td>
                  <q-td class="text-right">
                    <div class="text-gray">
                      Next harvest:
                      <span class="text-primary text-bold">
                        {{ props.row.remainedTimeForHarvest }}
                      </span>
                      mins remains
                    </div>
                    <div
                      class="btn btn-primary text-white border-white"
                      @click="
                        harvest(props.row.pId, props.row.availableHarvest)
                      "
                      :disabled="props.row.availableHarvest"
                    >
                      Harvest
                    </div>
                  </q-td>
                  <q-td class="text-right">
                    <div class="text-gray">
                      Withdraw:
                      <span class="text-red text-bold">
                        {{ props.row.remainedTimeForWithdraw }}
                      </span>
                      mins remains
                    </div>
                    <div
                      class="btn btn-success text-white border-white"
                      @click="
                        unstake(props.row.pId, props.row.availableWithdraw)
                      "
                      :disabled="props.row.availableWithdraw"
                    >
                      Withdraw
                    </div>
                  </q-td>
                </q-tr>
              </template>
            </q-table>
          </div>
        </div>
      </div>
      <ConnectComponent
        @error="onError"
        @response="onResponse"
        v-model="show"
      />
    </section>
  </div>
</template>
<style lang="css" scoped>
@import "./Main.css";
</style>
<script>
import BigNumber from "bignumber.js";
import ConnectComponent from "../ConnectComponent.vue";
export default {
  components: {
    ConnectComponent,
  },
  data() {
    return {
      show: false,
      stackAmount: 10,
      rerender: 0,
      welcome: true,
      filter: "all",
      provider: null,
      account: null,
      chainId: null,
      userStakedAmount: 0,
      userEarnedAmount: 0,
      availableHarvestInterval: 120, // 2 mins
      availableWithdrawInterval: 300, // 5 mins
      availableHarvestItems: [],
      selectedDepositItem: null,
      selectedDeposit: 0,
      indexPool: 0,
      depositInfo: [],
      columns: [
        {
          name: "pool",
          field: "pool",
          label: "Pool",
          align: "left",
          sortable: true,
        },
        {
          name: "tokenId",
          field: "tokenId",
          label: "TokenId",
          align: "right",
          sortable: true,
        },
        {
          name: "stakedAmount",
          field: "stakedAmount",
          label: "StakedAmount",
          align: "right",
          sortable: true,
        },
        {
          name: "rewardAmount",
          field: "rewardAmount",
          label: "RewardAmount",
          align: "right",
          sortable: true,
        },
        {
          name: "earnedAmount",
          field: "earnedAmount",
          label: "EarnedAmount",
          align: "right",
          sortable: true,
        },
        {
          name: "taxFee",
          field: "taxFee",
          label: "TaxFee",
          align: "right",
          sortable: true,
        },
      ],
      amountStake: [],
      amountHarvest: [],
      amountUnstake: [],
    };
  },
  computed: {
    getNFTInfo() {
      return this.$store.state.nftItem;
    },

    isMetaMaskInstalled() {
      const { ethereum } = window;
      return Boolean(ethereum && ethereum.isMetaMask);
    },
    isMetaMaskConnected() {
      return this.$store.state.account != null;
    },
    isMobile() {
      return this.$q.screen.width < 992;
    },
  },
  async mounted() {
    // this.getDepositInfoPerUser();
  },
  watch: {
    getNFTInfo(newValue) {
      console.log(newValue);
      this.availableHarvestItems = newValue;
    },
  },
  methods: {
    onError(err) {
      console.debug({ err: err.message });
      console.error(err);
    },
    async onResponse({ provider, account, chainId }) {
      console.log("res", provider);
      console.log("res", account);
      console.log("res", chainId);
      this.provider = provider;
      this.account = account;
      this.chainId = chainId;
      this.$store.dispatch("connect", {
        address: this.account,
        provider: this.provider,
      });
    },
    opennoegg() {
      if (!this.isMobile) {
        console.log("conne");
        return;
      }
      console.log("conne");
      const menu = document.getElementsByClassName("menuBar")[0].style.display;
      if (menu === "block") {
        document.getElementsByClassName("menuBar")[0].style.display = "none";
      } else {
        document.getElementsByClassName("menuBar")[0].style.display = "block";
      }
    },
    connectWallet() {
      this.show = true;
      this.opennoegg();
    },
    getDepositInfoPerUser() {
      let rows = [];
      if (this.$store.state.account && this.$store.state.farming.perUserInfo) {
        if (this.$store.state.farming.perUserInfo[2].length > 0) {
          console.log(this.$store.state.farming.perUserInfo);
          this.userEarnedAmount = BigNumber(
            this.$store.state.farming.perUserInfo[1]
          )
            .shiftedBy(-18)
            .toFormat(2);
          this.userStakedAmount = BigNumber(
            this.$store.state.farming.perUserInfo[0]
          )
            .shiftedBy(-18)
            .toFormat(2);

          for (
            let i = 0;
            i < this.$store.state.farming.perUserInfo[2].length;
            i++
          ) {
            let perData = this.$store.state.farming.perUserInfo[2][i];
            let taxFee =
              30 -
              (Math.floor(Date.now() / 1000) - perData.startDeposit) / (60 * 3);

            let _rewardPerDay = 10000000000000000000000 / 1440;
            let _rewardRate =
              (Math.floor(Date.now() / 1000) - perData.lastUpdatedTime) / 60;
            let _rewardAmount =
              (((_rewardRate * perData.amountPerNFT * _rewardPerDay) /
                this.$store.state.farming.totalLPtokenAmount) *
                (100 - taxFee)) /
              100;
            console.log("reward amount", _rewardAmount);

            let _remainedTimeForHarvest = (
              (this.availableHarvestInterval -
                (Math.floor(Date.now() / 1000) - perData.lastUpdatedTime)) /
              60
            ).toFixed(2);
            let _remainedTimeForWithdraw = (
              (this.availableWithdrawInterval -
                (Math.floor(Date.now() / 1000) - perData.startDeposit)) /
              60
            ).toFixed(2);
            let _availableHarvest = false;
            let _availableWithdraw = false;
            let _harvestTime = 0;
            let _withdrawTime = 0;

            if (_remainedTimeForWithdraw >= 0) {
              _availableWithdraw = true;
              _availableHarvest = true;
              _harvestTime = _remainedTimeForWithdraw;
            } else {
              if (_remainedTimeForHarvest < 0) {
                _harvestTime = 0;
              } else {
                _availableHarvest = true;
                _harvestTime = _remainedTimeForHarvest;
              }
            }

            if (_remainedTimeForWithdraw > 0) {
              _availableWithdraw = true;
              _withdrawTime = _remainedTimeForWithdraw;
            }

            rows[i] = {
              id: i,
              farm: "Haha",
              pair: "HAHA-FTM",
              pId: perData.pId,
              taxFee: taxFee.toFixed(0),
              availableHarvest: _availableHarvest,
              availableWithdraw: _availableWithdraw,
              earnedAmount: BigNumber(perData.rewardAmountHistory)
                .shiftedBy(-18)
                .toFormat(2),
              stakedAmount: BigNumber(perData.amountPerNFT)
                .shiftedBy(-18)
                .toFormat(2),
              rewardAmount: BigNumber(_rewardAmount).shiftedBy(-18).toFixed(2),
              remainedTimeForHarvest: _harvestTime,
              remainedTimeForWithdraw: _withdrawTime,
              fromImage: require("@/assets/icons/haha.webp"),
              toImage: require("@/assets/icons/ftm.png"),
            };
          }
        }
      }
      console.log(rows);
      return rows;
    },
    changeHarvestForDeposit() {
      let item = this.availableHarvestItems;
      let value = item.find((x) => x === this.selectedDepositItem);
      this.selectedDeposit = value;
    },

    isApproved() {
      let index = this.selectedDeposit;
      if (index != 0) {
        return this.$store.state.approvedDiamondPairMaster;
      }
    },
    approve() {
      let index = this.selectedDeposit;
      this.$store.dispatch("approvePairMaster", {
        index: 0,
        amount: index,
      });
    },
    totalStaked() {
      if (BigNumber(this.$store.state.farming.totalLPtokenAmount).isNaN())
        return 0;

      if (this.$store.state.farming.totalLPTokenAmount != null) {
        return BigNumber(this.$store.state.farming.totalLPtokenAmount)
          .shiftedBy(-18)
          .toFormat(5);
      } else return 0;
    },
    totalEarned() {
      if (BigNumber(this.$store.state.farming.totalLPtokenEarned).isNaN())
        return 0;
      if (this.$store.state.farming.totalLPtokenEarned != null) {
        return BigNumber(this.$store.state.farming.totalLPtokenEarned)
          .shiftedBy(-18)
          .toFormat(3);
      } else return 0;
    },
    getInfoPerUser() {
      if (this.$store.state.account) {
        console.log(this.$store.state.farming.perUserInfo[1].length);
        return this.$store.state.farming.perUserInfo;
      }
    },
    forceUpdate() {
      this.rerender++;
    },
    showWallet(wallet) {
      if (wallet == "0x0000000000000000000000000000000000000000") return "";
      else
        return (
          wallet.substring(0, 12) +
          "..." +
          wallet.substring(wallet.length - 6, wallet.length)
        );
    },
    stake() {
      this.$store.dispatch("deposit", {
        index: 0,
        amount: this.selectedDeposit,
      });
    },
    unstake(index, isDisabled) {
      console.log(isDisabled);
      if (isDisabled == false) {
        this.$store.dispatch("withdrawLPs", {
          index: 0,
          amount: index,
        });
        this.forceUpdate();
      }
    },
    harvest(pid, isDisabled) {
      if (isDisabled == false) {
        console.log(pid);
        this.$store
          .dispatch("harvest", {
            amountHarvest: pid,
          })
          .then((ret) => {
            // if (ret.blockHash != null) {
            //     var myTable = document.getElementById('farming').getElementsByClassName('q-table')[0];
            //     myTable.rows[index+1].cells[2].innerHTML = '0.00';
            //     myTable.rows[index+1].cells[4].getElementsByClassName('q-btn')[0].disabled = true;
            // }
          });
      }
    },
    getAPR() {
      console.log(this.$store.state.farming.APRValue);
      return this.$store.state.farming.APRValue;
    },

    balance(index) {
      if (index == 0) {
        if (this.$store.state.account && this.$store.state.liquidity.balance) {
          return BigNumber(this.$store.state.liquidity.balance)
            .shiftedBy(-18)
            .toFormat(5);
        }
      } else if (index == 1) {
        /*
                    if(this.$store.state.account && this.$store.state.liquidity.balanceOfDiamondPair) {
                        return BigNumber(this.$store.state.liquidity.balanceOfDiamondPair)
                            .shiftedBy(-18).toFormat(5);
                    }
                    */
      }
      return 0;
    },
    balanceInDollar(index) {
      if (index == 0) {
        if (this.$store.state.account && this.$store.state.liquidity.balance) {
          return BigNumber(this.$store.state.liquidity.balance)
            .times(this.$store.state.price.LP_FTM_Diamond)
            .shiftedBy(-18)
            .toFormat(5);
        }
      } else if (index == 1) {
        /*
                    if(this.$store.state.account && this.$store.state.liquidity.balanceOfDiamondPair) {
                        return BigNumber(this.$store.state.liquidity.balanceOfDiamondPair)
                            .shiftedBy(-18).toFormat(5);
                    }
                    */
      }
      return 0;
    },
    maxUnstake(index) {
      let balance;
      balance = this.$store.state.farming.balance[index];

      if (!balance) return BigNumber(0);

      return BigNumber(balance).shiftedBy(-18);
    },
    maxUnstakeInDollar(index) {
      return this.maxUnstake(index).times(
        this.$store.state.price.LP_FTM_Diamond
      );
    },
    totalUserStakedInDollar() {
      let value = this.maxUnstakeInDollar(0);
      return value.toFormat(5);
    },
    userEarned(index) {
      return BigNumber(this.$store.state.farming.earnedToken[index]).plus(
        BigNumber(this.$store.state.farming.pendingDiamond[index])
      );
    },
    userEarnedInDollar(index) {
      return this.userEarned(index)
        .times(this.$store.state.price.Diamond)
        .shiftedBy(-18);
    },
    totalUserEarnedInDollar() {
      let value = this.userEarnedInDollar(0);
      return value.toFormat(5);
    },
    getMaxStake(index) {
      if (index == 0)
        this.amountStake[index] = BigNumber(
          this.$store.state.liquidity.balance
        ).shiftedBy(-18);
      this.forceUpdate();
    },
    getMaxUnstake(index) {
      if (index == 0)
        this.amountUnstake[index] = BigNumber(
          this.$store.state.farming.balance[index]
        ).shiftedBy(-18);
      this.forceUpdate();
    },
    getAmount(amount) {
      let value = BigNumber(amount).shiftedBy(-18);
      if (value.isGreaterThan(2000)) {
        return value.shiftedBy(-3).toFormat(5) + "K";
      } else {
        return value.toFormat(5);
      }
    },
    getDate(amount) {
      let date = amount * 1000;
      const options = {
        year: "numeric",
        month: "numeric",
        day: "numeric",
        hour: "numeric",
        minute: "numeric",
      };
      const dtf = new Intl.DateTimeFormat("en-US", options);
      return dtf.format(date);
    },
  },
};
</script>
<style scoped>
#workingArea {
  width: 100vw;
  min-height: 95vh;
  overflow: scroll;
  overflow-x: hidden;
  background-image: url("../../assets/Background.png");
  background-size: cover;
  background-repeat: no-repeat;
  background-position: center;
  padding-top: 10rem;
}

.farm {
  background-color: #eefdfe;
  background-size: cover;
  color: #000 !important;
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
  border: 1px solid #fff !important;
  box-shadow: none;
}

.farm_avatar {
  width: 40px;
  height: 40px;
}
.label {
  color: #f93800;
  font-weight: 500;
  font-size: 18px !important;
}

.label_sm {
  color: #f93800;
  font-weight: 500;
  font-size: 14px !important;
}

.value {
  margin-top: 5px;
  font-weight: bold !important;
}

.custom-table >>> .plus {
  font-size: 22px;
  color: #f93800;
  font-weight: 500;
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
  background-image: linear-gradient(
      224deg,
      var(--q-color-secondary),
      var(--q-color-dark)
    ),
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
  margin: 0 !important;
}

.custom-table1 {
  width: 100%;
  margin: auto;
  color: white;
  padding: 0 20px;
  border: none !important;
}

.custom-table1 >>> div.row {
  margin: 0 !important;
}

.custom-table1 >>> div.col {
  margin: 0 !important;
}

.custom-table1 >>> thead tr:first-child th {
  color: rgb(255, 255, 0);
  font-size: 12px;
  font-weight: 500;
}

.custom-table1 >>> .q-field__control .col {
  padding: 0 !important;
}

.custom-table1 >>> .q-field__control span {
  color: #fff !important;
}

.custom-table1 >>> .q-field__append {
  color: #fff !important;
}

.custom-table1 >>> .q-table thead {
  border-color: rgba(255, 255, 255, 0.5);
}

.harvest {
  border: 1px solid grey;
  background: #134d02;
  font-size: 12px;
  text-align: right;
  padding: 0 15px;
}
</style>
