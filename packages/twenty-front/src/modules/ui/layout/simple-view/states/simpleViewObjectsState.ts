import { atom } from 'recoil';

import { localStorageEffect } from '~/utils/recoil/localStorageEffect';

export const simpleViewObjectsState = atom<string[]>({
  key: 'simpleViewObjects',
  default: ['lead'],
  effects: [localStorageEffect()],
});
