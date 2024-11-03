<template>
    <header id="myDiv">
        <div class="container">
            <notification v-if="hasMessage"/>
            <div class="row align-items-center">
                <div class="col-9 col-lg-3">
                    <router-link to="/" class="pressdave"></router-link>
                </div>
                <div class="col-3 d-block d-lg-none flex">
                    <div class="menuBtn">
                        <a @click="opennoegg()" id="menuBtn"></a>
                    </div>
                </div>
                <nav v-if="isMobile" id="" class="menuBar text-right">
                    <router-link to="/">
                        <div @click="opennoegg()">
                          Home
                        </div>
                    </router-link>
                     <router-link to="/jackpot">
                        <div @click="opennoegg()">
                           🔥 Jackpot
                        </div>
                    </router-link><!--
                    <router-link to="/diamond-reserve">
                        <div @click="opennoegg()">
                            ❖ Diamond Reserve
                        </div>
                    </router-link>-->
                    <router-link to="/farm">
                        <div @click="opennoegg()">
                            ❖ Farm
                        </div>
                    </router-link>
                    <!--
                    <router-link to="/lge">
                        <div @click="opennoegg()">
                            ✧ LGE
                        </div>
                    </router-link>-->
                    <router-link to="/mexitails">
                        <div @click="opennoegg()">
                            Mexitails
                        </div>
                    </router-link>
                   <!--
                    <router-link to="/private">
                        <div @click="opennoegg()">
                            Private
                        </div>
                    </router-link>-->
                    <router-link to="/reward">
                        <div @click="opennoegg()">
                            <img :src="require(`@/assets/diamond.png`)" class="avatar_menu" />
                            Claim
                        </div>
                    </router-link><!--
                    <a href="https://twitter.com/pumpkittens" @click="opennoegg()">Help</a>-->
                    <div v-if="!isMetaMaskConnected" 
                        @click="connectWallet" class="btn wallet"> <i class="moneyBag"></i> 
                        Connect wallet</div>
                    <div v-if="isMetaMaskConnected" 
                        @click="disconnect" class="btn wallet"> <i class="moneyBag"></i> 
                        {{showWallet(this.account)}} </div>
                </nav>
                <nav v-if="!isMobile" id="" class="col-lg-9 menuBar text-right">
                    <router-link to="/">
                        <div @click="opennoegg()">
                          Home
                        </div>
                    </router-link>
                     <router-link to="/jackpot">
                        <div @click="opennoegg()">
                           🔥 Jackpot
                        </div>
                    </router-link><!--
                    <router-link to="/diamond-reserve">
                        <div @click="opennoegg()">
                            ❖ Diamond Reserve
                        </div>
                    </router-link>-->
                    <router-link to="/farm">
                        <div @click="opennoegg()">
                            ❖ Farm
                        </div>
                    </router-link>
                    <!--
                    <router-link to="/lge">
                        <div @click="opennoegg()">
                            ✧ LGE
                        </div>
                    </router-link>-->
                    <router-link to="/mexitails">
                        <div @click="opennoegg()">
                            Mexitails
                        </div>
                    </router-link>
                   <!--
                    <router-link to="/private">
                        <div @click="opennoegg()">
                            Private
                        </div>
                    </router-link>-->
                    <router-link to="/reward">
                        <div @click="opennoegg()">
                            <img :src="require(`@/assets/diamond.png`)" class="avatar_menu" />
                            Claim
                        </div>
                    </router-link><!--
                    <a href="https://twitter.com/pumpkittens" @click="opennoegg()">Help</a>-->
                    <div v-if="!isMetaMaskConnected" 
                        @click="connectWallet" class="btn wallet"> <i class="moneyBag"></i> 
                        Connect wallet</div>
                    <div v-if="isMetaMaskConnected" 
                        @click="disconnect" class="btn wallet"> <i class="moneyBag"></i> 
                        {{showWallet(this.account)}} </div>
                </nav>
            </div>
            <ConnectComponent @error="onError" @response="onResponse" v-model="show" />
        </div>
    </header>
