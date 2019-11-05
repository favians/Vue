<template>
  <v-app id="login" class="primary">
    <v-content>
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md4 lg4>
            <v-card class="elevation-1 pa-3">
              <v-card-text>
                <div class="layout column align-center">
                  <img
                    src="~/static/m.png"
                    alt="Vue Material Admin"
                    width="120"
                    height="120"
                  />
                  <h1 class="flex my-4 primary--text">
                    Material Admin Template
                  </h1>
                </div>
                <v-form>
                  <v-text-field
                    v-model="model.username"
                    append-icon="person"
                    name="login"
                    label="Login"
                    type="text"
                  ></v-text-field>
                  <v-text-field
                    v-model="model.password"
                    :append-icon="show1 ? 'visibility' : 'visibility_off'"
                    :rules="[rules.required, rules.min]"
                    :type="show1 ? 'text' : 'password'"
                    name="input-password"
                    label="Password"
                    hint="At least 8 characters"
                    counter
                    @click:append="show1 = !show1"
                  ></v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                  block
                  color="primary"
                  style="maxwidth=100%"
                  @click="login"
                >
                  Login
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
export default {
  data() {
    return {
      show1: false,
      model: {
        username: '',
        password: ''
      },
      rules: {
        required: (value) => !!value || 'Required.',
        min: (v) => v.length >= 8 || 'Min 8 characters'
      }
    }
  },
  methods: {
    login() {
      console.log(this.model)
      if (
        this.model.username === 'uvuwewewe' &&
        this.model.password === 'passw0rd'
      ) {
        console.log('masuk')
        this.$store.dispatch('login')
        localStorage.setItem('login', true)
        console.log(this.$store.state.islogin)
        console.log(this.$store.state.isAdmin)
      }
      setTimeout(() => {
        this.$router.push('/')
      }, 1000)
    }
  }
}
</script>

<style scoped lang="css">
  #login {
  height: 50%;
  width: 100%;
  position: absolute;
  top: 0;
  left: 0;
  content: "";
  z-index: 0;
}
.login-btn{
  position: absolute;
  width:50%;
  height: 50%;
}
</style>
