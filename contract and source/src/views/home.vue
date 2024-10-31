<template>
    <div>
        <BannerTitle />
        <Support />
        <Fundraisng />
        <Demo />
        <ComingSoon />
        <Blog />
    </div>
</template>
<script>
    import BannerTitle from '../components/home/BannerTitle.vue'
    import Support from '../components/home/Support.vue'
    import Fundraisng from '../components/home/Fundraisng.vue'
    import Demo from '../components/home/Demo.vue'
    import ComingSoon from '../components/home/ComingSoon.vue'
    import Blog from '../components/home/Blog.vue'
  export default {
        components: {
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
