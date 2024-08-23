import VueRouter from 'vue-router'
const routes = [
    {
        path: '/',
        component: () =>
            import ('../components/layouts/HomeLayout.vue'),
        children: [{
            path: '/',
            component: () =>
                import ('../views/home.vue')
        }]
    },


    // {
    //     path: '/',
    //     component: () =>
    //         import ('../components/homemain/Home.vue'),
    //     children: [{
    //         path: '/',
    //         component: () =>
    //             import ('../views/homemain.vue')
    //     }]
    // },


    {
        path: '/jackpot',
        component: () =>
            import ('../components/layouts/HomeLayout.vue'),
        children: [{
            path: '/',
            name: 'jackpot',
            component: () =>
                import ('../views/jackpot.vue')
        }]
    },
    {
        path: '/winnersboard',
        component: () =>
            import ('../components/layouts/HomeLayout.vue'),
        children: [{
            path: '/',
            name: 'winnersboard',
            component: () =>
                import ('../views/winnersboard.vue')
        }]
    },
    {
        path: '/diamond-reserve',
        component: () =>
            import ('../components/layouts/HomeLayout.vue'),
        children: [{
            path: '/',
            name: 'diamond-reserve',
            component: () =>
                import ('../views/diamond.vue')
        }]
    },
    {
        path: '/lge',
        component: () =>
            import ('../components/layouts/HomeLayout.vue'),
        children: [{
            path: '/',
            name: 'lge',
            component: () =>
                import ('../views/launch.vue')
        }]
    },
    {
        path: '/private',
        component: () =>
            import ('../components/layouts/HomeLayout.vue'),
        children: [{
            path: '/',
            name: 'private',
            component: () =>
                import ('../views/private.vue')
        }]
    },
    {
        path: '/farm',
        component: () =>
            import ('../components/layouts/HomeLayout.vue'),
        children: [{
            path: '/',
            name: 'farm',
            component: () =>
                import ('../views/farm.vue')
        }]
    },
    {
        path: '/reward',
        component: () =>
            import ('../components/layouts/HomeLayout.vue'),
        children: [{
            path: '/',
            name: 'reward',
            component: () =>
                import ('../views/reward.vue')
        }]
    },
    {
        path: '/mexitails',
        component: () =>
            import ('../components/layouts/HomeLayout.vue'),
        children: [{
            path: '/',
            name: 'mexitails',
            component: () =>
                import ('../views/mexitails.vue')
        }]
    },
]
const router = new VueRouter({
    mode: 'history',
    routes
})
export default router