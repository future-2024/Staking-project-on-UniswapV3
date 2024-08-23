<template>
    <div>
    <Header />
        <BannerTitle />
        <Support />
        <Fundraisng />
        <Demo />
        <ComingSoon />
        <Blog />
    </div>
</template>
<script>
import Header from '../components/Header.vue'
    import BannerTitle from '../components/home/BannerTitle.vue'
    import Support from '../components/home/Support.vue'
    import Fundraisng from '../components/home/Fundraisng.vue'
    import Demo from '../components/home/Demo.vue'
    import ComingSoon from '../components/home/ComingSoon.vue'
    import Blog from '../components/home/Blog.vue'
  export default {
        components: {
            Header,
            BannerTitle,
            Support,
            Fundraisng,
            Demo,
            ComingSoon,
            Blog
        },
        data () {
            return {
            }
        }
  }
</script>
