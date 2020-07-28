<template>
  <form>
    <v-text-field
      v-bind="$attrs"
      :value="value"
      @input="$emit('input', $event.target.value)"
      >gege</v-text-field
    >
    <!-- <div class="my-2">
      <v-btn color="primary" @click.prevent="onSubmitBor">On Submit</v-btn>
    </div> -->
  </form>
</template>

<script>
export default {
  props: {
    controlType: {
      type: String,
      default: 'input'
    },
    value: {
      type: String,
      default: ''
    }
  }
}
</script>
