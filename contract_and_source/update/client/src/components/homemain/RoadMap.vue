<template>
  <section id="roadmap">
    <div class="waves-img-bg">
      <img class="waves-img" src="@/assets/waveImage.png" alt="Icon 3" />
      <img class="wave-textimg" src="@/assets/textimage.png" alt="Icon 3" />
    </div>

    <div class="main-img-two">
      <div class="main-c">
        <div class="container-one">
          <div class="text-mainp">
            <h1 class="our-text">
              ᯓ ✈︎ Roadmap
            </h1>
            <p class="text">
              Our roadmap includes the launch, community building, marketing campaigns, exchange listings, partnerships, staking and farming, and governance.
            </p>

            <img src="@/assets/roadmap-img.png" alt="Icon 3" />

            <div class="btn-main"><a href="https://t.me/HahaFTM" target="blank">
            <button style="color: #fff">Join Telegram</button></a>
          </div>
        </div>
      </div>
      <div class="container-two">
        <div class="stick-image-parent">
          <img src="@/assets/arrow.png" alt="Icon 3" />
        </div>
        <div class="card-boxes" style="padding-right:20%;">
          <div class="card-one">
            <p class="question">October 2024</p>
            <p class="para" style="font-size:16px;">⦿  $Haha token launch</p>
            <p class="para" style="font-size:16px;">⦿  Website and social platforms live</p>
            <p class="para" style="font-size:16px;">⦿  Launch of farming with $Haha</p>
          </div>
          <div class="card-two">
            <p class="question">November 2025</p>
            <p class="para" style="font-size:16px;">⦿  Meme farming platform for all Fantom-based projects</p>
            <p class="para" style="font-size:16px;">⦿  Onboarding new partners and meme projects</p>
            <p class="para" style="font-size:16px;">⦿  Community Meme Contests</p>
          </div>
          <div class="card-three">
            <p class="question">Q1 2025</p>
            <p class="para" style="font-size:16px;">⦿  Expansion of Partnerships</p>
            <p class="para" style="font-size:16px;">⦿  Enhanced Interactive Website Features</p>
            <p class="para" style="font-size:16px;">⦿  Introduction of haha-themed Games</p>
            <p class="para" style="font-size:16px;">⦿  Community Governance</p>
          </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- <img src="@/assets/fwaves.png" alt="Icon 3" /> -->
</template>

<script>
export default {
  name: "RoadMap",
};
</script>

<style scoped>
.main-img-two {
  width: 100%;
  max-height: 100%;
  background: #e8b885;
  background-image: url("../../assets/rBg.png");
  background-size: cover;
  background-repeat: no-repeat;
  background-position: center;
  display: flex;
  justify-content: center;
  padding: 5rem 0rem;
}

.main-c {
  width: 80%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 2rem;
  height: 100%;
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
  margin: 1rem 0rem;
}

.container-one,
.container-two {
  width: 50%;
}
.container-two {
  display: flex;
  align-items: center;
}

.btn-main button:hover {
  box-shadow: none; /* Remove shadow on hover */
}
.card-one,
.card-two,
.card-three {
  background: linear-gradient(to right, #f2994a, #d5473d);
  width: 120%;
  margin-bottom: 1rem;
  padding: 2rem 1.5rem;
  border-radius: 8px;
}
.question {
  font-family: "Poppins";
  margin-bottom: 0.5rem;
  font-weight: 600;
  font-size: 20px;
}
.para {
  font-family: "Poppins";
  margin-bottom: 0.5rem;
}

.container-one img {
  height: 400px;
}

.our-text {
  font-family: "Poppins";
  line-height: 80px;
  font-size: 72px;
  margin-bottom: 1.5rem;
  color: #fff;
  font-weight:bold;
  text-shadow: -1px -2px 0px black, /* Top-left shadow */ 3px 12px 0px #000,
    /* Top-left shadow */ 3px 3px 0px #000; /* Bottom-right shadow */
  text-align: center;
}
.text {
  color: black;
  font-family: "Poppins";
  font-weight: 500;
  text-align: center;
  margin-bottom: 1rem;
  font-size: 20px;
  width: 75%;
  line-height: 32px;
}
.card-boxes {
  margin-left: 3rem;
}

.text-mainp {
  width: 92%;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.waves-img-bg {
  background: #e9ba7c;
  position: relative;
}

.waves-img {
  height: 250px;
  margin-top: -5rem;
}

@keyframes scrollText {
  0% {
    transform: translateX(100%);
  }
  100% {
    transform: translateX(-100%);
  }
}

.wave-textimg {
  height: 50px;
  display: inline-block;
  white-space: nowrap; /* Taake image wrap na ho aur continuous appear ho */
  animation: scrollText 60s linear infinite;
  position: absolute;
  top: 10%;
}

@media screen and (max-width: 1715px) {
  .waves-img {
    height: 200px;
    margin-top: -5rem;
  }

  .wave-textimg {
    height: 35px;
  }
}

@media screen and (max-width: 1350px) {
  .card-one,
  .card-two,
  .card-three {
    width: 110%;
  }
}

@media screen and (max-width: 1212px) {
  .our-text {
    line-height: 65px;
    font-size: 58px;
  }
  .text {
    font-size: 17px;
    width: 80%;
  }

  .container-one img {
    height: 300px;
  }

  .main-c {
    width: 80%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: -3rem;
    height: 100%;
  }
}

@media screen and (max-width: 994px) {
  .waves-img {
    height: 170px;
    margin-top: -5rem;
  }

  .wave-textimg {
    height: 30px;
    margin-top: -1rem;
  }
}

@media screen and (max-width: 932px) {
  .main-c {
    width: 80%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: -3rem;
    height: 100%;
  }
}

@media screen and (max-width: 644px) {
  .waves-img {
    height: 150px;
    margin-top: -5rem;
  }

  .wave-textimg {
    height: 30px;
    margin-top: -1.5rem;
  }
}

@media screen and (max-width: 969px) {
  .main-c {
    width: 80%;
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-top: 2rem;
    height: 100%;
  }
  .main-img-two {
    width: 100%;
    max-height: 140%;
  }
  .container-one,
  .container-two {
    width: 100%;
    display: flex;
    justify-content: center;
    margin: 2rem 0rem;
  }
  .container-two {
    display: flex;
    justify-content: flex-start;
  }
  .card-boxes {
    width: 80%;
  }
}

@media screen and (max-width: 718px) {
  .main-c {
    width: 95%;
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-top: 2rem;
    height: 100%;
  }
  .main-img-two {
    width: 100%;
    max-height: 140%;
  }
  .container-one,
  .container-two {
    width: 100%;
    margin: 2rem 0rem;
  }
  .card-one,
  .card-two,
  .card-three {
    width: 100%;
  }
}

@media screen and (max-width: 651px) {
  .card-one,
  .card-two,
  .card-three {
    width: 100%;
  }
}

@media screen and (max-width: 590px) {
  .card-boxes {
    width: 80%;
  }
}

@media screen and (max-width: 430px) {
  .card-boxes {
    margin-left: 1rem;
  }
  .card-boxes {
    width: 75%;
  }
}
</style>