</template>
<script>
    import Notification from '../components/notification.vue';
    import ConnectComponent from "./ConnectComponent.vue";
    export default {
        components: {
            Notification, ConnectComponent
        },
        data () {
            return {
                show:false,
                provider: null,
                account: null,
                chainId: null,
            }
        },
        mounted () {
            this.setHeaderColor(this.routename)
        },
        computed: {
            routename () {
                return this.$route.name
            },
            isMetaMaskInstalled() {
                const { ethereum } = window;
                return Boolean(ethereum && ethereum.isMetaMask)
            },
            isMetaMaskConnected() {
                return this.$store.state.account != null;
            },
            hasMessage() {
                return this.$store.state.messageContent!=null
            },
            isMobile() {
                return this.$q.screen.width < 992;
            },
        },
        watch: {
            routename : function (n, o) {
                if (n !== o) {
                    this.setHeaderColor(n)
                }
            }
        },
        methods: {
            opennoegg() {
                if (!this.isMobile)
                    return;

                const menu = document.getElementsByClassName("menuBar")[0].style.display
                if (menu === 'block') {
                    document.getElementsByClassName("menuBar")[0].style.display = 'none'
                } else {
                    document.getElementsByClassName("menuBar")[0].style.display = 'block'
                }
            },
            setHeaderColor () {
                if (this.isMobile) {
                    document.getElementById("myDiv").style.backgroundImage ="none"; 
                    if (this.routename === 'mexitails') {
                        document.getElementById("myDiv").style.backgroundColor = "";
                        document.body.style.background = "linear-gradient(97deg,  rgba(251,127,61,1) 0%,rgba(253,150,42,1) 100%)";
                    }
                    else {
                        if (!(this.routename === 'jackpot' || this.routename === 'winnerboard'))     
                            document.getElementById("myDiv").style.backgroundColor = "#eefdfe";      
                        else {
                            document.body.style.background = "linear-gradient(to right, #ff1900, #ff5900, #f44336, #f44336db, #ff9800, #ffc100, #ffc100, rgb(255 152 0), #ef5448, #da3e52, #ff044c, #f94126)";
                            document.getElementById("myDiv").style.backgroundColor = "";
                        }
                    }
                }
                else {
                    document.getElementById("myDiv").style.backgroundImage ="../images/nav-bg-3.png";
                    if (this.routename === 'mexitails') {
                        document.body.style.background = "linear-gradient(91deg,  rgba(248,83,96,1) 0%,rgba(253,150,42,1) 100%)";
                        document.getElementById("myDiv").style.backgroundColor = "";
                    }
                    else {
                        if (!(this.routename === 'jackpot' || this.routename === 'winnerboard'))    { 
                            document.getElementById("myDiv").style.backgroundColor = "#eefdfe";    
                        }  
                        else {
                            document.body.style.background = "linear-gradient(to right, #ff1900, #ff5900, #f44336, #f44336db, #ff9800, #ffc100, #ffc100, rgb(255 152 0), #ef5448, #da3e52, #ff044c, #f94126)";
                            document.getElementById("myDiv").style.backgroundColor = "";
                        }
                    }
                }
            },
            connectWallet() {                
                this.show = true;
                this.opennoegg();
            },
            showWallet(wallet) {
                return (
                    wallet.substring(0, 6) +
                    "..." +
                    wallet.substring(wallet.length - 5, wallet.length)
                );
            },
            onError(err) {
                console.debug({ err: err.message });
                console.error(err);
            },
            async onResponse({ provider, account, chainId }) {
                this.provider = provider;
                this.account = account;
                this.chainId = chainId;

                this.$store.dispatch("connect", {
                    address : this.account,
                    provider: this.provider
                })
            },
            disconnect() {
                this.provider && this.provider.close && this.provider.close();

                this.provider = null;
                this.account = null;
                this.chainId = null;

                if (window.localStorage.getItem("walletconnect")) {
                    window.localStorage.removeItem("walletconnect");
                }

                this.$store.dispatch("disconnect");
                this.opennoegg();
            },
        }
    }
</script>

<style>
    .avatar_menu {
        width:20px;
        height:20px;
    }

    .menuBtn {
        background:#000; 
        width:34px; 
        padding:3px; 
        border-radius:3px; 
        float:right; 
        margin-right:5px;
    }
</style>
