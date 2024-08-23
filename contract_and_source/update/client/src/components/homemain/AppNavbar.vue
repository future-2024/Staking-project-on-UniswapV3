<template>
  <div class="navbar-main">
    <div class="navbar">
      <div class="logo">
        <img :src="imageSrc" alt="Logo" />
      </div>
      <ul class="nav-links">
        <li class="link-one"><a href="#home">Home</a></li>
        <li class="link-two"><a href="#about">About</a></li>
        <li class="link-three"><a href="#roadmap">Roadmap</a></li>
        <li class="link-four"><a href="#roadmap">Farm</a></li>
        <li class="link-five"><a href="https://t.me/HahaFTM" target="blank">Contact</a></li>
      </ul>

      <div class="btn-main">
        <a href="https://dexscreener.com/fantom/0xa199f786bfb26612b19bbc81dc36b2f7f9f874eb" target="blank" style="text-decoration:none"><button style="color: #fff">BUY HAHA</button></a>
      </div>

      <!-- Hamburger Icon -->
      <div class="hamburger" @click="toggleMenu">
        <div class="bar"></div>
        <div class="bar"></div>
        <div class="bar"></div>
      </div>
    </div>

    <!-- Sliding Menu -->

    <div class="side-menu" :class="{ visible: menuVisible }">
      <div class="logo-and-cross-btn">
        <img :src="imageSrc" alt="Logo" />
        <button class="close-button" @click="toggleMenu">&times;</button>
      </div>
      <ul class="side-menu-links">
        <div class="links-mobile-1">
          <a href="#home" @click="toggleMenu">Home</a>
        </div>
        <div class="links-mobile-2">
          <a href="#about" @click="toggleMenu">About</a>
        </div>
        <div class="links-mobile-3">
          <a href="#roadmap" @click="toggleMenu">Roadmap</a>
        </div>
        <div class="links-mobile-4">
          <a href="#tokenomics" @click="toggleMenu">Farm</a>
        </div>
        <div class="links-mobile-5">
          <a href="https://t.me/HahaFTM" target="blank" style="text-decoration:none;" @click="toggleMenu">Contact</a>
        </div>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  name: "AppNavbar",
  props: {
    msg: String,
  },
  data() {
    return {
      imageSrc: require("../../assets/logo.png"),
      menuVisible: false, // Added for toggling the menu
    };
  },
  methods: {
    toggleMenu() {
      this.menuVisible = !this.menuVisible; // Toggle menu visibility
    },
  },
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap");

/* Add your styles here */
.navbar-main {
  display: flex;
  justify-content: center;
  position: relative; /* Isko as it is rakhein */
}

.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 14px 20px 6px 20px;
  color: #fff;
  background-color: #fff;
  width: 80%;
  border: 2px solid black;
  border-radius: 8px;
  margin-top: 1.5rem;
  font-family: "Poppins", sans-serif; /* Apply Poppins font to navbar */

  /* Fixed position */
  position: fixed; /* Navbar ko fixed position dena */
  top: 0; /* Top se attach karna */
  left: 50%; /* Center karne ke liye */
  transform: translateX(-50%); /* Center alignment ke liye */
  z-index: 1000; /* Ensure navbar stays on top */
}

img {
  height: 55px;
  /* margin-top: 0.5rem; */
}

.nav-links {
  list-style: none;
  display: flex;
  gap: 20px;
}

.nav-links li a {
  color: black;
  text-decoration: none;
}

/* Add transition for smooth effect */
.link-one,
.link-two,
.link-three,
.link-four,
.link-five {
  padding: 0.6rem 1rem;
  border-radius: 6px;
  font-size: 17px;
  box-shadow: black 2px 2px;
  border: 1px solid black;
  margin-left: 2rem;
  transition: box-shadow 0.3s ease; /* Transition effect for box shadow */
}

.link-one {
  background-color: #ffa90a;
  box-shadow: none;
}

.link-two {
  background-color: #e6ff2a;
}

.link-three {
  background-color: #2aff4a;
}

.link-four {
  background-color: #2afff1;
}

.link-five {
  background-color: #2a9cff;
}

/* Hover effect to remove shadow */
.link-one:hover,
.link-two:hover,
.link-three:hover,
.link-four:hover,
.link-five:hover {
  box-shadow: none; /* Remove shadow on hover */
}

