<template>
    <div>
    <Header />
        <Main />
    </div>
</template>
<script>
import Header from '../components/Header.vue'
  import Main from '../components/jackpot/WinnersBoard.vue'
  export default {
        components: {
            Header,
            Main
        }
  }
</script>
