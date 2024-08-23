<template>
    <div>
       <Header />
        <Main />
        <Blog />
    </div>
</template>
<script>
  import Header from '../components/Header.vue'
  import Main from '../components/diamond/Main.vue'
  import Blog from '../components/home/Blog.vue'
  export default {
        components: {
            Header,
            Main,
            Blog
        }
  }
</script>