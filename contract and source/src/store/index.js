import Vue from 'vue'
import Vuex from 'vuex'
import { BigNumber } from 'bignumber.js'
import Web3 from "web3/lib"
import axios from 'axios'

import abiJackpot from '@/abi/jackpot.json'

import abiDiamond from '@/abi/diamondtoken.json'
import abiLiquidityGenerator from '@/abi/liquidityGenerator.json'
import abiDistributor from '@/abi/distributor.json'
import abiDiamondExchanger from '@/abi/diamondExchanger.json'
import abiMasterchef from '@/abi/masterchef.json'
import abiERC20 from '@/abi/ERC20.json'
import abiPair from '@/abi/diamondPair.json'
import abiFantoonNFT from '@/abi/fantoonNFT.json'
import abiSpiritSwapRouter from '@/abi/spiritSwapRouter.json'
import abiSpiritSwapFactory from '@/abi/spiritSwapFactory.json'
import abiSpiritSwapPair from '@/abi/spiritSwapPair.json'
import abiPriceOracleProxy from '@/abi/priceOracleProxy.json'
/*
import abiSolidlyRouter from '@/abi/solidlyRouter.json'
import abiSolidlyFactory from '@/abi/solidlyFactory.json'
import abiSolidexMasterchef from '@/abi/solidexMasterchef.json'
import abiOxdMasterchef from '@/abi/oxdMasterchef.json'
*/
let testnet = false;

let ADDR_TOKEN_DIAMOND;
let ADDR_LIQUIDITY_GENERATOR;
let ADDR_DISTRIBUTOR;
let ADDR_DIAMOND_EXCHANGER;
let ADDR_DIAMOND_MASTERCHEF;
let ADDR_LP_FTM_DIAMOND;
let ADDR_LP_TOKEN_2;
let ADDR_JACKPOT;
let ADDR_SPIRITSWAP_ROUTER;
let ADDR_SPIRITSWAP_FACTORY;
let ADDR_PRICEPROXY;
let ADDR_FANTOON_NFT;
let ADDR_FTM;

let ADDR_SOLIDLY_ROUTER;
let ADDR_SOLIDLY_FACTORY;
let ADDR_SOLIDEX_MASTERCHEF;
let ADDR_OXD_MASTERCHEF;

if (testnet) {
  ADDR_TOKEN_DIAMOND = '0x14c17293Dc0589D0bD62EeD3980366A6DA49d784'
  ADDR_LIQUIDITY_GENERATOR = '0xaB9A5bB25A822d756aED67B5f3639F5D82465101'
  ADDR_DISTRIBUTOR = '0x0e4628459EA5f8054f58aB632f945d207E5276B4'
  ADDR_DIAMOND_EXCHANGER = '0xaB7425C2249f778125AE2789764Dda06d2541f54'
  ADDR_DIAMOND_MASTERCHEF = '0x5dcFa45Ff238f053d12B012EC780CABDBbC1AbA1'
  ADDR_LP_FTM_DIAMOND = '0xD3566bEECC52206e0b9910a565879b2093743356'
  ADDR_LP_TOKEN_2 = ''
  ADDR_JACKPOT = '0x4Abb710b3dea521Ea2c95bE9da339E2D52c34f43'
  ADDR_SPIRITSWAP_ROUTER = '0x2Ee8FD4E67F2ab5990aB6ddb4F71016D31D3A3cd'
  ADDR_SPIRITSWAP_FACTORY = '0xb1e784BaC1DB2A811586Af33f61b57f6230D25F6'
  ADDR_PRICEPROXY = '0xb3E3a86C6712ec50b763F30481f1ee1f96D758aD'
  ADDR_FANTOON_NFT = '0xc52185060952aeEbd16828b227861f5580eE26A5'
  ADDR_FTM = '0xf1277d1Ed8AD466beddF92ef448A132661956621'

  ADDR_SOLIDLY_ROUTER = ''
  ADDR_SOLIDLY_FACTORY = ''
  ADDR_SOLIDEX_MASTERCHEF = ''
  ADDR_OXD_MASTERCHEF = ''
}
else {
  ADDR_TOKEN_DIAMOND = '0xDDa0F0E1081b8d64aB1D64621eb2679F93086705'
  ADDR_LIQUIDITY_GENERATOR = '0x80685634D1C77b58993634c8b113e15ED1270347'
  ADDR_DISTRIBUTOR = '0x94aB9e6402AadE253064Ea2462Ee0E7d3a2C5078'
  ADDR_DIAMOND_EXCHANGER = '0x7255Afc52621C449aEc1E98127e2B1EFe813A137'
  ADDR_DIAMOND_MASTERCHEF = '0xc0bc830204529567098f9A2Cdf3FEE959326e73F'
  ADDR_LP_FTM_DIAMOND = '0xf5e8B220843EC7114B91AfF0D25342c24eB953b5'
  ADDR_LP_TOKEN_2 = ''
  ADDR_JACKPOT = '0x61d4f7Df2D6FF313B132a2D3F350A4700522Ddc3'
  ADDR_SPIRITSWAP_ROUTER = '0x16327e3fbdaca3bcf7e38f5af2599d2ddc33ae52'
  ADDR_SPIRITSWAP_FACTORY = '0xEF45d134b73241eDa7703fa787148D9C9F4950b0'
  ADDR_PRICEPROXY = '0x38Ef8b44771D204F8140488275D33072b808D801'
  ADDR_FANTOON_NFT = '0x7feBf8Cdf58261d929e31796689aEE37a2F62c33'
  ADDR_FTM = '0x21be370D5312f44cB42ce377BC9b8a0cEF1A4C83'

  ADDR_SOLIDLY_ROUTER = '0xa38cd27185a464914D3046f0AB9d43356B34829D'
  ADDR_SOLIDLY_FACTORY = ''
  ADDR_SOLIDEX_MASTERCHEF = '0x26E1A0d851CF28E697870e1b7F053B605C8b060F'
  ADDR_OXD_MASTERCHEF = '0xD2f585C41cca33dce5227C8DF6aDF604085690c2'
}

