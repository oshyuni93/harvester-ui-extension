<script>
import Loading from '@shell/components/Loading';
import { HCI } from '../../../../../types';
import NovncConsoleWrapper from '../../../../../components/novnc/NovncConsoleWrapper.vue';

export default {
  components: { NovncConsoleWrapper, Loading },

  async fetch() {
    this.rows = await this.$store.dispatch('harvester/findAll', { type: HCI.VMI });
  },

  data() {
    return { uid: this.$route.params.uid };
  },

  computed: {
    vmi() {
      const vmiList = this.$store.getters['harvester/all'](HCI.VMI) || [];

      const vmi = vmiList.find( (VMI) => {
        return VMI?.metadata?.ownerReferences?.[0]?.uid === this.uid;
      });

      return vmi;
    },
  },

  mounted() {
    window.addEventListener('beforeunload', () => {
      this.$refs.console.close();
    });
  },

  head() {
    return { title: this.vmi?.metadata?.name };
  },
};
</script>

<template>
  <Loading v-if="$fetchState.pending" />
  <NovncConsoleWrapper
    v-else
    ref="console"
    v-model:value="vmi"
    class="novnc-wrapper"
  />
</template>

<style lang="scss" scoped>
.novnc-wrapper {
  height: 100vh;
  width: 100vw;
  background-color: #141419;
  display: flex;
  flex-direction: column;
  overflow: hidden;

  :deep(#app),
  :deep(.vm-console) {
    height: 100%;
    width: 100%;
    display: flex;
    flex-direction: column;
    flex: 1;
    background-color: #141419;
  }

  :deep(.combination-keys) {
    flex: 0 0 34px;
    height: 34px;
  }

  :deep(.novnc-console),
  :deep(.novnc-view) {
    flex: 1;
    height: 100%;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: #000;
  }
}
</style>
