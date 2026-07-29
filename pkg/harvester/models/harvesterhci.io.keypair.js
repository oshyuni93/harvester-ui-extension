import { get } from '@shell/utils/object';
import { findBy } from '@shell/utils/array';
import HarvesterResource from './harvester';

export default class HciKeypair extends HarvesterResource {
  get stateDisplay() {
    const conditions = get(this, 'status.conditions');
    const status = (findBy(conditions, 'type', 'validated') || {}).status ;

    return status === 'True' ? 'Validated' : 'Not Validated';
  }

  get availableActions() {
    const toFilter = ['goToEditYaml', 'goToViewYaml', 'download', 'downloadYaml', 'viewEditYaml'];

    return super._availableActions.filter((action) => !toFilter.includes(action.action));
  }
}
