// this will apply to all Pages
export default function(context) {
  console.log('ini Middleware')
  console.log(context.store.state.islogin)
  console.log(context)
  if (!context.store.state.islogin) {
    if (context.route.path !== '/login/internal/merchant/admin') {
      context.redirect('/login/internal/merchant/admin')
    }
  }
}
