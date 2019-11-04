<template>
  <div>
    <v-alert type="success" dismissible v-model="success">
      Request aproved
    </v-alert>
    <TableComp
      :headers="headers"
      :items="desserts"
      showselected
      @listen="read"
    />
    <v-row class="d-flex flex-row-reverse">
      <v-col v-if="items.length !== 0" class="text-center" cols="12" sm="2">
        <v-btn class="my-10" color="primary" @click="save">OK</v-btn>
      </v-col>
      <v-col class="text-center" cols="12" sm="2">
        <v-btn class="my-10" color="error" @click="cancel">Cancel</v-btn>
      </v-col>
    </v-row>
    <Modals
      :is-show="dialog"
      :loadingbtn="loadingbtn"
      :action-cancel="onclose"
      :agree="agree"
      :alert="alert"
      @inputotp="oninput"
    />
  </div>
</template>

<script>
import TableComp from '@/components/TableComp'
import Modals from '@/components/Modals'
export default {
  components: {
    TableComp,
    Modals
  },
  data() {
    return {
      items: [],
      alert: false,
      success: false,
      dialog: false,
      loadingbtn: false,
      headers: [
        {
          text: 'Dessert (100g serving)',
          align: 'left',
          sortable: false,
          value: 'name'
        },
        { text: 'Calories', value: 'calories' },
        { text: 'Fat (g)', value: 'fat' },
        { text: 'Carbs (g)', value: 'carbs' },
        { text: 'Protein (g)', value: 'protein' },
        { text: 'Iron (%)', value: 'iron' }
      ],
      desserts: [
        {
          name: 'Frozen Yogurt',
          calories: 159,
          fat: 6.0,
          carbs: 24,
          protein: 4.0,
          iron: '1%'
        },
        {
          name: 'Ice cream sandwich',
          calories: 237,
          fat: 9.0,
          carbs: 37,
          protein: 4.3,
          iron: '1%'
        },
        {
          name: 'Eclair',
          calories: 262,
          fat: 16.0,
          carbs: 23,
          protein: 6.0,
          iron: '7%'
        },
        {
          name: 'Cupcake',
          calories: 305,
          fat: 3.7,
          carbs: 67,
          protein: 4.3,
          iron: '8%'
        },
        {
          name: 'Gingerbread',
          calories: 356,
          fat: 16.0,
          carbs: 49,
          protein: 3.9,
          iron: '16%'
        },
        {
          name: 'Jelly bean',
          calories: 375,
          fat: 0.0,
          carbs: 94,
          protein: 0.0,
          iron: '0%'
        },
        {
          name: 'Lollipop',
          calories: 392,
          fat: 0.2,
          carbs: 98,
          protein: 0,
          iron: '2%'
        },
        {
          name: 'Honeycomb',
          calories: 408,
          fat: 3.2,
          carbs: 87,
          protein: 6.5,
          iron: '45%'
        },
        {
          name: 'Donut',
          calories: 452,
          fat: 25.0,
          carbs: 51,
          protein: 4.9,
          iron: '22%'
        },
        {
          name: 'KitKat',
          calories: 518,
          fat: 26.0,
          carbs: 65,
          protein: 7,
          iron: '6%'
        }
      ]
    }
  },
  methods: {
    read(data) {
      this.items = data
      console.log(this.items)
    },
    save() {
      console.log('save')
      this.dialog = !this.dialog
      console.log(this.dialog)
    },
    cancel() {
      console.log('cancel')
      this.$router.push('/')
    },
    agree() {
      this.loadingbtn = true
      console.log('agree')
      console.log(this.otpvalues)
      setTimeout(() => {
        if (this.otpvalues === '1234') {
          this.dialog = false
          this.alert = false
          this.success = true
          console.log('alert ' + this.alert)
          console.log('items selected', this.items)
          for (const index in this.items) {
            console.log(this.items[index])
            this.desserts.splice(this.desserts.indexOf(this.items[index]), 1)
          }
          console.log(this.desserts)
        } else {
          this.alert = true
        }
        this.loadingbtn = false
      }, 1000)
    },
    onclose() {
      this.dialog = false
    },
    oninput(data) {
      this.otpvalues = data
    }
  }
}
</script>
