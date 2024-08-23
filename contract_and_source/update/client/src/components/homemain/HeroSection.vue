<template>
  <section id="home">
    <div class="hero-section-container">
      <section class="hero-section">
        <div class="hero-container">
          <div class="left-text">
            <div class="column-div">
              <span class="chillin-text">ᯓ  ✈︎ Building FTM's First<br />Meme Farming Ecosystem</span>
              <span class="llama-text">$HAHA</span>
            </div>
            <p class="small-text">
              Join the most joyful [:D] degen community of FTM,<br />
            stake your tokens, sit back enjoy the #SonicBoom.
            </p>
            <div class="btn-main">
              <a href="https://dexscreener.com/fantom/0xa199f786bfb26612b19bbc81dc36b2f7f9f874eb" target="blank" style="text-decoration:none"><button style="color: #fff">JOIN HAHA</button></a>
            </div>

            <div class="ss-m">
              <div class="social-media-icons">
                <div class="icon-1"><a href="https://t.me/HahaFTM" target="blank">
                  <img src="@/assets/firstIcon.png" alt="Icon 1" /></a>
                </div>
                <div class="icon-2"><a href="https://x.com/HahaFTM" target="blank">
                  <img src="@/assets/secondIcon.png" alt="Icon 2" /></a>
                </div>
                <div class="icon-3"><a href="https://ftmscan.com/token/0xa199f786bfb26612b19bbc81dc36b2f7f9f874eb" target="blank">
                  <img src="@/assets/thirdIcon.png" alt="Icon 3" /></a>
                </div>
                <div class="icon-4"><a href="https://www.geckoterminal.com/ftm/pools/0x8e5394a9d846188b91e58d2f2b86bdb75e3c2ba9" target="blank">
                  <img src="@/assets/fourIcon.png" alt="Icon 4" /></a>
                </div>
                <div class="icon-5">
                  <img src="@/assets/banner-img.png" alt="Icon 4" />
                </div>
              </div>
            </div>
          </div>

          <div class="main-image">
            <img src="@/assets/banner-img.png" alt="Icon 4" />
          </div>

           <div class="right-text">
          <img src="@/assets/rightboxcontainer.png" alt="IContainer" />
          <div class="right-text-main">
            <h1>Get Started With $HAHA!</h1>
            <div class="box"></div>
            <p class="usdt"><a href="https://ftmscan.com/token/0xa199f786bfb26612b19bbc81dc36b2f7f9f874eb" target="blank" style="text-decoration:none; color:#000;">CA: Check on FTMSCAN</a></p>
            <!-- <div class="box2-main">
              <div class="box2-main-inner"></div>
            </div> -->
            <p class="usdt-2">Trading Now On SPOOKY</p>
            <p class="usdt-3">Launched with Degen Express</p>
            <p class="usdt-3">Total Supply: 1 Billion $Haha</p> 
            <!-- <p class="usdt-4" style="padding-top:10px;">You can find us on</p> -->
            <div class="card-div-parent">
              <!-- <div class="card-one-div">
                <img src="@/assets/eth.png" alt="Icon 4" />
                <p>EXPLORER</p>
              </div> -->
              <div class="card-one-div">
                <img src="@/assets/ustd.png" alt="Icon 4" />
                <!-- <p>GECKO</p> -->
              </div>
              <div class="card-one-div"> 
                <img src="@/assets/cardLogo.png" alt="Icon 4" />
                <p><a href="https://dexscreener.com/fantom/0xa199f786bfb26612b19bbc81dc36b2f7f9f874eb" target="blank" style="text-decoration: none; color:#fff;"></a>DS</p>
              </div>
            </div>

            <p class="eth-text" style="padding-top:10px;">You can buy $HAHA with $FTM</p>

            <div class="card-div-parent-2">
              <div class="card-one-div-2">
                <p>100+ Degens</p>
                <img src="@/assets/eth.png" alt="Icon 4" />
              </div>
              <div class="card-second-div-2">
                <p>3K+ Anons</p>
                <img src="@/assets/user.png" alt="Icon 4" />
              </div>
            </div>

            <!-- <div class="card-div-parent-3">
              <div class="card-one-div-3">
                <p>Connect Wallet</p>
              </div>
              <div class="card-second-div-3">
                <img src="@/assets/bit-coin.png" alt="Icon 4" />
                <p>Buy Wallet</p>
              </div>
            </div> -->

            <p class="text-center-bottom" style="padding-bottom:10px; text-decoration:none;">
              If you have any questions, please reach out <br />on <a href="https://t.me/HahaFTM" target="blank">Telegram</a> or <a href="https://x.com/HahaFTM" target="blank">X</a>.
            </p>
          </div>
        </div>
        </div>
      </section>
    </div>
  </section>
</template>

<script>
export default {
  name: "HeroSection",
};
</script>

