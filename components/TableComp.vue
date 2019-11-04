<template>
  <v-data-table
    v-model="selected"
    :headers="headers"
    :items="items"
    :items-per-page="5"
    item-key="name"
    :show-select="showselected"
    class="elevation-1"
    @input="listening"
  ></v-data-table>
</template>

<script>
export default {
  props: {
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
