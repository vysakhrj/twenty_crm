import { useCommandMenu } from '@/command-menu/hooks/useCommandMenu';
import { useOpenRecordsSearchPageInCommandMenu } from '@/command-menu/hooks/useOpenRecordsSearchPageInCommandMenu';
import { isCommandMenuOpenedState } from '@/command-menu/states/isCommandMenuOpenedState';
import { MAIN_CONTEXT_STORE_INSTANCE_ID } from '@/context-store/constants/MainContextStoreInstanceId';
import { contextStoreCurrentObjectMetadataItemIdComponentState } from '@/context-store/states/contextStoreCurrentObjectMetadataItemIdComponentState';
import { useDefaultHomePagePath } from '@/navigation/hooks/useDefaultHomePagePath';
import { useOpenSettingsMenu } from '@/navigation/hooks/useOpenSettings';
import { useFilteredObjectMetadataItems } from '@/object-metadata/hooks/useFilteredObjectMetadataItems';
import { isSimpleViewEnabledState } from '@/ui/layout/simple-view/states/isSimpleViewEnabledState';
import { isNavigationDrawerExpandedState } from '@/ui/navigation/states/isNavigationDrawerExpanded';
import { useRecoilComponentState } from '@/ui/utilities/state/component-state/hooks/useRecoilComponentState';
import { useNavigate } from 'react-router-dom';
import { useRecoilState, useSetRecoilState } from 'recoil';
import {
  type IconComponent,
  IconEye,
  IconList,
  IconSearch,
  IconSettings,
} from 'twenty-ui/display';
import { NavigationBar } from 'twenty-ui/navigation';
import { useIsSettingsPage } from '@/navigation/hooks/useIsSettingsPage';
import { currentMobileNavigationDrawerState } from '@/navigation/states/currentMobileNavigationDrawerState';

type NavigationBarItemName =
  | 'main'
  | 'search'
  | 'simple'
  | 'tasks'
  | 'settings';

export const MobileNavigationBar = () => {
  const navigate = useNavigate();
  const { defaultHomePagePath } = useDefaultHomePagePath();
  const [isCommandMenuOpened] = useRecoilState(isCommandMenuOpenedState);
  const { closeCommandMenu } = useCommandMenu();
  const { openRecordsSearchPage } = useOpenRecordsSearchPageInCommandMenu();
  const isSettingsPage = useIsSettingsPage();
  const [isNavigationDrawerExpanded, setIsNavigationDrawerExpanded] =
    useRecoilState(isNavigationDrawerExpandedState);
  const [currentMobileNavigationDrawer, setCurrentMobileNavigationDrawer] =
    useRecoilState(currentMobileNavigationDrawerState);
  const { openSettingsMenu } = useOpenSettingsMenu();
  const { alphaSortedActiveNonSystemObjectMetadataItems } =
    useFilteredObjectMetadataItems();
  const setIsSimpleViewEnabled = useSetRecoilState(isSimpleViewEnabledState);

  const [, setContextStoreCurrentObjectMetadataItemId] =
    useRecoilComponentState(
      contextStoreCurrentObjectMetadataItemIdComponentState,
      MAIN_CONTEXT_STORE_INSTANCE_ID,
    );

  const activeItemName = isNavigationDrawerExpanded
    ? currentMobileNavigationDrawer
    : isCommandMenuOpened
      ? 'search'
      : isSettingsPage
        ? 'settings'
        : 'main';

  const items: {
    name: NavigationBarItemName;
    Icon: IconComponent;
    onClick: () => void;
  }[] = [
    {
      name: 'main',
      Icon: IconList,
      onClick: () => {
        closeCommandMenu();
        setIsNavigationDrawerExpanded(
          (previousIsOpen) => activeItemName !== 'main' || !previousIsOpen,
        );
        setCurrentMobileNavigationDrawer('main');

        if (isSettingsPage) {
          navigate(defaultHomePagePath);
        }
      },
    },
    {
      name: 'search',
      Icon: IconSearch,
      onClick: () => {
        setIsNavigationDrawerExpanded(false);
        closeCommandMenu();

        if (isSettingsPage) {
          const firstObjectMetadataItem =
            alphaSortedActiveNonSystemObjectMetadataItems[0];
          if (firstObjectMetadataItem !== undefined) {
            setContextStoreCurrentObjectMetadataItemId(
              firstObjectMetadataItem.id,
            );
          }
        }

        openRecordsSearchPage();
      },
    },
    {
      name: 'simple',
      Icon: IconEye,
      onClick: () => {
        closeCommandMenu();
        setIsNavigationDrawerExpanded(false);
        setIsSimpleViewEnabled(true);
      },
    },
    {
      name: 'settings',
      Icon: IconSettings,
      onClick: () => {
        closeCommandMenu();
        openSettingsMenu();
      },
    },
  ];

  return <NavigationBar activeItemName={activeItemName} items={items} />;
};
