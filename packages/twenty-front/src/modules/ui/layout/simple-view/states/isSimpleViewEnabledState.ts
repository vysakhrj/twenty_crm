import { atom } from 'recoil';

import { localStorageEffect } from '~/utils/recoil/localStorageEffect';

export const isSimpleViewEnabledState = atom<boolean>({
  key: 'isSimpleViewEnabled',
  default: true,
  effects: [localStorageEffect()],
});
