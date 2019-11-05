<template>
  <div>
    <h1 style="color:#1d62db;">Payout List</h1>
    <v-data-table
      :headers="headers"
      :items="desserts"
      class="elevation-1"
      sort-by="created_at"
      hide-default-footer
    >
      <template v-slot:item.action="{ item }">
        <v-btn color="primary" @click="gotodetail(item)">details</v-btn>
      </template>
      <template v-slot:no-data>
        <v-btn color="primary" @click="initialize">Reset</v-btn>
      </template>
    </v-data-table>
  </div>
</template>

<script>
export default {
  data: () => ({
    headers: [
      {
        text: 'Created Date',
        align: 'center',
        sortable: false,
        value: 'created_at'
      },
      { text: 'Reference', value: 'reference', sortable: false },
      { text: 'Total Transaction', value: 'total_trx', sortable: false },
      { text: 'Total Amount', value: 'total_amount', sortable: false },
      { text: 'Created By', value: 'created_by', sortable: false },
      { text: 'Actions', value: 'action', sortable: false }
    ],
    desserts: []
  }),

  created() {
    this.initialize()
  },

  methods: {
    initialize() {
      this.desserts = [
        {
          created_at: '28/10/2019',
          reference: 'Pay-001',
          total_trx: 2,
          total_amount: 78315688,
          created_by: 'Finance Staff',
          batch_no: '33333-22222-333333'
        },
        {
          created_at: '28/10/2019',
          reference: 'Pay-002',
          total_trx: 5,
          total_amount: 8315688,
          created_by: 'Finance Staff',
          batch_no: '11111-222222-333333'
        }
      ]
    },

    gotodetail(item) {
      console.log('Batch No ', item.batch_no)
      this.$router.push('/payout/' + item.batch_no)
      // this.editedIndex = this.desserts.indexOf(item)
      // this.editedItem = Object.assign({}, item)
      // this.dialog = true
    }

    // deleteItem(item) {
    //   const index = this.desserts.indexOf(item)
    //   confirm('Are you sure you want to delete this item?') &&
    //     this.desserts.splice(index, 1)
    // }

    // close() {
    //   this.dialog = false
    //   setTimeout(() => {
    //     this.editedItem = Object.assign({}, this.defaultItem)
    //     this.editedIndex = -1
    //   }, 300)
    // },

    // save() {
    //   if (this.editedIndex > -1) {
    //     Object.assign(this.desserts[this.editedIndex], this.editedItem)
    //   } else {
    //     this.desserts.push(this.editedItem)
    //   }
    //   this.close()
    // }
  }
}
</script>
