<script>
import { PRODUCT_NAME } from '../../../config/harvester';
import { HCI } from '../../../types';

export default {
  beforeCreate() {
    this.$router.replace({
      name:   `${ PRODUCT_NAME }-c-cluster-resource`,
      params: {
        ...this.$router.currentRoute.params,
        // product:  PRODUCT_NAME,
        product:  `Infinitystack`,
        resource: HCI.DASHBOARD
      }
    });
  }
};
</script>

<template>
  <!--
  <div>
    This is harvester Dashboard.
  </div>
  -->
  <div>
    This is Infinitystack Dashboard.
  </div>
</template>
