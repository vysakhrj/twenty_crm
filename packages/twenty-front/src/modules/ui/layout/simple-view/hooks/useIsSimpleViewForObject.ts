import { useRecoilValue } from 'recoil';

import { isSimpleViewEnabledState } from '@/ui/layout/simple-view/states/isSimpleViewEnabledState';
import { simpleViewObjectsState } from '@/ui/layout/simple-view/states/simpleViewObjectsState';

export const useIsSimpleViewForObject = (
  objectNameSingular: string,
): boolean => {
  const isSimpleViewEnabled = useRecoilValue(isSimpleViewEnabledState);
  const simpleViewObjects = useRecoilValue(simpleViewObjectsState);

  return isSimpleViewEnabled && simpleViewObjects.includes(objectNameSingular);
};