<style scoped>
.hero-section-container {
  display: flex;
  justify-content: center;
}

.hero-section {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 82%;
  margin-top: 4rem;
  margin-bottom: 6rem;
}

.hero-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  margin-top: 4rem;
}

.left-text,
.right-text {
  flex-direction: row;
  align-items: center;
  border-radius: 8px;
  max-width: 50%;
}

.left-text {
  margin-top: 2rem;
}
.right-text {
  position: relative;
}
.right-text img {
  height: 750px;
}

h1 {
  font-family: "Poppins", sans-serif;
  font-size: 2rem;
  margin-bottom: 10px;
}

p {
  font-family: "Poppins", sans-serif;
  font-size: 1rem;
  margin-bottom: 15px;
}

button {
  padding: 10px 20px;
  background-color: #ffa90a;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-family: "Poppins", sans-serif;
}
.social-media-icons {
  display: flex;
  justify-content: space-between; /* Align items horizontally to the start */
  align-items: flex-start; /* Align items vertically to the start */
  margin-top: 20px;
}

.icon-1 img,
.icon-2 img,
.icon-3 img,
.icon-4 img {
  height: 60px;
}
.icon-2 img,
.icon-3 img,
.icon-4 img {
  margin-left: 1.8rem;
}
.icon-5 img {
  height: 280px;
  margin-left: 6rem;
}

.column-div {
  display: flex;
  flex-direction: column;
}
span {
  font-family: "Poppins";
}
.chillin-text {
  font-size: 2rem; /* Adjust as per your needs */
  font-weight: bold; /* Make the text bold if necessary */
  color: black; /* Original text color */
  text-shadow: -3px -3px 0px rgba(239, 68, 69, 0.8),
    /* First shadow with #ef4445 */ 0px 0px 0px rgba(239, 68, 69, 0.6); /* Second shadow with #ef4445 */
}

.llama-text {
  font-size: 6.4rem; /* Adjust based on your design */
  font-weight: bold; /* Bold text for a strong appearance */
  color: white; /* Adjust the text color as needed */
  text-shadow: -3px -5px 0px rgba(239, 68, 69, 0.8),
    /* Top-left shadow */ 3px 16px 0px #000,
    /* Top-left shadow */ 3px 3px 0px #000; /* Bottom-right shadow */
  letter-spacing: 12px;
  margin-top: -1rem;
}
.small-text {
  color: black;
  font-weight: 600;
  line-height: 32px;
  margin-top: -0.5rem;
  font-size: 18px;
}

.btn-main {
  margin: 3.5rem 0rem;
}

