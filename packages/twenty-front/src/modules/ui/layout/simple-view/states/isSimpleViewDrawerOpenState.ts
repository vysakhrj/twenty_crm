import { atom } from 'recoil';

export const isSimpleViewDrawerOpenState = atom<boolean>({
  key: 'isSimpleViewDrawerOpen',
  default: false,
});
