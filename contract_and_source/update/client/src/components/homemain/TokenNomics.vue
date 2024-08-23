<template>
  <section id="tokenomics">
    <div class="main-img-two">
      <div class="bg-token-nomcis">
        <h2 class="tokenomics">ᯓ ✈︎ Meme Farming</h2>
        <div>
          <div class="bx-m">
            <img
              class="dollor-img"
              src="@/assets/dollor-image.png"
              alt="Icon 3"
            />
            Built for FTM Ecosystem Memes
          </div>
        </div>

        <div>
          <img
            src="@/assets/maintokenImg.png"
            class="m-tokenimg"
            alt="Icon 3"
          />
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: "TokenNomics",
};
</script>

<style scoped>
.main-img-two {
  width: 100%;
  min-height: 100%;
  background: #e8b885;
  background-image: url("../../assets/tokenomics-bg.png");
  background-size: cover;
  background-repeat: no-repeat;
  background-position: center;
  display: flex;
  justify-content: center;
}

.tokenomics {
  font-family: "Poppins";
  font-size: 60px;
  margin-bottom: 1.5rem;
  line-height: 80px;
font-weight:bold;
  color: #fff;
  text-shadow: -1px -2px 0px black, /* Top-left shadow */ 3px 12px 0px #000,
    /* Top-left shadow */ 3px 3px 0px #000; /* Bottom-right shadow */
  margin-top: 3rem;
  letter-spacing: 3px;
}

.bx-m {
  height: 40px;
  background: linear-gradient(to right, #fa9e47, #f15746);
  border-radius: 24px;
  font-family: "Poppins";
  padding: 0.2rem 2rem;
  display: flex;
  justify-content: center;
  align-items: center;
  color: #fff;
  text-align: center;
  margin-bottom: 2rem;
}

.m-tokenimg {
  height: 700px;
  margin-bottom: 8rem;
}

.bg-token-nomcis {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.dollor-img {
  height: 30px;
  margin-right: 12px;
}

@media screen and (max-width: 1120px) {
  .m-tokenimg {
    height: 550px;
  }
}

@media screen and (max-width: 887px) {
  .m-tokenimg {
    height: 450px;
  }
}

@media screen and (max-width: 1024px) {
  .main-img-two {
    min-height: 80%;
  }
}

@media screen and (max-width: 720px) {
  .m-tokenimg {
    height: 330px;
  }
}

@media screen and (max-width: 564px) {
  .m-tokenimg {
    height: 280px;
  }

  .tokenomics {
    font-size: 40px;
    letter-spacing: 4px;
    margin-bottom: 0.5rem;
  }

  .bx-m {
    height: 35px;
    font-size: 13px;
  }
}

@media screen and (max-width: 460px) {
  .m-tokenimg {
    height: 240px;
  }

  .tokenomics {
    font-size: 40px;
    letter-spacing: 4px;
    margin-bottom: 0.5rem;
  }

  .bx-m {
    height: 32px;
    font-size: 13px;
  }
}

@media screen and (max-width: 430px) {
  .main-img-two {
    min-height: 60%;
  }
}
</style>
