<template>
<div>
    <!-- <Header /> -->
         <router-view />
    <!-- <Footer /> -->
</div>
</template>
<script>
import Header from '../Header.vue'
import Footer from '../Footer.vue'

export default {
  name: 'HomeLayout',
  components: {
    //   Header,
    //   Footer
  }
}
</script>
<style lang="css" scoped>
    @import '../../assets/jackpot/css/las.css';
    @import '../../assets/css/bootstrap.min.css';
    @import '../../assets/css/style.css';
    @import '../../assets/css/farm.css';
    @import '../../assets/nft/css/style.css';
</style>