.btn-main button {
  background: linear-gradient(to right, #f2994a, #d5473d);
  padding: 0.7rem 1.8rem;
  border-radius: 6px;
  font-size: 18px;
  box-shadow: black 3px 3px;
  transition: box-shadow 0.3s ease; /* Transition effect for box shadow */
  border: 1px solid black;
  cursor: pointer;
}

.btn-main button:hover {
  box-shadow: none; /* Remove shadow on hover */
}

.right-text-main {
  position: absolute;
  top: 5%;
  left: 8%;
  display:flex;
  flex-direction:column;
  align-items:center;
}
.right-text-main h2 {
  font-family: "Poppins";
  letter-spacing: 3px;
  font-size:18px;
}
.box {
  height: 40px;
  margin-top: 1rem;
  width: 95%;
  background: linear-gradient(to right, #f99646, #ee3d45);
  border-radius: 20px;
}
.box2-main {
  height: 15px;
  width: 100%;
  background: black;
  border-radius: 20px;
}

.box2-main-inner {
  height: 15px;
  width: 92%;
  background: linear-gradient(to right, #f99646, #ee3d45);
  border-radius: 20px;
}

.usdt {
  margin-top: 1rem;
  text-align: center;
  letter-spacing: 2px;
  font-size: 18px;
}

.usdt-2 {
  margin-top: 1rem;
  text-align: center;
  letter-spacing: 2px;
  font-size: 18px;
}

.usdt-3 {
  text-align: center;
  letter-spacing: 2px;
  font-size: 18px;
}

.usdt-4 {
  margin-top: 1rem;
  text-align: center;
  letter-spacing: 2px;
  font-size: 18px;
}

.card-div-parent {
  display: flex;
  justify-content: space-between;
  width:90%;
}

.card-one-div,
.card-second-div,
.card-third-div {
  background: linear-gradient(to right, #f99646, #ee3d45);
  padding: 0rem 1rem;
  display: flex;
  align-items: center;
  border-radius: 26px;
  
}

.card-one-div img,
.card-second-div img {
  height: 40px;
}

.card-third-div img {
  height: 30px;
}

.card-one-div p,
.card-second-div p,
.card-third-div p {
  margin-top: 1rem;
  margin-left: 0.5rem;
}

.eth-text {
  text-align: center;
  font-size: 18px;
  margin-top: 1.2rem;
  letter-spacing: 2px;
}

.card-div-parent-2 {
  display: flex;
  justify-content: space-between;
  width:90%;
}

.card-one-div-2,
.card-second-div-2 {
  background: linear-gradient(to right, #f99646, #ee3d45);
  padding: 0rem 1rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-radius: 26px;
  width: 40%;
}

.card-one-div-2 img,
.card-second-div-2 img {
  height: 40px;
}

.card-one-div-2 p,
.card-second-div-2 p {
  margin-top: 1rem;
  margin-left: 0.5rem;
}

.card-div-parent-3 {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  width:100%;
  margin-left:3rem;
}

.card-one-div-3,
.card-second-div-3 {
  background: linear-gradient(to right, #f99646, #ee3d45);
  padding: 0rem 1rem;
  display: flex;
  align-items: center;
  border-radius: 26px;
  margin-top: 1rem;
  width: 40%;
}

.card-one-div-3 img,
.card-second-div-3 img {
  height: 40px;
}

.card-one-div-3 p,
.card-second-div-3 p {
  margin-top: 1rem;
  margin-left: 0.5rem;
}

.text-center-bottom {
  text-align: center;
  margin-top: 2rem;
}

.main-image {
  display: flex;
  justify-content: center;
  margin: 2rem 0rem;
  display: none;
}

.main-image img {
  height: 300px;
}

@media screen and (max-width: 1510px) {
  .icon-5 img {
    height: 250px;
    margin-left: 3rem;
  }
}

@media screen and (max-width: 1416px) {
  .icon-5 img {
    height: 200px;
    margin-left: 3rem;
  }
}

@media screen and (max-width: 1365px) {
  .llama-text {
    font-size: 6rem;
    margin-top: -1rem;
  }
}

@media screen and (max-width: 1355px) {
  .hero-section {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 92%;
    margin-top: 4rem;
    margin-bottom: 6rem;
  }
}

@media screen and (max-width: 1199px) {
  .hero-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
    margin-left: 0rem;
    margin-top: 4rem;
  }
  .left-text,
  .right-text {
    flex-direction: row;
    align-items: center;
    border-radius: 8px;
    max-width: 100%;
  }
  .chillin-text,
  .llama-text,
  .small-text {
    text-align: center;
  }
  .btn-main {
    display: flex;
    justify-content: center;
    margin: 2rem 0rem;
  }
  .icon-5 img {
    display: none;
  }
  .social-media-icons {
    width: 50%;
    margin-right: 2rem;
  }
  .ss-m {
    display: flex;
    justify-content: center;
    width: 100vw;
  }
  .main-image {
    display: block;
  }
}

@media screen and (max-width: 664px) {
  .social-media-icons {
    width: 60%;
  }
}

@media screen and (max-width: 540px) {
  .right-text img {
    margin-left: -0.5rem;
  }
  .right-text-main {
    font-size: 18px;
    text-align: center;
  }
  .box {
    height: 30px;
    margin-top: 1rem;
    width: 80%;
    background: linear-gradient(to right, #f99646, #ee3d45);
    border-radius: 20px;
    margin-left: 2rem;
  }
  .text-center-bottom {
    font-size: 14px;
  }

  .usdt {
    font-size: 14px;
  }

  .usdt-2 {
    font-size: 14px;
  }

  .usdt-3 {
    font-size: 14px;
  }

  .usdt-4 {
    font-size: 14px;
  }

  .eth-text {
    font-size: 14px;
  }

  .card-one-div img,
  .card-second-div img {
    height: 30px;
    padding-left: 1rem;
  }

  .card-third-div img {
    height: 20px;
    padding-left: 1rem;
  }

  .card-one-div-2 img,
  .card-second-div-2 img {
    height: 30px;
  }

  .card-second-div-3 img {
    height: 30px;
    padding-left: 1rem;
  }

  .card-div-parent,
  .card-div-parent-2,
  .card-div-parent-3 {
    margin-left: -1.5rem;
  }


.card-div-parent-3 {
  width:110%;
  margin-left:3rem;
}


}

@media screen and (max-width: 520px) {
  .social-media-icons {
    width: 70%;
  }
  .chillin-text {
    font-size: 28px;
  }
  .llama-text {
    font-size: 70px;
    margin: 0rem 0rem 1rem 0rem;
  }
}

@media screen and (max-width: 435px) {
  .social-media-icons {
    width: 80%;
  }
  
.card-div-parent-3 {
  width:120%;
  margin-left:5rem;
}
}

@media screen and (max-width: 430px) {
  .social-media-icons {
    width: 80%;
  }
 
}

@media screen and (max-width: 400px) {
  .social-media-icons {
    width: 90%;
  }
}
</style>
