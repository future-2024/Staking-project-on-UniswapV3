<template>
  <div class="main">
    <AppNavbar />
    <HeroSection />
    <AbSection />
    <TokenNomics />
    <RoadMap />
    <NewF />
    <!-- <AnimatedText /> -->
    <!-- Import HeroSection below AppNavbar -->
  </div>
</template>

<script>
// Import the AppNavbar and HeroSection components
import AppNavbar from "./AppNavbar.vue"; // Ensure the path is correct
import HeroSection from "./HeroSection.vue"; // Ensure the path is correct
import RoadMap from "./RoadMap.vue"; // Ensure the path is correct
import NewF from "./NewF.vue"; // Ensure the path is correct
import AbSection from "./AbSection.vue"; // Ensure the path is correct
import TokenNomics from "./TokenNomics.vue"; // Ensure the path is correct
// import AnimatedText from "./AnimatedText.vue"; // Ensure the path is correct

export default {
  name: "HelloWorld",
  components: {
    AppNavbar, // Register the AppNavbar component
    HeroSection, // Register the HeroSection component
    AbSection, // Register the HeroSection component
    RoadMap, // Register the HeroSection component
    NewF, // Register the HeroSection component
    TokenNomics, // Register the HeroSection component
    // AnimatedText, // Register the HeroSection component
  },
  props: {
    msg: String,
  },
  data() {
    return {
      imageSrc: require("@/assets/Background.png"), // Replace with your image path
    };
  },
};
</script>

<style scoped>
.main {
  width: 100%;
  height: 100vh;
  overflow: scroll;
  overflow-x: hidden;
  background-image: url("../../assets/Background.png");
  background-size: cover;
  background-repeat: no-repeat;
  background-position: center;
}

html {
  scroll-behavior: smooth;
}

/* Optional: for specific elements, if needed */
::-webkit-scrollbar {
  display: none; /* Hide scrollbar for webkit browsers */
}
</style>
