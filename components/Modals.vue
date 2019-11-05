<template>
  <v-row justify="center">
    <v-dialog v-model="isShow" persistent max-width="290">
      <!-- <template v-slot:activator="{ on }">
        <v-btn color="primary" dark v-on="on">Open Dialog</v-btn>
    </template> -->
      <v-alert v-model="alert" type="error">
        Mismatch OTP.
      </v-alert>
      <v-card>
        <v-card-title class="headline" style="justifyContent: center;"
          >???INPUT OTP???</v-card-title
        >
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  v-model="otp"
                  label="OTP*"
                  type="text"
                  required
                  @input="onchange"
                ></v-text-field>
              </v-col>
            </v-row>
          </v-container>
          Let Google help apps determine location. This means sending anonymous
          location data to Google, even when no apps are running.</v-card-text
        >
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="green darken-1" text @click="onCancel">Disagree</v-btn>
          <v-btn
            color="green darken-1"
            text
            :loading="loadingbtn"
            @click="onagree"
            >Agree</v-btn
          >
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
export default {
  props: {
    alert: {
      type: Boolean,
      required: true,
      default: false
    },
    loadingbtn: {
      type: Boolean,
      required: false,
      default: false
    },
    isShow: {
      type: Boolean,
      required: true
    },
    actionCancel: {
      type: Function,
      required: false,
      default: () => (this.isShow = false)
    },
    agree: {
      type: Function,
      required: false,
      default: () => (this.isShow = false)
    }
  },
  data() {
    return {
      otp: ''
    }
  },
  methods: {
    onchange() {
      this.$emit('inputotp', this.otp)
    },
    onagree() {
      this.agree(this.otp)
      this.otp = ''
    },
    onCancel() {
      this.actionCancel()
      this.otp = ''
    }
  }
}
</script>
