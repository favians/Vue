<template>
  <div>
    <v-alert v-model="success" type="success">
      Request aproved
    </v-alert>
    <h1 style="color:#1d62db;">Send Payment Approval</h1>
    <div v-if="!success">
      <br />
      <p>Hi Finance Lead,</p>
      <p>
        Berikut detail transaksi yang membutuhkan approval dari Anda. Untuk
        melakukan konfirmasi silakan pilih item pada tabel dan masukkan OTP yang
        terkirim ke nomor hp anda!
      </p>
    </div>
    <TableComp
      v-if="!success"
      :headers="transaction_header"
      :items="transaction"
      :showselected="showselected"
      @listen="read"
    />
    <v-row class="d-flex flex-row-reverse">
      <v-col
        v-if="items.length !== 0 && success === false"
        class="text-center"
        cols="12"
        sm="2"
      >
        <v-btn class="my-10" color="primary" @click="save">OK</v-btn>
      </v-col>
      <v-col class="text-center" cols="12" sm="2">
        <v-btn class="my-10" color="error" @click="cancel">Back</v-btn>
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
import MockAdapter from 'axios-mock-adapter'
import TableComp from '@/components/TableComp'
import Modals from '@/components/Modals'
export default {
  components: {
    TableComp,
    Modals
  },
  data() {
    return {
      batch_no: this.$route.params.id,
      transaction: [],
      transaction_header: [
        {
          text: 'ID',
          align: 'left',
          sortable: false,
          value: 'id'
        },
        { text: 'Invoice Number', value: 'invoice_no' },
        { text: 'Vendor', value: 'vendor' },
        { text: 'Bill Date', value: 'bill_date' },
        { text: 'Bank Dest', value: 'bank_dest' },
        { text: 'Currency', value: 'currency' },
        { text: 'Total Amount', value: 'total_amount' },
        { text: 'Bank Source', value: 'bank_source' },
        { text: 'Created By', value: 'created_by' },
        { text: 'Release Status', value: 'release_status' }
      ],
      items: [],
      alert: false,
      success: false,
      dialog: false,
      loadingbtn: false,
      challeng_code: '',
      showselected: true
    }
  },
  created() {
    const self = this
    const mock = new MockAdapter(this.$axios)

    mock
      .onGet('/internal/payout/list')
      .reply(
        200,
        JSON.parse(
          '{"rc": "00","message": "success","payload": {"total": 5,"per_page": 2,"current_page": 2,"last_page": 3,"from": 3,"to": 4,"data": [{"_id": "1000-200000-300000-400000","invoice_no": "INV-201910-00001","amount": 1000000,"status": "draft_1","items": [{"item_amount": 1000000,"item_desc": "Item no.1"}],"bank_code": "your_source_bankcode","destination": {"general_bank_code": "destination_SWIFT_or_BANKCODE","account_no": "99999999999"},"vendor": "Vendor Name","merchant": {"merchant_id": "99999-999999-99999","companyname": "Merchant name"},"approve_reject": {"batch_no": "33333-33333-33333","userid": "222222-333333-222222","email": "appover@email.com","requested_at": "2019-05-13T06:47:04Z","finalized_at": "2019-05-13T06:47:04Z"},"notes": "test","status_desc": "","created_by": {"user_id": "xxxx-xxxx-xxxxx","email": "creator@email.com"},"created_at": "2019-05-13T06:47:04Z","updated_at": "2019-05-13T06:47:04Z"},{"_id": "5000-600000-700000-800000","invoice_no": "INV-201910-00002","amount": 1000000,"status": "draft_1","items": [{"item_amount": 1000000,"item_desc": "Item no.1"}],"bank_code": "your_source_bankcode","destination": {"general_bank_code": "destination_SWIFT_or_BANKCODE","account_no": "99999999999"},"vendor": "Vendor Name","merchant": {"merchant_id": "99999-999999-99999","companyname": "Merchant name"},"approve_reject": {"batch_no": "33333-33333-33333","userid": "222222-333333-222222","email": "appover@email.com","requested_at": "2019-05-13T06:47:04Z","finalized_at": "2019-05-13T06:47:04Z"},"notes": "test","status_desc": "","created_by": {"user_id": "xxxx-xxxx-xxxxx","email": "creator@email.com"},"created_at": "2019-05-13T06:47:04Z","updated_at": "2019-05-13T06:47:04Z"}]}}'
        )
      )
    console.log('batch_number', self.batch_no)
    this.$axios
      .get('/internal/payout/list', {
        query: {
          status: 'draft_1',
          orderby: 'created_at',
          batch_no: self.batch_no
        },
        headers: {
          Authorization:
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c',
          'X-Signature':
            'UQvWgR8j1Pg6ep5MvmoB5MrWI1gJzWVCMAFeY+aTRnh4XkpZcMRrqUwJl0oxnndIA6k0SgnDpap5dD+izke6MHzNtzwHoWue5mGKinEiqBBsTUBx6wx8e32AhvzKlLPEi+GKvQlHfWEBsh8l0AuyCvtvyUhsxQ7ZA3YSJnho3OXpdNq2R4cmkuQdMoo8P5zKFv9/tMSSWhOxJVphWbFW1qm8sLLdWBSuHnMnMUq8q+DVky/IJ6agfqovL3eFthvT1pv58TfWNABhtjvR1cYrUcjJ7vZ5m9AMeWJ85dEqNJfNsc5q6CyeHh2SmWf5LPudUx6UVuyT2oX47qwcnEhAWg=='
        }
      })
      .then((res) => {
        const transaction = []
        for (const i in res.data.payload.data) {
          transaction.push({
            id: res.data.payload.data[i]._id,
            invoice_no: res.data.payload.data[i].invoice_no,
            vendor: res.data.payload.data[i].vendor,
            bill_date: res.data.payload.data[i].created_at,
            bank_dest: res.data.payload.data[i].destination.general_bank_code,
            currency: 'IDR',
            total_amount: res.data.payload.data[i].amount,
            bank_source: res.data.payload.data[i].bank_code,
            created_by: res.data.payload.data[i].created_by.user_id,
            release_status:
              res.data.payload.data[i].status === 'draft_1'
                ? 'Waiting Approval'
                : res.data.payload.data[i].status_desc
          })
        }
        self.transaction = transaction
        console.log(self.transaction)
        mock.restore()
      })
      .catch((e) => {
        console.log(e)
        mock.restore()
      })
  },
  methods: {
    read(data) {
      this.items = data
      console.log(this.items)
    },
    save() {
      console.log('save')
      const self = this
      const mock = new MockAdapter(this.$axios)
      console.log('batch_number', self.batch_no)

      mock
        .onPost('/internal/payout/otp')
        .reply(
          200,
          JSON.parse(
            '{"rc": "00","message": "success","payload": {"challeng_code": "123456"}}'
          )
        )
      this.$axios
        .post('/internal/payout/otp', {
          data: { batch_no: self.batch_no },
          headers: {
            Authorization:
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c',
            'X-Signature':
              'UQvWgR8j1Pg6ep5MvmoB5MrWI1gJzWVCMAFeY+aTRnh4XkpZcMRrqUwJl0oxnndIA6k0SgnDpap5dD+izke6MHzNtzwHoWue5mGKinEiqBBsTUBx6wx8e32AhvzKlLPEi+GKvQlHfWEBsh8l0AuyCvtvyUhsxQ7ZA3YSJnho3OXpdNq2R4cmkuQdMoo8P5zKFv9/tMSSWhOxJVphWbFW1qm8sLLdWBSuHnMnMUq8q+DVky/IJ6agfqovL3eFthvT1pv58TfWNABhtjvR1cYrUcjJ7vZ5m9AMeWJ85dEqNJfNsc5q6CyeHh2SmWf5LPudUx6UVuyT2oX47qwcnEhAWg=='
          }
        })
        .then((res) => {
          console.log(res.data.payload.challeng_code)
          self.challeng_code = res.data.payload.challeng_code
          mock.restore()
        })
        .catch((e) => {
          console.log(e)
          mock.restore()
        })
      this.dialog = !this.dialog
    },
    cancel() {
      console.log('cancel')
      this.$router.push('/')
    },
    agree(otp) {
      this.loadingbtn = true
      console.log('agree')
      console.log(otp)
      setTimeout(() => {
        if (this.otpvalues === this.challeng_code) {
          this.dialog = false
          this.alert = false
          this.success = true
          this.showselected = false
          console.log('alert ' + this.alert)
          console.log('items selected', this.items)
          // for (const index in this.items) {
          //   console.log(this.items[index])
          //   this.transaction.splice(
          //     this.transaction.indexOf(this.items[index]),
          //     1
          //   )
          // }
          console.log(this.transaction)
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
