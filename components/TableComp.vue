<template>
  <v-data-table
    v-model="selected"
    :headers="headers"
    :items="items"
    :items-per-page="5"
    :item-key="itemKey"
    :show-select="showselected"
    hide-default-footer
    class="elevation-1"
    @input="listening"
  ></v-data-table>
</template>

<script>
export default {
  props: {
    itemKey: {
      type: String,
      required: false,
      default: 'id'
    },
    showselected: {
      type: Boolean,
      required: false,
      default: false
    },
    headers: {
      type: Array,
      required: false
    },
    items: {
      type: Array,
      required: false
    }
  },
  data() {
    return {
      selected: []
    }
  },
  methods: {
    listening() {
      this.$emit('listen', this.selected)
    }
  }
}
</script>