const ADDR_NULL = '0x0000000000000000000000000000000000000000';
const UINT256_MAX = '115792089237316195423570985008687907853269984665640564039457584007913129639935'

const MAXIMUM_MINT_TOKEN = 300;
const MAXIMUM_MINT_TOKEN_COUNT_FOR_ACCOUNT = 10;

BigNumber.config({ EXPONENTIAL_AT: 100 })

Vue.use(Vuex)

export default new Vuex.Store({
    state: {
      count:0,
      account: null,
      messageContent: null,
      messageType: null,
      approvedDiamond0:false,
      approvedDiamond1:false,
      approvedDiamondPairMaster: false,
      balance:null,
      contracts: {
        tokenJackpot: null,
        tokenDiamond: null,
        tokenLP:[],
        tokenDistributor: null,
        tokenLiquidityGenerator: null,
        tokenDiamondExchanger: null,
        tokenMasterchef: null,
        tokenFantoonNFT:null,
        tokenSpiritSwapRouter:null,
        tokenPriceOracleProxy: null,
        tokenSolidlyRouter: null,
        tokenSolidlyFactory: null,
        tokenSolidexMasterchef: null,
        tokenOxdMasterchef: null,
      },
      Jackpot: {
        cost: 0,
        generatedNumber: 0,
        startGegeneratedNumber: false,
        hasRewardToken: false,
        nftCount:0,
        rewardsCount:[],
        nftName:[],
        rewardPool: [],
        rewards:[],
        status:null,
        totalPlayers: 0,
        totalPlays: 0,
        totalWinSpins: 0,
        mySpins: 0,
        myWins: 0,
        userRewardToken: 0,
        userRewardNFT: 0
      },
      diamond: {
        totalLPTokens: 0,
        totalMember: 0,
        totalEmission: 0,
        currentDay:0,
        startTime:0,
        nextDay: 0,
        currentPossibleRewards:0,
        pendingDiamond:0,
        balanceLP0:BigNumber,
        balanceLP1:BigNumber,
        enableSendLPtoken:true,
        userSentLP: BigNumber,
        diamondPrice: BigNumber,
        lpPrice: BigNumber
      },
      reward: {
        withdrawnFTMfromNFT : BigNumber,
        withdrawableFTMfromNFT : BigNumber,
        withdrawnFTMfromJackpot  :BigNumber,
        withdrawableFTMfromJackpot : BigNumber
      },
      liquiditygenerator: {
        totalFTMShares: BigNumber,
        normalVestingDiamond: BigNumber,
        vestingEnd: BigNumber,
        vestingBegin: BigNumber,
        periodEnd: BigNumber,
        periodBegin: BigNumber,
        periodDuration: BigNumber,
        diamondPriceInLGE: BigNumber,
        RecipientInfo: null,
      },
      diamondExchanger: {
        remainingDiamond: BigNumber,
        userFTM: BigNumber,
        userDiamond: BigNumber,
        diamondPrice: BigNumber,
        minFTM: BigNumber,
        maxFTM: BigNumber
      },
      liquidity: {
        amountDiamond: BigNumber,
        amountFTM: BigNumber,
        balance: BigNumber,
      },
      farming: {
        balance: [],
        pendingDiamond: [],
        claimableDiamond: [],
        earnedToken: [],
        totalSupply: [],
        totalStaked: BigNumber,
        totalEarning: [],
        totalDiamondRewards: BigNumber,
        depositInfo: null,
        earnedTokenInfo: [],
        claimableTokenInfo: [],
        taxInfo: [],
        dailyReward: BigNumber
      },
      price: {
        FTM: BigNumber,
        Diamond: BigNumber,
        LP_FTM_Diamond: BigNumber,
        LP_FB_Diamond1: BigNumber,
        LP_FB_Diamond2: BigNumber,
      },
      fantoonnft: {
        totalSupply: Number,
        price: BigNumber,
        tokenIds: [],
        tokenPrices:[],
        tokenURIs:[],
        imageURIs:[],
        tokenNames:[],
        tokenAttributes:[],
        searchResult:false,
      },
    },
    mutations: {
        increment: (state) => {
          state.count ++;
        },
        init(state) {
            state.contracts.tokenDiamond = new window.web3.eth.Contract(abiDiamond, ADDR_TOKEN_DIAMOND);
            state.contracts.tokenLiquidityGenerator = new window.web3.eth.Contract(abiLiquidityGenerator, ADDR_LIQUIDITY_GENERATOR);
            state.contracts.tokenDistributor = new window.web3.eth.Contract(abiDistributor, ADDR_DISTRIBUTOR);
            state.contracts.tokenDiamondExchanger = new window.web3.eth.Contract(abiDiamondExchanger, ADDR_DIAMOND_EXCHANGER);
            state.contracts.tokenMasterchef = new window.web3.eth.Contract(abiMasterchef, ADDR_DIAMOND_MASTERCHEF);
            state.contracts.tokenJackpot = new window.web3.eth.Contract(abiJackpot, ADDR_JACKPOT);
            state.contracts.tokenFantoonNFT = new window.web3.eth.Contract(abiFantoonNFT, ADDR_FANTOON_NFT);
            state.contracts.tokenSpiritSwapRouter = new window.web3.eth.Contract(abiSpiritSwapRouter, ADDR_SPIRITSWAP_ROUTER);
            state.contracts.tokenPriceOracleProxy = new window.web3.eth.Contract(abiPriceOracleProxy, ADDR_PRICEPROXY);

            state.contracts.tokenLP[0] = new window.web3.eth.Contract(abiPair, ADDR_LP_FTM_DIAMOND);
            state.contracts.tokenLP[1] = new window.web3.eth.Contract(abiERC20, ADDR_LP_TOKEN_2);
/*
            state.contracts.tokenSolidlyRouter = new window.web3.eth.Contract(abiSolidlyRouter, ADDR_SOLIDLY_ROUTER);
            state.contracts.tokenSolidlyFactory = new window.web3.eth.Contract(abiSolidlyFactory, ADDR_SOLIDLY_FACTORY);
            state.contracts.tokenSolidexMasterchef = new window.web3.eth.Contract(abiSolidexMasterchef, ADDR_SOLIDEX_MASTERCHEF);
            state.contracts.tokenOxdMasterchef = new window.web3.eth.Contract(abiOxdMasterchef, ADDR_OXD_MASTERCHEF);
*/      
       },
        set_account(state,account) {
            state.account = account      
        },
        check_approve(state,account) {
          if (state.contracts.tokenLP[0] != null) {
            state.contracts.tokenLP[0].methods.allowance(account.address, ADDR_TOKEN_DIAMOND)
            .call().then((ret)=>{
              if (ret > 0) {
                state.approvedDiamond0 = true
              }
              else {
                state.approvedDiamond0 = false
              }
            }).catch((error)=>{
              console.error("tokenLP.allowance",error)
            });
          }
/*
          if (state.contracts.tokenLP[1] != null) {
            state.contracts.tokenLP[1].methods.allowance(account.address, ADDR_TOKEN_DIAMOND)
            .call().then((ret)=>{
              if (ret > 0) {
                state.approvedDiamond1 = true
              }
              else {
                state.approvedDiamond1 = false
              }
            }).catch((error)=>{
              console.error("tokenLP.allowance",error)
            });
          }
*/
          state.contracts.tokenLP[0].methods
            .allowance(account.address, ADDR_DIAMOND_MASTERCHEF).call().then((ret)=>{
            if (ret > 0) {
              state.approvedDiamondPairMaster = true;
            }
            else {
              state.approvedDiamondPairMaster = false;
            }
          }).catch((error)=>{
            console.error("tokenDiamondPair.allowance",error)
          });
        },
        show_info(state,message) {
            state.messageContent = message
            state.messageType = 'info'
        },
        show_success(state,message) {
            state.messageContent = message
            state.messageType = 'success'
        },
        show_error(state,message) {
            state.messageContent = message
            state.messageType = 'error'
        },
        show_warning(state,message) {
            state.messageContent = message
            state.messageType = 'warning'
        },
        read_jackpot(state) {
            state.contracts.tokenJackpot.methods.cost()
            .call().then(ret=>{
                state.Jackpot.cost = BigNumber(ret)
            }).catch((error)=>{
                console.error("tokenJackpot.get cost", error)
            })

            state.contracts.tokenJackpot.methods.getBalanceOfRewardToken()
            .call().then(ret=>{
              state.contracts.tokenJackpot.methods.prizeRewardToken(0)
              .call().then(ret1=>{
                  if (ret >= ret1)
                    state.Jackpot.hasRewardToken = true;
                  else
                    state.Jackpot.hasRewardToken = false;
              }).catch((error)=>{
                  console.error("tokenJackpot.prizeRewardToken", error)
              })                
            }).catch((error)=>{
                console.error("tokenJackpot.getBalanceOfRewardToken", error)
            })

            if(state.account)
            {
              window.web3.eth.getBalance(state.account.address).then(ret=>{
                state.balance = BigNumber(ret)
              })

              state.contracts.tokenJackpot.methods.userInfo(state.account.address)
              .call().then((ret)=>{
                if (ret.purchasedIndex > 0) {
                  if (ret.winnedByRewardToken) {
                    state.contracts.tokenJackpot.methods.purchasedInfo(Number(ret.purchasedIndex)-1)
                    .call().then((ret)=>{
                      var prizeAmount = ret.rewardTokenAmount;
                      state.Jackpot.userRewardToken = prizeAmount;
                    }).catch((error)=>{
                      console.error("tokenJackpot.purchasedInfo",error)
                    })

                    state.Jackpot.status = 100    // already reward token win but not claim yet
                  }
                  else if (ret.winnedByNFT) {
                    state.contracts.tokenJackpot.methods.purchasedInfo(Number(ret.purchasedIndex)-1)
                    .call().then((ret)=>{
                      var pool = ret.pool;
                      state.contracts.tokenJackpot.methods.nftInfo(ret.pool)
                      .call().then((ret)=>{
                        state.Jackpot.userRewardNFT = ret.name;
                      }).catch((error)=>{
                        console.error("tokenJackpot.purchasedInfo",error)
                      })
                    }).catch((error)=>{
                      console.error("tokenJackpot.purchasedInfo",error)
                    })
                    state.Jackpot.status = 1    // already NFT win but not claim yet
                    
                  }
                }
              }).catch((error)=>{
                  console.error("tokenJackpot.userInfo", error)
              })

              state.contracts.tokenJackpot.methods.userPlayedInfo(state.account.address)
              .call().then(ret=>{
                  state.Jackpot.mySpins = ret.playedCount
                  state.Jackpot.myWins = ret.winnedCount
              }).catch((error)=>{
                  console.error("tokenJackpot.userPlayedInfo", error)
              })
            }

            state.contracts.tokenJackpot.methods.currentUserCount()
            .call().then(ret=>{
                state.Jackpot.currentUserCount = ret
            }).catch((error)=>{
                console.error("tokenJackpot.currentUserCount", error)
            })

            state.contracts.tokenJackpot.methods.getPlayers()
            .call().then(ret=>{
                state.Jackpot.totalPlayers = ret.length
            }).catch((error)=>{
                console.error("tokenJackpot.getPlayers", error)
            })

            state.contracts.tokenJackpot.methods.totalPlays()
            .call().then(ret=>{
                state.Jackpot.totalPlays = ret
            }).catch((error)=>{
                console.error("tokenJackpot.totalPlays", error)
            })

            window.web3.eth.getBalance(ADDR_JACKPOT).then(ret=>{
              if (ret == 0) {
                state.contracts.tokenJackpot.methods.hasNFTforRewards()
                .call().then(ret=>{
                    if (ret == 0) {
                      state.Jackpot.status = 5    // 5 No reward
                    }
                    else {
//                      state.Jackpot.status = 0    //
                    }

                }).catch((error)=>{
                    console.error("tokenJackpot.hasNFTforRewards", error)
                })
              }
              else {
//               state.Jackpot.status = 0          //
              }
            })

            state.contracts.tokenJackpot.methods.getAllPurchableRewardInfo()
            .call().then((ret)=>{
              let length = ret.index.length;
              state.Jackpot.nftCount = length;
              for (let i=0; i<length; i++) {
                if (state.Jackpot.currentUserCount >= ret.count[i])
                  state.Jackpot.rewardsCount[ret.index[i]] = 0
                else {
                  state.Jackpot.rewardsCount[ret.index[i]] = ret.count[i] - state.Jackpot.currentUserCount
                  state.Jackpot.rewardPool[i] = ret.index[i];
                }

                state.Jackpot.nftName[ret.index[i]] = ret.name[i]
              }
            })
        },
        read_diamond(state) {
          if(state.account)
          {
            state.contracts.tokenLP[0].methods.balanceOf(state.account.address)
            .call().then((ret)=>{
              state.diamond.balanceLP0 = BigNumber(ret);
            })

            state.contracts.tokenLP[0].methods.allowance(state.account.address, ADDR_TOKEN_DIAMOND)
            .call().then((ret)=>{
              if (ret > 0) {
                state.approvedDiamond0 = true
              }
              else {
                state.approvedDiamond0 = false
              }
            }).catch((error)=>{
              console.error("tokenLP.allowance",error)
            });

            state.contracts.tokenDiamond.methods
            .mapTokenDay_MemberUnits(ADDR_LP_FTM_DIAMOND, state.diamond.currentDay, state.account.address)
            .call().then((ret)=>{
              state.diamond.userSentLP = BigNumber(ret);
            });

            /*
            state.contracts.tokenLP[1].methods.balanceOf(state.account.address)
            .call().then((ret)=>{
              state.diamond.balanceLP1 = BigNumber(ret);
            })

            state.contracts.tokenLP[1].methods.allowance(state.account.address, ADDR_TOKEN_DIAMOND)
            .call().then((ret)=>{
              if (ret > 0) {
                state.approvedDiamond1 = true
              }
              else {
                state.approvedDiamond1 = false
              }
            }).catch((error)=>{
              console.error("tokenLP.allowance",error)
            });

            state.contracts.tokenDiamond.methods
            .mapTokenDay_MemberUnits(ADDR_LPTOKEN_2, state.diamond.currentDay, state.account.address)
            .call().then((ret)=>{
              state.contracts.userSentLP = BigNumber(ret);
            });
            */
          }

          state.contracts.tokenDiamond.methods.currentDay().call().then((ret)=>{
            if (ret > 0)
            {
              state.diamond.currentDay = ret;
  
              state.contracts.tokenDiamond.methods.nextDay()
              .call().then((ret)=>{
                state.contracts.tokenDiamond.methods.lockedPeriod()
                .call().then((ret1)=>{
                  state.diamond.startTime = (ret - ret1) * 1000;
                  state.diamond.nextDay = ret * 1000;
                })
              })
  
              state.contracts.tokenDiamond.methods.getLPTokensBurntAtCurrentDay()
              .call().then((ret)=>{
                state.diamond.totalLPTokens = BigNumber(ret);
              })
  
              state.contracts.tokenDiamond.methods.getMembersAtCurrentDay()
              .call().then((ret)=>{
                state.diamond.totalMember = BigNumber(ret);
              })
  
              state.contracts.tokenDiamond.methods.getEmissionsAtCurrentDay()
              .call().then((ret)=>{
                state.diamond.totalEmission = BigNumber(ret);
              })
            }
          })
        },
        read_reward(state) {
          if(state.account)
          {
            state.contracts.tokenFantoonNFT.methods.withdrawnFTM(state.account.address)
            .call().then(ret=>{
                state.reward.withdrawnFTMfromNFT = BigNumber(ret)
            }).catch((error)=>{
                console.error("tokenFantoonNFT.withdrawnFTM", error)
            })
            
            state.contracts.tokenFantoonNFT.methods.withdrawableFTM(state.account.address)
            .call().then(ret=>{
                state.reward.withdrawableFTMfromNFT = BigNumber(ret)
            }).catch((error)=>{
                console.error("tokenFantoonNFT.withdrawableFTM", error)
            })

            state.contracts.tokenDiamond.methods.withdrawnDividendOf(state.account.address, false)
            .call().then(ret=>{
                state.reward.withdrawnFTMfromJackpot = BigNumber(ret)
            }).catch((error)=>{
                console.error("tokenDiamond.withdrawnDividendOf", error)
            })
            
            state.contracts.tokenDiamond.methods.withdrawableDividendOf(state.account.address, false)
            .call().then(ret=>{
                state.reward.withdrawableFTMfromJackpot = BigNumber(ret)
            }).catch((error)=>{
                console.error("tokenDiamond.withdrawableDividendOf", error)
            })
          }
        },
        read_liquiditygenerator(state) {
          state.contracts.tokenDistributor.methods.totalShares().call().then((ret)=>{
            state.liquiditygenerator.totalFTMShares = BigNumber(ret);
            state.contracts.tokenDistributor.methods.vestingAmount().call().then((ret)=>{
              let amount = BigNumber(ret);
              state.liquiditygenerator.normalVestingDiamond = amount;
              state.liquiditygenerator.diamondPriceInLGE = state.liquiditygenerator.totalFTMShares
                                     / state.liquiditygenerator.normalVestingDiamond;
            }).catch((error)=>{
              console.error("tokenDistributor.vestingAmount",error)
            })
          }).catch((error)=>{
            console.error("tokenDistributor.totalShares",error)
          })
    
          state.contracts.tokenDistributor.methods.vestingBegin().call().then((ret)=>{
            state.liquiditygenerator.vestingBegin = BigNumber(ret * 1000);
          }).catch((error)=>{
            console.error("tokenDistributor.vestingBegin",error)
          })
    
          state.contracts.tokenDistributor.methods.vestingEnd().call().then((ret)=>{
            state.liquiditygenerator.vestingEnd = ret * 1000;
          }).catch((error)=>{
            console.error("tokenDistributor.vestingEnd",error)
          })
    
          state.contracts.tokenLiquidityGenerator.methods.periodBegin().call().then((ret)=>{
            state.liquiditygenerator.periodBegin = ret * 1000;
          }).catch((error)=>{
            console.error("tokenLiquidityGenerator.periodBegin",error)
          })
    
          state.contracts.tokenLiquidityGenerator.methods.periodEnd().call().then((ret)=>{
            state.liquiditygenerator.periodEnd = ret * 1000;
          }).catch((error)=>{
            console.error("tokenLiquidityGenerator.periodEnd",error)
          })
    
          if(state.account)
          {
            let addr = state.account.address
            state.contracts.tokenDistributor.methods.recipients(addr).call().then((ret)=>{
              state.liquiditygenerator.RecipientInfo = ret;
            }).catch((error)=>{
              console.error("tokenDistributor.recipients",error)
            })
    
            state.contracts.tokenDistributor.methods.updateCredit(addr).call().then((ret)=>{
              state.liquiditygenerator.ClaimableRewards = BigNumber(ret);
            }).catch((error)=>{
              console.error("tokenDistributor.updateCredit",error)
            })
          }
        },
        read_diamondExchanger(state) {
          state.contracts.tokenDiamondExchanger.methods.getBalanceOfDiamond().call().then((ret)=>{
            state.diamondExchanger.remainingDiamond = BigNumber(ret);
          }).catch((error)=>{
            console.error("tokenDiamondExchanger.getBalanceOfDiamond",error)
          })

          state.contracts.tokenDiamondExchanger.methods.price().call().then((ret)=>{
            state.diamondExchanger.diamondPrice = BigNumber(ret);
          }).catch((error)=>{
            console.error("tokenDiamondExchanger.price",error)
          })

          state.contracts.tokenDiamondExchanger.methods.MAX_FTM_DEPOSIT().call().then((ret)=>{
            state.diamondExchanger.maxFTM = BigNumber(ret);
          }).catch((error)=>{
            console.error("tokenDiamondExchanger.MAX_FTM_DEPOSIT",error)
          })

          state.contracts.tokenDiamondExchanger.methods.MIN_FTM_DEPOSIT().call().then((ret)=>{
            state.diamondExchanger.minFTM = BigNumber(ret);
          }).catch((error)=>{
            console.error("tokenDiamondExchanger.MIN_FTM_DEPOSIT",error)
          })
    
          if(state.account)
          {
            let addr = state.account.address
            state.contracts.tokenDiamondExchanger.methods.userDepositFTM(addr).call().then((ret)=>{
              state.diamondExchanger.userFTM = BigNumber(ret);
            }).catch((error)=>{
              console.error("tokenDiamondExchanger.userDepositFTM",error)
            })

            state.contracts.tokenDiamondExchanger.methods.userClaimedDiamond(addr).call().then((ret)=>{
              state.diamondExchanger.userDiamond = BigNumber(ret);
            }).catch((error)=>{
              console.error("tokenDiamondExchanger.userClaimedDiamond",error)
            })
          }
        },
        read_masterchef(state) {
          state.contracts.tokenMasterchef.methods.poolLength().call().then(ret=>{
            if(ret>0) {
              state.contracts.tokenLP[0].methods.balanceOf(ADDR_DIAMOND_MASTERCHEF)
              .call().then(ret=>{
                state.farming.totalSupply[0] = BigNumber(ret);
                state.farming.totalStaked = BigNumber(ret);
              })
            }
          })

          state.contracts.tokenLP[0].methods.getReserves()
          .call().then((ret)=>{
            state.liquidity.amountDiamond = BigNumber(ret[1]);
            state.liquidity.amountFTM = BigNumber(ret[0]);
          })

          state.contracts.tokenMasterchef.methods.getTotalDiamondRewardFromBlock()
          .call().then((ret)=>{
            state.farming.totalEarning[0] = BigNumber(ret);
            state.farming.totalDiamondRewards = BigNumber(ret);
          })

          // Get daily rewards
          state.contracts.tokenMasterchef.methods.diamondPerBlock()
          .call().then((ret)=>{
            console.log("rewardperblock : ", ret)
            state.farming.dailyReward = BigNumber(ret).times(86400);
          })

          // Get prices of tokens
          let unit = BigNumber(1).shiftedBy(18).toString()
          state.contracts.tokenSpiritSwapRouter.methods.getAmountsOut(unit, [ADDR_TOKEN_DIAMOND, ADDR_FTM])
          .call().then((ret)=>{
            state.contracts.tokenPriceOracleProxy.methods.getLatestPrice()
            .call().then(ret1=>{
              state.price.FTM = BigNumber(ret1).shiftedBy(-8);
              state.price.Diamond = BigNumber(state.price.FTM)
              .times(BigNumber(ret[1]).shiftedBy(-18));

              // Get price of Diamond/FTM LP pair
                var pair = new window.web3.eth.Contract(abiSpiritSwapPair, ADDR_LP_FTM_DIAMOND);
                pair.methods.getReserves().call().then((ret)=>{
                  var diamondReserve = BigNumber(ret._reserve1);
                  var ftmReserve = BigNumber(ret._reserve0);
                  var lpTotalSupply;
                  pair.methods.totalSupply().call().then((ret)=>{
                    lpTotalSupply = BigNumber(ret);
                    state.price.LP_FTM_Diamond = BigNumber(ftmReserve)
                      .times(BigNumber(state.price.FTM))
                      .plus(BigNumber(diamondReserve).times(state.price.Diamond))
                      .div(BigNumber(lpTotalSupply));
                  })
                })
            }).catch((error)=>{
                console.error("tokenSpiritSwapRouter.getAmountsOut", error)
            })
          })

          if(state.account) {
            state.contracts.tokenLP[0].methods.balanceOf(state.account.address)
            .call().then(ret=>{
              state.liquidity.balance = BigNumber(ret);
            })
    
            // For LP token of FTM/Diamond
            state.contracts.tokenMasterchef.methods.userInfo(0, state.account.address)
            .call().then(userinfo=>{
              state.farming.balance[0] = userinfo.amount;
              state.farming.earnedToken[0] = BigNumber(userinfo.totalEarnedDiamond);
            })

            state.contracts.tokenMasterchef.methods.getDepositInfo(0, state.account.address)
            .call().then(ret=>{
              state.farming.depositInfo = ret;
            })
    
            state.contracts.tokenMasterchef.methods
            .pendingDiamondForDeposit(0,state.account.address, -1)
            .call().then(ret=>{
              state.farming.pendingDiamond[0] = BigNumber(ret[0]);
              state.farming.claimableDiamond[0] = BigNumber(ret[1]);
            })
          }
        },
        read_fantoonnft(state) {
          state.contracts.tokenFantoonNFT.methods.totalSupply().call().then((ret)=>{
              state.fantoonnft.totalSupply = Number(ret);
              }).catch((error)=>{
              console.error("tokenFantoonNFT.totalSupply",error)
          });

          state.contracts.tokenFantoonNFT.methods.isReservePeriod().call().then((ret)=>{
            if (ret) {
              if (state.account != null) {
                state.contracts.tokenFantoonNFT.methods.getReservedTokenPrice(state.account.address).call().then((ret)=>{
                  state.fantoonnft.price = BigNumber(ret);
                }).catch((error)=>{
                  console.error("tokenFantoonNFT.getReservedTokenPrice",error)
                });
              }
              else
                state.fantoonnft.price = BigNumber(0);
            }
            else {
              state.contracts.tokenFantoonNFT.methods.getPrice().call().then((ret)=>{
                state.fantoonnft.price = BigNumber(ret);
              }).catch((error)=>{
                console.error("tokenFantoonNFT.getPrice",error)
              });
            }
          }).catch((error)=>{
            console.error("tokenFantoonNFT.isReservePeriod",error)
          });
        },
    },
    actions: {
      claimJackpot({state, commit}) {
        if (state.account == null) {
          commit('show_warning','Please Connect MetaMask')
          return;
        }

        state.contracts.tokenJackpot.methods.userInfo(state.account.address)
        .call().then((ret)=>{
          if (ret.purchasedIndex > 0) {
            state.contracts.tokenJackpot.methods.claim()
            .send({from:state.account.address})
            .then(()=>{
              state.Jackpot.status = 0    // init
              commit('show_success','Your prize has been claimed successfully!')
              commit('read_jackpot');
            }).catch((error)=>{
              console.error("tokenJackpot.claim",error)
            })             
          }            
        })
      },
      getPurchedInfo({state}) {
        state.contracts.tokenJackpot.methods.getPurchaedInfo(true)
          .call()
          .then((ret)=>{
            state.Jackpot.rewards = ret.rewards
        }).catch((error)=>{
          console.error("tokenJackpot.getPurchaedInfo",error)
        })
      },
      buyTicket({state, commit}) {
        window.web3.eth.getBalance(ADDR_JACKPOT).then(ret=>{
          if (ret == 0) {
            state.contracts.tokenJackpot.methods.hasNFTforRewards()
            .call().then(ret=>{
                if (ret == 0) {
                  commit('show_warning','Sorry, No More NFT and Token for Reward')
                  state.Jackpot.status = 5    // No reward
                  return;
                }
            }).catch((error)=>{
                console.error("tokenJackpot.hasNFTforRewards", error)
            })
          }
          else {
            state.Jackpot.status = 4;   // start spin
            this.dispatch("procBuyTicket");
          }
        })
      },
      procBuyTicket({state, commit}) {
/*
        state.contracts.tokenJackpot.methods.buyTicket()
        .estimateGas().then(ret=>{
            console.log(ret)
        }).catch((error)=>{
            console.error("tokenJackpot.buyTicket.estimateGas", error)
        })
/*
        state.contracts.tokenJackpot.methods.buyTicket().estimateGas()
        .then(function(gasAmount){
          console.log(gasAmount)
        })
        .catch(function(error){
          console.log(error)
        });
*/
        state.contracts.tokenJackpot.methods.buyTicket()
        .send({
            from:state.account.address,
            value:BigNumber(state.Jackpot.cost).integerValue().toString(),
            gas: 1000000
        })
        .then(()=>{
          state.Jackpot.startGegeneratedNumber = true;
          state.contracts.tokenJackpot.methods.userInfo(state.account.address)
            .call().then((ret)=>{
              if (ret.status == 1 || ret.status == 2)  {   // won but no rewards   
                state.Jackpot.rewardsCount[1] = 0
              }
              else {
                state.Jackpot.rewardsCount[1] = 1
              }

              setTimeout(() => {
                if (ret.winnedByNFT) {
                  state.contracts.tokenJackpot.methods.purchasedInfo(Number(ret.purchasedIndex)-1)
                  .call().then((ret)=>{
                    var pool = ret.pool;
                    state.contracts.tokenJackpot.methods.nftInfo(ret.pool)
                    .call().then((ret)=>{
                      state.Jackpot.userRewardNFT = ret.name;
                    }).catch((error)=>{
                      console.error("tokenJackpot.nftInfo",error)
                    })
                  }).catch((error)=>{
                    console.error("tokenJackpot.purchasedInfo",error)
                  })

                  state.Jackpot.status = 1;     // win NFT
                }
                else if (ret.winnedByRewardToken) {
                  state.contracts.tokenJackpot.methods.purchasedInfo(Number(ret.purchasedIndex)-1)
                  .call().then((ret)=>{
                    var prizeAmount = ret.rewardTokenAmount;
                    state.Jackpot.userRewardToken = prizeAmount;
                  }).catch((error)=>{
                    console.error("tokenJackpot.purchasedInfo",error)
                  })

                  state.Jackpot.status = 100;   // win Reward Token
                }
                else {
                  if (ret.status == 1)
                    state.Jackpot.status = 200;   // win but no reward token
                  else if (ret.status == 2)
                    state.Jackpot.status = 2;     // win but no reward NFT
                  else
                    state.Jackpot.status = 3;     // no win
                }
              }, 2000);

//            commit('read_jackpot');
              state.Jackpot.generatedNumber = ret.ticketNumber;
          })
        }).catch((error)=>{
            state.Jackpot.status = 0;
        })
      },
      approveDiamond({state, commit}, params) {
        let lpTokenContract;
        lpTokenContract = state.contracts.tokenLP[params.tokenIndex];
        lpTokenContract.methods.approve(
          ADDR_TOKEN_DIAMOND,
          UINT256_MAX
        ).send({
          from: state.account.address
        }).then(()=>{
          if (params.tokenIndex == 0)
            state.approvedDiamond0 = true
          else if (params.tokenIndex == 1)
            state.approvedDiamond1 = true

          commit('show_success','Approved tokens successfully!')
        })
      },
      approvePairMaster({state}) {
        state.contracts.tokenLP[0].methods.approve(
          ADDR_DIAMOND_MASTERCHEF,
          UINT256_MAX
        ).send({
          from: state.account.address
        }).then(()=>{
          state.approvedDiamondPairMaster = true;
        })
      },
      sendToken({state,commit},params) {
        let tokenAddress = null;
        state.contracts.tokenDiamond.methods.arrLpTokens(params.tokenIndex)
        .call().then((ret)=>{
          tokenAddress = ret;
          state.contracts.tokenDiamond.methods.sendLPtoken(
            tokenAddress,
            BigNumber(params.amount).shiftedBy(18).integerValue().toString()
          ).send({
            from: state.account.address
          }).then(()=>{
              this.dispatch("getDiamondRewards", params);
              commit("read_diamond")
              commit('show_success','Sent your LP tokens successfully!')
          })
        })
      },
      isRegisteredToken({state}, params) {
        let tokenAddress;
        state.contracts.tokenDiamond.methods.arrLpTokens(params.tokenIndex)
        .call().then((ret)=>{
          tokenAddress = ret;

          state.contracts.tokenDiamond.methods.isRegisteredLPToken(tokenAddress)
          .call().then((ret)=>{
            return ret;
          })           
        })
      },
      getDiamondRewards({state}, params) {
        let tokenAddress, totalUnit, currentEmission;
        state.contracts.tokenDiamond.methods.arrLpTokens(params.tokenIndex)
        .call().then((ret)=>{
          tokenAddress = ret;
          state.contracts.tokenDiamond.methods.mapTokenDay_Units(tokenAddress, state.diamond.currentDay)
          .call().then((ret)=>{
            totalUnit = BigNumber(ret);
            state.contracts.tokenDiamond.methods.mapTokenDay_Emission(tokenAddress, state.diamond.currentDay)
            .call().then((ret)=>{
              currentEmission = BigNumber(ret)
              state.diamond.currentPossibleRewards = 
                (currentEmission.multipliedBy(BigNumber(params.amount).shiftedBy(18))).
                  dividedBy(totalUnit.plus(BigNumber(params.amount).shiftedBy(18)));
            })  
          })           
        })
      },
      pendingDiamondRewards({state}, params) {
        let tokenAddress;
        state.contracts.tokenDiamond.methods.arrLpTokens(params.tokenIndex)
        .call().then((ret)=>{
          tokenAddress = ret;
          state.contracts.tokenDiamond.methods.pendingRewards(state.account.address, tokenAddress)
          .call().then((ret)=>{
            state.diamond.pendingDiamond = BigNumber(ret);
          })
        })
      },
      withdraw({state, commit}, params) {
        let tokenAddress;
        state.contracts.tokenDiamond.methods.arrLpTokens(params.tokenIndex)
        .call().then((ret)=>{
          tokenAddress = ret;
          state.contracts.tokenDiamond.methods.withdrawShare(tokenAddress)
          .send({
            from: state.account.address
          }).then((ret)=>{
              this.dispatch("pendingDiamondRewards", params);
              commit("read_diamond")
              commit('show_success','Claimed successfully.')
          })          
        })
      },
      contractLink() {
        const url = 'https://ftmscan.com/address/' + ADDR_LIQUIDITY_GENERATOR
        window.open(url, '_blank')
      },
      depositFTM({state,commit}, params) {
        state.contracts.tokenLiquidityGenerator.methods.deposit(
        ).send({
          from: state.account.address,
          value:BigNumber(params.amount).shiftedBy(18).integerValue().toString()
        }).then(()=>{
          commit('show_success', 'Success!');
          commit('read_liquiditygenerator');
        })
      },
      claimDiamond({state,commit}) {
        state.contracts.tokenDistributor.methods.calculateCredit(
          state.account.address
        ).call().then(ret=>{
          if(ret > 0) {
            state.contracts.tokenDistributor.methods.claim().send({
              from: state.account.address

            }).then(()=>{
              commit('show_success', 'Success!')
              commit('read_liquiditygenerator');
            })
          } else {
            commit('show_warning','Cannot Claim! Current Balance is Zero.')
          }
        })
      },
      depositFTMinDiamondExchanger({state,commit}, params) {
        state.contracts.tokenDiamondExchanger.methods.deposit(
        ).send({
          from: state.account.address,
          value:BigNumber(params.amount).shiftedBy(18).integerValue().toString()
        }).then(()=>{
          commit('show_success', 'Success!');
          commit('read_diamondExchanger');
        })
      },
      claimFTMfromJackpot({state,commit}) {
        state.contracts.tokenDiamond.methods.claim().send({
          from: state.account.address
        }).then(()=>{
          commit('show_success', 'Claimed successfully.!');
          commit('read_reward');
        })
      },
      claimFTMfromNFT({state,commit}) {
        state.contracts.tokenFantoonNFT.methods.claimFTM().send({
          from: state.account.address
        }).then(()=>{
          commit('show_success', 'Claimed successfully.!');
          commit('read_reward');
        })
      },
      connect({state, commit}, params) {
        const account = {
          address: params.address,
        }

        if (params.provider.isWalletConnect) {
          window.web3 = new Web3(params.provider);
  
          commit('init');

          setInterval(()=>{
            commit('read_diamond')
            commit('read_masterchef')
            commit('read_reward')
            commit('read_liquiditygenerator')
            commit('read_fantoonnft')
//          store.commit('read_diamondExchanger')
          },30000)
        }

        commit('set_account',account)
        commit('check_approve', account);
        commit('read_diamond')
        commit('read_masterchef')
        commit('read_jackpot')
        commit('read_reward')
        commit('read_liquiditygenerator')
        commit('read_fantoonnft')
//      commit('read_diamondExchanger')
      },
      disconnect({state}) {
          state.account = null
      },
      mint({state,commit},params) {
        if (state.account==null) {
          commit('show_warning', 'Please connect Wallet!');
          return;         
        }

        if (state.fantoonnft.totalSupply == MAXIMUM_MINT_TOKEN) {
          commit('show_warning', 'No More Tokens!');
          return;
        }

        if (state.fantoonnft.price == 0) {
          commit('show_warning', 'You can not mint now!');
          return;
        }

        state.contracts.tokenFantoonNFT.methods.getTokenCount().call({
          from: state.account.address
        }).then((ret)=>{
          if (ret == MAXIMUM_MINT_TOKEN_COUNT_FOR_ACCOUNT) {
            commit('show_warning', 'Too Many Tokens At Your Wallet!');
            return;
          }

          state.contracts.tokenFantoonNFT.methods.buyKittens().send({
            from: state.account.address,
            value:BigNumber(state.fantoonnft.price).integerValue().toString()
          }).then(()=>{
            commit('show_success', 'Minted NFT Successfully!');
            commit('read_fantoonnft');
            commit('read_reward');
          })

        }).catch((error)=>{
          console.error("getTokenCount()",error)
        });
      },
      async getTokenIdsOfOwner({state, commit},params) {
        if (state.account==null) {
            commit('show_warning', 'Please connect Wallet!');
            return false;         
        }
  
        if (!window.web3.utils.isAddress(params.account)) {
            commit('show_warning', 'Address Error11!');
            return false;
        }
  
        await state.contracts.tokenFantoonNFT.methods.getTokenIdsOfOwner(params.account).call({
            from: state.account.address
        }).then((ret)=>{
            state.fantoonnft.tokenIds = ret[0];
            state.fantoonnft.tokenPrices = ret[1];
            state.fantoonnft.tokenURIs = ret[2];

            return true;
        })
  
        return true;
      },
      async constructTokenInfo({state,commit}) {
          let nlength = state.fantoonnft.tokenURIs.length;
  
          if (nlength == 0) {
              state.fantoonnft.searchResult = false;
              commit('show_warning', 'No Result!');
  
              return;
          }
  
          let imageURLs = [];
          let tokenNames = [];
          let tokenAttributes = [];
  
          for(let i = 0;i<nlength;i++) {
              await axios.get(state.fantoonnft.tokenURIs[i], {
                  }).then(x => {console.log(x.data.image)
                      imageURLs.push(x.data.image);
                      tokenNames.push(x.data.name);
                  })
          }
  
          state.fantoonnft.imageURIs = imageURLs;
          state.fantoonnft.tokenNames = tokenNames;
          
          state.fantoonnft.searchResult = true;
      },
      async transferToken({state,commit}, params) {
        if (!window.web3.utils.isAddress(params.to)) {
            commit('show_warning', 'Address Error!');
            return false;
        }
  
        if (params.from == params.to) {
            commit('show_warning', 'Recipient Address can not be the same as the Spender Address!');
            return false;
        }
  
        state.contracts.tokenFantoonNFT.methods.ownerOf(params.tokenID).call().then((ret)=>{
          if (String(ret).toLowerCase() != String(state.account.address).toLowerCase()) {
            commit('show_warning', 'You are not the owner of this token!');
            return false;           
          }
          else {
            state.contracts.tokenFantoonNFT.methods.safeTransferFrom(params.from, params.to, params.tokenID)
            .send({
                from: state.account.address
              }).then(()=>{
                commit('show_success', 'Success!');

                state.contracts.tokenFantoonNFT.methods.getTokenIdsOfOwner(params.from).call({
                  from: state.account.address
                }).then((ret)=>{
                    state.fantoonnft.tokenIds = ret[0];
                    state.fantoonnft.tokenPrices = ret[1];
                    state.fantoonnft.tokenURIs = ret[2];
                })
            })
          }
        }).catch((error)=>{
          console.error("FantoonNFT.ownerOf",error)
        });
      },
      deposit({state,commit/*,dispatch*/},params) {
        if (params.amount == null) {
          commit('show_warning','Wrong token amount.');
          return;
        }

        state.contracts.tokenMasterchef.methods.deposit(
          params.index,
          BigNumber(params.amount).shiftedBy(18).integerValue().toString()
        ).send({
          from: state.account.address
        }).then(()=>{
            commit("read_masterchef");
        })
      },
      withdrawLPs({state,commit},params) {
        if (params.amount == null) {
          commit('show_warning','Wrong token amount.');
          return;
        }

        state.contracts.tokenMasterchef.methods.availableForWithdraw(
          state.account.address, params.index
        ).call().then(ret=>{
          if(BigNumber(ret).isGreaterThan(0)) {
            state.contracts.tokenMasterchef.methods.withdraw(
              params.index,
              BigNumber(params.amount).shiftedBy(18).integerValue().toString()
            ).send({
              from: state.account.address
            }).then(()=>{
                commit("read_masterchef");
            })
          } else {
            commit('show_warning','No withdrawable Tokens.');
          }
        })
      },
      harvest({state,commit},params) {
        return new Promise((resolve)=>{
          state.contracts.tokenMasterchef.methods.canHarvest(
            params.pid, state.account.address
          ).call().then(ret=>{
            if(ret) {     // LP Farming
                state.contracts.tokenMasterchef.methods.harvestForDeposit(params.pid, params.depositIndex)
                  .send({
                    from: state.account.address
                  }).then((ret)=>{
                    commit("read_masterchef");
                    resolve(ret);
                })
            } else {
              commit('show_warning','Cannot harvest! Still locked.');
              resolve(ret);
            }
          })
        })
      },
      getDepositExtraInfo ({state},pid) {      
        return new Promise((resolve)=>{
          state.contracts.tokenMasterchef.methods.getDepositInfo(pid, state.account.address).call().then(ret=>{
            state.farming.depositInfo = ret;
            state.contracts.tokenMasterchef.methods.getTaxInfo(pid, state.account.address).call().then(ret=>{
              state.farming.taxInfo = ret;
              state.contracts.tokenMasterchef.methods.getEarnedTokenInfo(pid, state.account.address).call().then(ret=>{
                state.farming.earnedTokenInfo = ret[0];
                state.farming.claimableTokenInfo = ret[1];
                resolve(ret);
              })
            })
          })
        });
      },
    },
  })
  