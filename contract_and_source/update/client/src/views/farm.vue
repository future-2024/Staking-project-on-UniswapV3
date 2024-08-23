<template>
  <div>
    <AppNavbar />
    <!-- <Header /> -->
    <Main />
    <Blog />
    <!-- <NewF/> -->
  </div>
</template>
<script>
import AppNavbar from "../components/farm/AppNavbar.vue";
// import Header from '../components/Header.vue'
import Main from "../components/farm/Main.vue";
import Blog from "../components/home/Blog.vue";
// import NewF from "../components/farm/NewF.vue";
export default {
  components: {
    AppNavbar,
    // Header,
    Main,
    Blog,
    // NewF
  },
};
</script>
