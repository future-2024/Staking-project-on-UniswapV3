<template>
    <div class="nft" id="nft">
      <section id="banner">
        <div class="container position-relative">
            <div class="row">
                <article class="col-12 col-lg-7">
                    <h1><strong>Welcome to MexiTails</strong><br />The First Project on Fantoon</h1>
                    <p class="">
                        The Aztec gods are back. 
                        After many centuries of watching humanity be disgraced, 
                        they decided to come to help humans in these desperate times with the help of the technology of the blockchain and the super speed of Fantom. 
                        This OG collection is based on 300 high-quality, handmade NFTs. Of these, 21 are ultra-rare MexiTail Gods.
                        <a href="https://discord.gg/Gj7JqN2mXZ" class="btn q-mt-sm">LEARN MORE</a>
                    </p>
                    <div class="row text-white mint q-ml-md" style="margin:0">
                        <div class="col-md-6 col-lg-7 text-center" >
                            <div>
                                <div class="q-ml-sm btn mint_btn fill q-mt-sm" @click="mint">
                                    <i></i> MINT YOURS NOW</div>
                            </div>
                            <div class="text-white q-mt-md">
                                price : {{nftPrice}} FTM
                            </div>
                        </div>
                        <div class="text-center col-md-6 col-lg-5 q-mt-md text-bold">
                            <h4>{{totalSupply}} / 300 Minted</h4>
                        </div>
                    </div>
                </article>
                <aside class="shapes col-12 col-lg-5 text-center q-mt-md">
                    <img :src="require(`@/assets/nft/images/phone.png`)" alt="" />
                </aside>
            </div>
        </div>
        </section>
        <section id="partnerShip">
            <div class="container">
                <div class="row">
                    <article class="col-12 col-lg-7">
                        <span class="handshake"></span>
                        <h2>About MexiTails</h2>
                        <p class="text-justify">The Aztec gods realized that Fantom was the option to make their next creation…The Mexican Tails! These beautiful creatures came to light to accompany you in your day-to-day life, giving hope and prosperity to Fantom. Each one is unique and has its peculiar characteristics. Each one will have a mission in this life by your side...always under the supervision of their gods.</p>
                        <div class="logoList">
                        </div>
                        <a href="https://discord.gg/UdAZh24R" class="btn">Learn More &rarr;</a>
                    </article>
                    <aside class="shapes col-12 col-lg-5 text-center">
                        <img :src="require(`@/assets/nft/images/tab.png`)" alt="" />
                    </aside>
                </div>
            </div>
        </section>
        <section id="features">
            <div class="shapes-container">
                <div class="shape shape-ring shape-ring-1">
                    <div class="animation animation--rotating"></div>
                </div>
                <div class="shape shape-ring shape-ring-2">
                    <div class="animation animation--rotating"></div>
                </div>
                <div class="shape shape-circle animation--clockwise">
                    <div></div>
                </div>
                <div class="shape background-shape-main"></div>
            </div>
            <div class="container">
                <div class="row">
                    <aside class="col-12 col-lg-6">
                      <div class="row">
                          <div class="col-12 col-md-6">
                              <div class="tab" style="min-height:250px;">
                                  <span style="max-height: 30px; max-width: 30px;"></span>
                                  <h3>From 14th April</h3>
                                  <p>Yes, that's when the minting of MexiTails begin.</p>
                              </div>
                              <div class="tab" style="min-height:250px;">
                                  <span style="max-height: 30px; max-width: 30px;"></span>
                                  <h3>300 Mexican Wonders</h3>
                                  <p>300 NFTs are available for you to collect.</p>
                              </div>
                          </div>
                          <div class="col-12 col-md-6">
                              <div class="tab" style="min-height:250px;">
                                  <span style="max-height: 30px; max-width: 30px;"></span>
                                  <h3>250 FTM per nft</h3>
                                  <p>Each NFTs cost 250 FTM, you can mint upto 5 NFTs.</p>
                              </div>
                              <div class="tab" style="min-height:250px;">
                                  <span style="max-height: 30px; max-width: 30px;"></span>
                                  <h3>Real MexiTails too</h3>
                                  <p>For each NFT, get a physical MexiTail too.</p>
                              </div>
                          </div>
                      </div>
                    </aside>
                    <article class="col-12 col-lg-6 q-mt-md">
                        <div class="small">A taste of Mexican culture for Fantom by Fantoon</div>
                        <h2>
                            These wonderful Mexican-themed NFTs are bringing a new experience to the Fantom NFT universe.<br />
                            <span class="hline"></span>
                        </h2>
                        <h3>The MexiTails were inspired by our graphic artist’s dog, Betito.</h3>
                        <p>He is a 21-year-old Chihuahua born in Puebla, Mexico. He loves chicken and going out. He is now an old man but a very lovely one.</p>
                        <div class="btn" @click="search">View MexiTails &rarr;</div>
                        <input type="text" prefix="" v-model="address" class="q-mt-sm address"
                            standout="bg-white text-white" placeholder="Wallet Address"
                            :bottom-slots="false" :hide-bottom-space="true" />
                    </article>
                    <div class = "row my-7 mx-0 text-white q-mt-lg" 
                        v-if="this.$store.state.fantoonnft.searchResult" 
                        style="width:100%">
                        <div class="col-lg-3 col-md-4 col-sm-12 pa-1 flex justify-center q-mt-lg" 
                            v-for="(imageURI,idx) in this.$store.state.fantoonnft.imageURIs"
                            :key="idx">
                            <div class="nft_card">
                                <div v-lazy-container="{ selector: 'img' }">
                                    <img class="mintedImage"
                                        :data-src="imageURI"
                                        :data-loading="loadimage"
                                        contain
                                    />
                                </div>
                                <div class="sub_panel text-justify text-center q-mt-sm">
                                    <div class = "tokenNames">{{showShortName(idx)}}</div>
                                    <div class = "tokenPrice">Price : {{tokenPrice(idx).toFormat(3)}} FTM</div>
                                    <div class="btn q-mt-sm" @click="showModal(idx)">Send</div>
                                </div>
                            </div>
                        </div>
                    </div>
              </div>
          </div>
        </section>
        <div v-if="showModalSend" class="modal">
            <div class="modal__content">
                <div class="model__content__item">
                    <div style="font-size: 1.5rem; color: #fff">Send Token</div>
                        <q-btn icon="close" flat round dense
                            @click="showModalSend = !showModalSend" color="white">
                    </q-btn>
                </div>
                <div class="model__content__item">
                    <q-input type="text" v-model="recipientAddress" placeholder="Address"
                    :bottom-slots="false" :hide-bottom-space="true" class="search">
                    </q-input>
                </div>
                <div class="model__content__item">
                    <button id="claim"
                        @click="send" class="btn">Send</button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import BigNumber from 'bignumber.js'
    export default {
        components: {/*SendDialog*/},
        data() {
            return {
                loadimage: require("@/assets/loading.gif"),
                banner: true,
                pending: false,
                error: false,
                dialog: true,
                address: null,
                showModalSend: false,
                recipientAddress: null,
                tokenId: null,
                transfered: false
            }
        },
        computed: {
            isMetaMaskConnected() {
                return this.$store.state.account != null;
            },
            nftPrice() {
                if(this.$store.state.account) {
                    return BigNumber(this.$store.state.fantoonnft.price).shiftedBy(-18);
                }

                return BigNumber(0);
            },
            totalSupply() {
                if(BigNumber(this.$store.state.fantoonnft.totalSupply).isNaN())
                    return Number(0);

                return Number(this.$store.state.fantoonnft.totalSupply);
            },
        },
        watch:{
            showModalSend:function(newValue){
                if(!newValue){
                    this.research();
                    this.transfered = false;
                }
            }
        },
        mounted() {
            this.$store.commit('read_fantoonnft');
        },
        methods: {
            connectWallet() {                
                this.$store.dispatch("connect")              
            },
            mint() {
                this.$store.dispatch('mint')
            },
            showModal(index) {
                this.showModalSend = true;
                this.tokenId = this.$store.state.fantoonnft.tokenIds[index];
            },
            send() {
                this.$store.dispatch('transferToken', 
                    {
                        from:this.address, 
                        to:this.recipientAddress, 
                        tokenID:this.tokenId
                    }
                )
                this.transfered = true;
            },
            showShortName(index) {
                let name = this.$store.state.fantoonnft.tokenNames[index];
                if (name.length < 20)
                    return '"' + name + '"'
                else
                    return (
                        '"' + name.substring(0, 10) +
                        '...' +
                        name.substring(name.length - 8, name.length) + '"'
                    );
            },
            tokenPrice(index) {
                return BigNumber(this.$store.state.fantoonnft.tokenPrices[index]).shiftedBy(-18);
            },
            searchAccount() {
                return this.address;
            },
            tokenAttributes(index) {
                return this.$store.state.fantoonnft.tokenAttributes[index];
            },
            async search() {
                this.pending = true;
                try {
                    let result;
                    result = await this.$store.dispatch('getTokenIdsOfOwner', {
                        account:this.address
                    })

                    if (!result) {
                        this.pending = false;
                        this.error = true;
                        return;
                    }

                    await this.$store.dispatch('constructTokenInfo')

                    this.error = false;
                }
                catch (e) {
                    this.error = e;
                }
                this.pending = false;
            },
            async research() {
                if (this.transfered)
                {
                    try {
                        await this.$store.dispatch('constructTokenInfo')
                    }
                    catch (e) {
                        this.error = e;
                    }
                }
            }
        }
    }
</script>

<style>
    .nft {
        background-size:cover;
        color:#000 !important;
    }

    .nft_card {
            width: 200px; 
            height: 280px;
            padding:8px;
            box-shadow: 0 1px 8px 1px rgb(112, 110, 110);
            border-radius:10px;
            background-color: #343444;
            margin-bottom: 20px;
    }

    .nft_card img {
            width: 184px; 
            height: 180px;
            border-radius: 20px;
            border:3px solid #fff;
            background-color: gray;
    }

    .nft_card div.btn {
        border: #FE337E solid thin;
        border-radius: 5px;
        padding: 2px 20px;
        background-color: #fe337e;
        color: #fff;
        font-size: 0.8rem;    
    }

    .nft_card div.btn:hover {
        background-color: transparent;
        color: #fe337e;
    }

    .sub_panel {
        font-size: 0.9rem;
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
        border: #FE337E solid thin !important;
        background: #fe337e;
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
        background-color: transparent;
        color:#fe337e;
    }
    .modal__content .row{
        margin-right: 0px !important;
        margin-left: 0px !important;
    }
    .search {
        width: 100%;
        border: 1px solid rgba(63, 210, 255, 0.308);
        border-radius: 5px;
        padding: 1px 0px;
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
</style>
