<template>
    <div class="jackpot" id="jackpot">
       <!-- <q-banner dense inline-actions
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
        </q-banner>-->
        <div class="g_slot_wrapper ">
            <div class="need_for_fix">
                <div class="window">
                    <div class="wiindow_path reall_scrool">
                        <div class="put_img_div_1">
                          <img src="" alt="" class="puting_img">
                        </div>
                        <div class="put_img_div_3">
                          <img :src="require(`@/assets/jackpot/images/1-9/3.png`)" alt="">
                        </div>
                        <div class="put_img_div_1">
                          <img :src="require(`@/assets/jackpot/images/1-9/1.png`)" alt="">
                        </div>
                        <div class="put_img_div_2">
                          <img :src="require(`@/assets/jackpot/images/1-9/2.png`)" alt="">
                        </div>
                        <div class="put_img_div_5">
                          <img :src="require(`@/assets/jackpot/images/1-9/5.png`)" alt="">
                        </div>
                        <div class="put_img_div_7">
                          <img :src="require(`@/assets/jackpot/images/1-9/7.png`)" alt="">
                        </div>
                        <div class="put_img_div_6">
                          <img :src="require(`@/assets/jackpot/images/1-9/6.png`)" alt="">
                        </div>
                        <div class="put_img_div_8">
                          <img :src="require(`@/assets/jackpot/images/1-9/8.png`)" alt="">
                        </div>
                        <div class="put_img_div_9">
                          <img :src="require(`@/assets/jackpot/images/1-9/9.png`)" alt="">
                        </div>
                        <div class="put_img_div_4">
                          <img :src="require(`@/assets/jackpot/images/1-9/4.png`)" alt="">
                        </div>
                        <div class="put_img_div_1">
                          <img :src="require(`@/assets/jackpot/images/1-9/what.png`)" alt="">
                        </div>
                    </div>
                </div>
                <div class="window">
                    <div class="wiindow_path reall_scrool">
                      <div class="put_img_div_1">
                        <img src="" alt="" class="puting_img">
                      </div>
                        <div class="put_img_div_2">
                          <img :src="require(`@/assets/jackpot/images/1-9/2.png`)" alt="">
                        </div>
                        <div class="put_img_div_3">
                          <img :src="require(`@/assets/jackpot/images/1-9/3.png`)" alt="">
                        </div>
                        <div class="put_img_div_9">
                          <img :src="require(`@/assets/jackpot/images/1-9/9.png`)" alt="">
                        </div>
                        <div class="put_img_div_1">
                          <img :src="require(`@/assets/jackpot/images/1-9/1.png`)" alt="">
                        </div>
                        <div class="put_img_div_5">
                          <img :src="require(`@/assets/jackpot/images/1-9/5.png`)" alt="">
                        </div>
                        <div class="put_img_div_6">
                          <img :src="require(`@/assets/jackpot/images/1-9/6.png`)" alt="">
                        </div>
                        <div class="put_img_div_7">
                          <img :src="require(`@/assets/jackpot/images/1-9/7.png`)" alt="">
                        </div>
                        <div class="put_img_div_4">
                          <img :src="require(`@/assets/jackpot/images/1-9/4.png`)" alt="">
                        </div>
                        <div class="put_img_div_8">
                          <img :src="require(`@/assets/jackpot/images/1-9/8.png`)" alt="">
                        </div>
                        <div class="put_img_div_1">
                          <img :src="require(`@/assets/jackpot/images/1-9/what.png`)" alt="">
                        </div>
                    </div>
                </div>
                <div class="window">
                    <div class="wiindow_path reall_scrool">
                      <div class="put_img_div_1">
                        <img src="" alt="" class="puting_img">
                      </div>
                        <div class="put_img_div_3">
                          <img :src="require(`@/assets/jackpot/images/1-9/3.png`)" alt="">
                        </div>
                        <div class="put_img_div_1">
                          <img :src="require(`@/assets/jackpot/images/1-9/1.png`)" alt="">
                        </div>
                        <div class="put_img_div_5">
                          <img :src="require(`@/assets/jackpot/images/1-9/5.png`)" alt="">
                        </div>
                        <div class="put_img_div_6">
                          <img :src="require(`@/assets/jackpot/images/1-9/6.png`)" alt="">
                        </div>
                        <div class="put_img_div_4">
                          <img :src="require(`@/assets/jackpot/images/1-9/4.png`)" alt="">
                        </div>
                        <div class="put_img_div_7">
                          <img :src="require(`@/assets/jackpot/images/1-9/7.png`)" alt="">
                        </div>
                        <div class="put_img_div_2">
                          <img :src="require(`@/assets/jackpot/images/1-9/2.png`)" alt="">
                        </div>
                        <div class="put_img_div_8">
                          <img :src="require(`@/assets/jackpot/images/1-9/8.png`)" alt="">
                        </div>
                        <div class="put_img_div_9">
                          <img :src="require(`@/assets/jackpot/images/1-9/9.png`)" alt="">
                        </div>
                        <div class="put_img_div_1">
                          <img :src="require(`@/assets/jackpot/images/1-9/what.png`)" alt="">
                        </div>
                    </div>
                </div>
                <div class="window">
                    <div class="wiindow_path reall_scrool">
                      <div class="put_img_div_1">
                        <img src="" alt="" class="puting_img">
                      </div>
                        <div class="put_img_div_5">
                          <img :src="require(`@/assets/jackpot/images/1-9/5.png`)" alt="">
                        </div>
                        <div class="put_img_div_1">
                          <img :src="require(`@/assets/jackpot/images/1-9/1.png`)" alt="">
                        </div>
                        <div class="put_img_div_2">
                          <img :src="require(`@/assets/jackpot/images/1-9/2.png`)" alt="">
                        </div>
                        <div class="put_img_div_4">
                          <img :src="require(`@/assets/jackpot/images/1-9/4.png`)" alt="">
                        </div>
                        <div class="put_img_div_9">
                          <img :src="require(`@/assets/jackpot/images/1-9/9.png`)" alt="">
                        </div>
                        <div class="put_img_div_7">
                          <img :src="require(`@/assets/jackpot/images/1-9/7.png`)" alt="">
                        </div>
                        <div class="put_img_div_3">
                          <img :src="require(`@/assets/jackpot/images/1-9/3.png`)" alt="">
                        </div>
                        <div class="put_img_div_6">
                          <img :src="require(`@/assets/jackpot/images/1-9/6.png`)" alt="">
                        </div>
                        <div class="put_img_div_8">
                          <img :src="require(`@/assets/jackpot/images/1-9/8.png`)" alt="">
                        </div>
                        <div class="put_img_div_1">
                          <img :src="require(`@/assets/jackpot/images/1-9/what.png`)" alt="">
                        </div>
                    </div>
                </div>
                <div class="window">
                    <div class="wiindow_path reall_scrool">
                        <div class="put_img_div_1">
                            <img src="" alt="" class="puting_img">
                        </div>
                        <div class="put_img_div_2">
                          <img :src="require(`@/assets/jackpot/images/1-9/2.png`)" alt="">
                        </div>
                        <div class="put_img_div_7">
                          <img :src="require(`@/assets/jackpot/images/1-9/7.png`)" alt="">
                        </div>
                        <div class="put_img_div_3">
                          <img :src="require(`@/assets/jackpot/images/1-9/3.png`)" alt="">
                        </div>
                        <div class="put_img_div_9">
                          <img :src="require(`@/assets/jackpot/images/1-9/9.png`)" alt="">
                        </div>
                        <div class="put_img_div_4">
                          <img :src="require(`@/assets/jackpot/images/1-9/4.png`)" alt="">
                        </div>
                        <div class="put_img_div_1">
                          <img :src="require(`@/assets/jackpot/images/1-9/1.png`)" alt="">
                        </div>
                        <div class="put_img_div_6">
                          <img :src="require(`@/assets/jackpot/images/1-9/6.png`)" alt="">
                        </div>
                        <div class="put_img_div_5">
                          <img :src="require(`@/assets/jackpot/images/1-9/5.png`)" alt="">
                        </div>
                        <div class="put_img_div_8">
                          <img :src="require(`@/assets/jackpot/images/1-9/8.png`)" alt="">
                        </div>
                        <div class="put_img_div_1">
                          <img :src="require(`@/assets/jackpot/images/1-9/what.png`)" alt="">
                        </div>
                    </div>
                </div>                
            </div>
        </div>
        <div class="result_message justify-center flex item-center">
          <div v-if = "isMetaMaskConnected && getJackpotStatus == 1" class="text-center success">
              <img :src="require(`@/assets/jackpot/images/cup.png`)" class="q-pr-sm" alt="">
              CONGRATS! You’ve won <span class="win">'{{getUserRewardNFT}}'</span> NFT! Claim your PRIZE!
          </div>
          <div v-if = "isMetaMaskConnected && getJackpotStatus == 100" class="text-center success">
              <img :src="require(`@/assets/jackpot/images/cup.png`)" class="q-pr-sm" alt="">
              CONGRATS! You’ve won <span class="win">{{getUserRewardToken}}</span> FTM! Claim your PRIZE!
          </div>
          <div v-if = "isMetaMaskConnected && getJackpotStatus == 2" class="text-center success">
              <img :src="require(`@/assets/jackpot/images/cup.png`)" class="q-pr-sm" alt="">
                You are lucky! but the reserve has no prize, sorry!
          </div>
          <div v-if = "isMetaMaskConnected && getJackpotStatus == 200" class="text-center success">
              <img :src="require(`@/assets/jackpot/images/cup.png`)" class="q-pr-sm" alt="">
               You are lucky, but the reserve has no prize money, sorry!
          </div>
          <div v-if = "isMetaMaskConnected && getJackpotStatus == 3" class="text-center no_winning">
              <img :src="require(`@/assets/jackpot/images/check.png`)" class="q-pr-sm check" alt="">
                Sorry! Better luck next time
              <img :src="require(`@/assets/jackpot/images/smile.png`)" class="q-pl-sm smile" alt="">
          </div>
          <div  v-if = "isMetaMaskConnected && getJackpotStatus == 4"  class="text-center working">
              <img :src="require(`@/assets/jackpot/images/loading.gif`)" class="q-pr-sm" alt="">
                Jackpot`s Spinning! Wait for the Result!
          </div>
        </div>
        <div class="All_button">
            <div class="All_button_wrapper">
                <button @click="goLink(0)">DOCS</button>
                <button @click="goLink(1)">HELP</button>
                <div v-if = "(getJackpotStatus != 1 && getJackpotStatus != 100)" 
                    class="palto">
                    <div class="pooii">
                        <button @click="buyTicket()" 
                                :disabled="getJackpotStatus == 5">spin the slot
                        </button>
                    </div>
                </div>
                <div v-if = "(getJackpotStatus == 1 || getJackpotStatus == 100)" 
                    class="palto">
                    <div class="pooii">
                        <button @click="claimJackpot()" >Claim Reward</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="Winner_wrapper text-justify" >
           Each spin gives you a chance to win from 8 NFTs (shown below) and $FTM. Get the same NFT in all 5 slots: YOU WIN! OR, Get FTM in ANY slot: YOU WIN (1, 5, 20, 50, 500 FTM, for getting FTM in 1 to 5 slots)! Enjoy the 1st 100% decentralised NFT Jackpot! Good luck 🏆
        </div>
        <div class="reward_bar">
            <div>
                <span>
                    What can you win:
                </span>
            </div>
            <div class="flex" v-if="isMetaMaskConnected">
              <div class="nft_avatar">
                  <img v-if="hasRewardToken" class="nft_avatar"
                      :src="require(`@/assets/ftm.png`)" alt="" 
                      title="FTM">
              </div>
              <div class="nft_avatar" v-for="j in getNFTCount" :key="j">
                  <img class="nft_avatar"
                      :src="require(`@/assets/jackpot/images/1-9/${getPoolNumber(j)}.png`)" alt="" 
                      :title="getNFTName(getPoolNumber(j))">
              </div>
        </div>
      </div>
      <div class="Winner_wrapper">
            <router-link to="/winnersboard">
                <img class="winnerboard" :src="require(`@/assets/jackpot/images/winnerboard.jpeg`)">
            </router-link>
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
            isMetaMaskConnected() {
                return this.$store.state.account != null;
            },
            getJackpotStatus() {
                return  this.$store.state.Jackpot.status;
            },
            getNFTCount() {
                return this.$store.state.Jackpot.nftCount;
            },
            hasRewardToken() {
                return this.$store.state.Jackpot.hasRewardToken;
            },
            getUserRewardToken() {
                if(this.$store.state.Jackpot.userRewardToken > 0)
                    return BigNumber(this.$store.state.Jackpot.userRewardToken).shiftedBy(-18)
                return BigNumber(0)
            },
            getUserRewardNFT() {
                return this.$store.state.Jackpot.userRewardNFT;
            }
        },
        watch: {
            async getJackpotStatus(newValue, oldValue) {
                if (newValue == 0 && oldValue == 4) {
                      this.short_fun_2();                   
                }
            },
        },
        mounted() {
        },
        methods: {
            connectWallet() {                
                this.$store.dispatch("connect")              
            },
            hasRewards(pool) {
                return this.$store.state.Jackpot.rewardsCount[pool]
            },
            getNFTName(index) {
                return this.$store.state.Jackpot.nftName[index]
            },
            getPoolNumber(index) {
                return this.$store.state.Jackpot.rewardPool[index - 1]
            },
            goLink(kind) {
                if (kind == 0)
                    window.open('https://discord.gg/Gj7JqN2mXZ', '_blank')
                else
                    window.open('https://discord.gg/Gj7JqN2mXZ', '_blank')
            },  
            getTicketNumber() {
                setTimeout(()=>{
                    if(!this.$store.state.Jackpot.startGegeneratedNumber)
                        this.getTicketNumber()
                    else
                    {
                        this.come_image_by_num();
                    }
                },500);
            },
            claimJackpot() {
                if (!this.isMetaMaskConnected) {
                    this.$store.commit('show_warning','Please connect a wallet.')
                        return;
                }

                this.$store.dispatch('claimJackpot')
            },
            buyTicket() {
                if (!this.isMetaMaskConnected) {
                    this.$store.commit('show_warning','Please connect a wallet.')
                        return;
                }

                this.$store.state.Jackpot.startGegeneratedNumber = false;
                this.$store.state.Jackpot.generatedNumber = "";

                this.come_image_by_num_at_first();

                this.$store.dispatch('buyTicket');

                this.getTicketNumber();

            },
            short_fun_1() {
                var elem=document.getElementsByClassName("reall_scrool"),
                i=0,
                interval=setInterval(function () {
                    elem[i].style.animation="scrool_in_reall_1 1.5s 100 linear forwards";
                
                    i++;
                    if (i==5) {
                      clearInterval(interval);
                    }
                }, 200);
            },
            short_fun_2() {
                var elem=document.getElementsByClassName("reall_scrool"),
                i=0,
                interval=setInterval(function () {
                    elem[i].style.animation="scrool_in_reall_2 2s 1 ease-out forwards";///???
                    
                    i++;
                    if (i==5) {
                        clearInterval(interval);
                    }
                }, 200);
            },
            come_image_by_num_at_first() {
                var img = document.getElementsByClassName("puting_img"),
                    elem=document.getElementsByClassName("reall_scrool");

                setTimeout(() => {
                  this.short_fun_1();
                }, 100);

                setTimeout(() => {      // !important
                    for (var i = 0; i < img.length; i++) {
                        img[i].src=require(`@/assets/jackpot/images/1-9/what.png`);
                    }
                }, 1000);
            },
            come_image_by_num() {
                var img = document.getElementsByClassName("puting_img"),
                    elem=document.getElementsByClassName("reall_scrool");

                this.short_fun_2();

                this.setTicketNumber();
            },
            setTicketNumber() {
                setTimeout(()=>{
                    if(this.$store.state.Jackpot.generatedNumber.length == 0) {
                        this.setTicketNumber()
                    }
                    else
                    {
                        var img = document.getElementsByClassName("puting_img");
                        var user_input_value = this.$store.state.Jackpot.generatedNumber,
                            alada_inp = user_input_value.split("");

                        for (var i = 0; i < img.length; i++) {
                            if (isNaN(user_input_value) == false) {
                                if (this.hasRewards(alada_inp[i]) > 0)
                                    img[i].src=require(`@/assets/jackpot/images/1-9/${ alada_inp[i]}.png`);
                                else
                                    img[i].src=require(`@/assets/jackpot/images/1-9/${ alada_inp[i]}_no.png`);
                            }
                        }
                    }
                }, 500);
            }
        }
    }
</script>

<style>
  .jackpot {
    padding-top:4px;
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

  .col {
    padding:0 !important;
  }

  img.nft_avatar {
    filter: drop-shadow(1px 2px 0px rgb(255, 60, 0) ) !important;
  }
  
  .jackpot > .q-banner .row {
    display: flex;
    flex-wrap: wrap;
  }
</style>
