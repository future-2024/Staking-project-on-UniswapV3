<template>
  <div>
    <!-- <Home /> -->
    <AppNavbar/>
    <HeroSection />
    <AbSection />
    <TokenNomics />
    <RoadMap />
    <NewF />
  </div>
</template>
<script>
// import Home from "../components/homemain/Home.vue";
import AppNavbar from "../components/homemain/AppNavbar.vue";
import HeroSection from "../components/homemain/HeroSection.vue";
import AbSection from "../components/homemain/AbSection.vue";
import TokenNomics from "../components/homemain/TokenNomics.vue";
import RoadMap from "../components/homemain/RoadMap.vue";
import NewF from "../components/homemain/NewF.vue";
export default {
  components: {
    AppNavbar,
    HeroSection,
    AbSection,
    TokenNomics,
    RoadMap,
    NewF
  },
  data() {
    return {};
  },
};
</script>
