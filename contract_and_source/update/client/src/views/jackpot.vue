<template>
    <div>
    <Header />
        <Main />
    </div>
</template>
<script>
  import Main from '../components/jackpot/Main.vue'
  import Header from '../components/Header.vue'
  export default {
        components: {
            Header,
            Main
        }
  }
</script>