.btn-main button {
  background: linear-gradient(to right, #f2994a, #d5473d);
  padding: 0.6rem 1.5rem;
  border-radius: 6px;
  font-size: 17px;
  letter-spacing: 1px;
  font-weight: 600;
  box-shadow: black 3px 3px;
  transition: box-shadow 0.3s ease; /* Transition effect for box shadow */
  border: 1px solid black;
  cursor: pointer;
  margin-top: -0.7rem;
}

.btn-main button:hover {
  box-shadow: none; /* Remove shadow on hover */
}

.hamburger {
  display: none; /* Hide by default */
  flex-direction: column;
  cursor: pointer;
  margin-top:-10px;
}

.bar {
  height: 3px;
  width: 25px;
  background-color: black; /* Black color for hamburger bars */
  margin: 3px 0; /* Spacing between bars */
}

.links-mobile-1 {
  background: #ffa90a;
  width: 100%;
  margin-bottom: 1rem;
  padding: 1rem 0rem;
  text-align: center;
  font-family: "Poppins";
  border-radius: 8px;
}

.links-mobile-2 {
  background: #e6ff2a;
  width: 100%;
  margin-bottom: 1rem;
  padding: 1rem 0rem;
  text-align: center;
  font-family: "Poppins";
  border-radius: 8px;
}

.links-mobile-3 {
  background: #2aff4a;
  width: 100%;
  margin-bottom: 1rem;
  padding: 1rem 0rem;
  text-align: center;
  font-family: "Poppins";
  border-radius: 8px;
}

.links-mobile-4 {
  background: #2afff1;
  width: 100%;
  margin-bottom: 1rem;
  padding: 1rem 0rem;
  text-align: center;
  font-family: "Poppins";
  border-radius: 8px;
}

.links-mobile-5 {
  background: #2a9cff;
  width: 100%;
  margin-bottom: 1rem;
  padding: 1rem 0rem;
  text-align: center;
  font-family: "Poppins";
  border-radius: 8px;
}

.links-mobile-1 a,
.links-mobile-2 a,
.links-mobile-3 a,
.links-mobile-4 a,
.links-mobile-5 a {
  text-decoration: none;
  color: black;
}

@media screen and (max-width: 1442px) {
  .nav-links {
    list-style: none;
    display: flex;
    gap: 0px;
  }
}

@media screen and (max-width: 1326px) {
  .nav-links {
    list-style: none;
    display: flex;
    gap: 0px;
    margin-left: -2rem;
  }
  .nav-links li a {
    height: 20px;
    font-size: 12px;
  }
}

/* Media query for screen sizes less than or equal to 1110px */
@media screen and (max-width: 1110px) {
  .nav-links {
    display: none; /* Hide nav links and button */
  }

  .hamburger {
    display: flex; /* Show hamburger icon */
  }
}


/* Side Menu Styles */
.side-menu {
  position: fixed;
  top: 0;
  right: -100%;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.95);
  box-shadow: -2px 0 5px rgba(0, 0, 0, 0.5);
  transition: right 0.3s ease; /* Smooth slide effect */
  z-index: 1000; /* Ensure it appears on top */
}

.side-menu.visible {
  right: 0; /* Show the menu */
}

.side-menu-links {
  list-style: none;
  padding: 40px;
  margin-top: 4rem;
}

/* Specific styles for each link to keep consistent with navbar */
.link-one {
  background-color: #ffa90a;
  box-shadow: none;
}

.link-two {
  background-color: #e6ff2a;
}

.link-three {
  background-color: #2aff4a;
}

.link-four {
  background-color: #2afff1;
}

.link-five {
  background-color: #2a9cff;
}

/* Hover effect to remove shadow */
.side-menu-links li a:hover {
  box-shadow: none; /* Remove shadow on hover */
}

.close-button {
  background: #fff;
  border: none;
  font-size: 30px;
  cursor: pointer;
  position: absolute;
  top: 20px;
  right: 20px;
  width: 45px;
  border-radius: 50%;
}

.side-menu-button button {
  background: linear-gradient(to right, #f2994a, #d5473d);
  padding: 0.9rem 1.5rem;
  border-radius: 6px;
  font-size: 17px;
  letter-spacing: 1px;
  font-weight: 600;
  box-shadow: black 3px 3px;
  transition: box-shadow 0.3s ease; /* Transition effect for box shadow */
  border: 1px solid black;
  cursor: pointer;
}

.logo-and-cross-btn {
  display: flex;
  align-items: center;
  padding: 0rem 1rem;
  height: 90px;
}

@media screen and (max-width: 500px) {
  .logo img {
    height: 40px;
    /* margin-top: 0.5rem; */
  }
  .btn-main button {
    padding: 0.8rem 1.5rem;
    font-size: 14px;
  }

  .navbar {
    width: 90%;
  }
}

@media screen and (max-width: 400px) {

  .navbar {
    width: 95%;
  }
}

@media screen and (max-width: 390px) {
  .logo img {
    height: 40px;
    margin-top: 0.5rem;
  }
  .btn-main button {
    padding: 0.6rem 1rem;
    font-size: 13px;
  }
}
</style>
