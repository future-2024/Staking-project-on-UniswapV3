<template>
    <div>
        <Main />
        <Blog />
    </div>
</template>
<script>
  import Main from '../components/farm/Main.vue'
  import Blog from '../components/home/Blog.vue'
  export default {
        components: {
            Main,
            Blog
        }
  }
</script>
