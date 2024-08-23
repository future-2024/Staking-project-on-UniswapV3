<template>
  <section id="contact">
    <div class="main-img-two">
      <div class="main-ccc">
        <div class="footer-images">
          <img
            class="footer-wave-image"
            src="@/assets/fwaves.png"
            alt="Icon 1"
          />

          <img
            class="first-footer-img"
            src="@/assets/footer-image.png"
            alt="Icon 1"
          />
          <img class="logoImage" src="@/assets/logo.png" alt="Icon 1" />
        </div>

        <div class="main-c">
          <div>
            <p class="small-text">
              Join the Meme-frenzy on #FTM with $HAHA! Follow us on social media and
            stay updated on the developments and news. _ō͡≡o˞̶__ 
            </p>
          </div>

          <div class="btn-main"><a href="https://dexscreener.com/fantom/0xa199f786bfb26612b19bbc81dc36b2f7f9f874eb" target="blank" style="text-decoration:none;">
            <button style="color: #fff">BUY $HAHA</button></a>
          </div>

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
          </div>
           <div class="icon-4">
            <p class="small-text" style="font-size:15px; padding:20px;"><img src="@/assets/pattaya-guy.png" alt="Pattaya Guy" style="max-width:150px;"/><br />A 'Pattayaguy' Venture.</p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- <img src="@/assets/fwaves.png" alt="Icon 3" /> -->
</template>

<script>
export default {
  name: "NewF",
};
</script>

<style scoped>
.main-img-two {
  width: 100%;
  min-height: 100%; /* You can also use this */
  background: #e8b885;
  background-image: url("../../assets/footer-bg.png");
  background-size: cover;
  background-repeat: no-repeat;
  background-position: center;
  display: flex;
  justify-content: center;
}

.main-c {
  width: 28%;
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 2rem;
  height: 100%;
}

.footer-images {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: -1rem;
}

.btn-main {
  margin-top: 2rem;
}

.social-media-icons {
  display: flex;
}

.social-media-icons {
  margin-top: 2rem;
  width: 65%;
  display: flex;
  justify-content: space-between;
  margin-bottom: 2rem;
}

.btn-main button {
  background: linear-gradient(to right, #f2994a, #d5473d);
  padding: 0.9rem 2.2rem;
  border-radius: 6px;
  font-size: 18px;
  box-shadow: black 3px 3px;
  transition: box-shadow 0.3s ease; /* Transition effect for box shadow */
  border: 1px solid black;
  cursor: pointer;
  margin-top: -0.6rem;
}

.small-text {
  color: black;
  font-weight: 600;
  line-height: 32px;
  margin-top: -0.5rem;
  font-size: 22px;
  font-family: "Poppins";
  text-align: center;
}

.main-ccc {
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 100%;
}

.logoImage {
  margin-top: 1rem;
}

.first-footer-img {
  height: 280px;
}

.footer-wave-image {
  height: 280px;
}

@media screen and (max-width: 820px) {
  .footer-wave-image {
    height: 220px;
    margin: 2rem 0rem;
  }
  .main-c {
    width: 38%;
  }
}

@media screen and (max-width: 665px) {
  .footer-wave-image {
    height: 180px;
    margin: 4rem 0rem 0rem 0rem;
  }
}

@media screen and (max-width: 500px) {
  .footer-wave-image {
    height: 140px;
    margin: 4rem 0rem 0rem 0rem;
  }
  .main-c {
    width: 45%;
  }
}

@media screen and (max-width: 450px) {
  .small-text {
    font-size: 18px;
  }
  .main-c {
    width: 37%;
  }

  .social-media-icons {
    width: 90%;
  }
}

@media screen and (max-width: 379px) {
  .small-text {
    font-size: 17px;
  }
  .main-c {
    width: 35%;
  }

  .social-media-icons {
    width: 90%;
  }
}
</style>
