<template>
  <section id="about">
    <div class="waves-img-bg">
      <img class="waves-img" src="@/assets/waveImage.png" alt="Icon 3" />
      <img class="wave-textimg" src="@/assets/textimage.png" alt="Icon 3" />
    </div>

    <!-- <h1 class="about-text">About</h1> -->

    <div class="main-img-two">
      <div class="main-c">
        <div class="container-one">
          <img src="@/assets/aboutimage.png" alt="Icon 3" />
        </div>
        <div class="container-two" style="padding-left:20px; ">
          <h2>ᯓ ✈︎ MORE than<br />just a Meme</h2>
          <p class="text">$Haha is designed to bring joy to our lives.  It is also a utility token that is used to stake and farm numerous FTM meme project tokens !
<br /></p><p class="text" style="margin-bottom:20px; font-weight:700">
<!-- The $HaHa farming project is more than just fun</p><p class="text" style="margin-bottom:20px;"> -->
⦿ Builds community<br />
⦿ Encourages growth with staking<br />
⦿ The farming generates passive income<br /></p><p class="text">
The $HaHa farm will be used by numerous other FTM projects and will redefine the entire DeFi landscape as you know it.
          </p>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: "AbSection",
};
</script>

<style scoped>
/* Main container styling */
.main-img-two {
  width: 100%;
  background: #e8b885;
  background-image: url("../../assets/aboutbg-image.png");
  background-size: cover;
  background-repeat: no-repeat;
  background-position: center;
  display: flex;
  justify-content: center;
  margin-top: -12rem;
}

/* Responsive containers */
.main-c {
  width: 80%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 13rem;
  margin-bottom: 4rem;
  flex-wrap: wrap; /* Allow flex children to wrap */
}

.container-one {
  flex: 1;
  display: flex;
  justify-content: center;
}

.container-one img {
  max-width: 100%;
  height: auto;
}

.container-two {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 1rem;
}

.container-two h2 {
  font-family: "Poppins", sans-serif;
  font-size: 55px;
  line-height: 68px;
  color: #fff;
  font-weight:bold;
  text-shadow: -1px -2px 0px black, 3px 12px 0px #000, 3px 3px 0px #000;
  margin-bottom: 1.5rem;
}

.text {
  font-family: "Poppins", sans-serif;
  font-size: 18px;
  line-height: 1.8;
  color: black;
  font-weight: 600;
  margin-bottom: 1rem;
  text-align: justify;
  width: 80%;
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

/* About text */
.about-text {
  font-family: "Poppins", sans-serif;
  font-size: 50px;
  font-weight:bold;
  text-align: center;
  color: #fff;
  text-shadow: -1px -2px 0px black, 3px 12px 0px #000, 3px 3px 0px #000;
  margin-top: 5.5rem;
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

/* Responsive media queries */
@media screen and (max-width: 1200px) {
  .main-c {
    width: 90%;
  }

  .container-two h2 {
    font-size: 40px;
    line-height: 50px;
  }

  .text {
    font-size: 16px;
    line-height: 1.6;
  }
}

@media screen and (max-width: 992px) {
  .main-c {
    width: 100%;
    flex-direction: column;
    align-items: center;
  }

  .container-one,
  .container-two {
    width: 90%;
    margin-bottom: 2rem;
  }

  .container-one img {
    max-width: 90%;
    height: auto;
  }

  .container-two h2 {
    font-size: 60px;
    line-height: 75px;
    text-align: center;
  }

  .container-two {
    display: flex;
    align-items: center;
  }
  .text {
    font-size: 18px;
    text-align: center;
    width: 70%;
  }
}

@media screen and (max-width: 768px) {
  .container-one img {
    height: 400px;
  }

  .container-two h2 {
    font-size: 50px;
    line-height: 75px;
    text-align: center;
  }

  .text {
    font-size: 16px;
    text-align: center;
  }
}

@media screen and (max-width: 670px) {
  .container-one img {
    height: 350px;
  }

  .container-two h2 {
    font-size: 40px;
    line-height: 60px;
    text-align: center;
  }

  .text {
    font-size: 14px;
    text-align: center;
  }
}

@media screen and (max-width: 570px) {
  .text {
    font-size: 15px;
    text-align: center;
    width: 85%;
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
</style>
