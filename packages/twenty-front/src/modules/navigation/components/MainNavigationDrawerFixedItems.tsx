import { useOpenAskAIPageInCommandMenu } from '@/command-menu/hooks/useOpenAskAIPageInCommandMenu';
import { useOpenRecordsSearchPageInCommandMenu } from '@/command-menu/hooks/useOpenRecordsSearchPageInCommandMenu';
import { useNotifications } from '@/notifications/hooks/useNotifications';
import { showNotificationCenterState } from '@/notifications/states/notificationsState';
import { isSimpleViewEnabledState } from '@/ui/layout/simple-view/states/isSimpleViewEnabledState';
import { NavigationDrawerItem } from '@/ui/navigation/navigation-drawer/components/NavigationDrawerItem';
import { isNavigationDrawerExpandedState } from '@/ui/navigation/states/isNavigationDrawerExpanded';
import { navigationDrawerExpandedMemorizedState } from '@/ui/navigation/states/navigationDrawerExpandedMemorizedState';
import { navigationMemorizedUrlState } from '@/ui/navigation/states/navigationMemorizedUrlState';
import { useColorScheme } from '@/ui/theme/hooks/useColorScheme';
import { useIsFeatureEnabled } from '@/workspace/hooks/useIsFeatureEnabled';
import { useLingui } from '@lingui/react/macro';
import { useLocation, useNavigate } from 'react-router-dom';
import { useRecoilState, useSetRecoilState } from 'recoil';
import { SettingsPath } from 'twenty-shared/types';
import { getSettingsPath } from 'twenty-shared/utils';
import {
  IconBell,
  IconEye,
  IconMoon,
  IconSearch,
  IconSettings,
  IconSparkles,
  IconSun,
} from 'twenty-ui/display';
import { useIsMobile } from 'twenty-ui/utilities';
import { FeatureFlagKey } from '~/generated/graphql';

export const MainNavigationDrawerFixedItems = () => {
  const isMobile = useIsMobile();
  const location = useLocation();
  const setNavigationMemorizedUrl = useSetRecoilState(
    navigationMemorizedUrlState,
  );

  const [isNavigationDrawerExpanded, setIsNavigationDrawerExpanded] =
    useRecoilState(isNavigationDrawerExpandedState);
  const setNavigationDrawerExpandedMemorized = useSetRecoilState(
    navigationDrawerExpandedMemorizedState,
  );
  const setIsSimpleViewEnabled = useSetRecoilState(isSimpleViewEnabledState);

  const navigate = useNavigate();

  const { t } = useLingui();

  const { openRecordsSearchPage } = useOpenRecordsSearchPageInCommandMenu();
  const { openAskAIPage } = useOpenAskAIPageInCommandMenu();
  const isAiEnabled = useIsFeatureEnabled(FeatureFlagKey.IS_AI_ENABLED);
  const { colorScheme, setColorScheme } = useColorScheme();

  const setShowNotificationCenter = useSetRecoilState(showNotificationCenterState);
  const { unreadCount } = useNotifications({ skipFullFetch: true });

  const handleOpenNotificationCenter = () => {
    setShowNotificationCenter(true);
  };

  return (
    !isMobile && (
      <>
        <NavigationDrawerItem
          label={t`Search`}
          Icon={IconSearch}
          onClick={openRecordsSearchPage}
          keyboard={['/']}
          mouseUpNavigation={true}
        />
        {isAiEnabled && (
          <NavigationDrawerItem
            label={t`Ask AI`}
            Icon={IconSparkles}
            onClick={() => openAskAIPage({ resetNavigationStack: true })}
            keyboard={['@']}
            mouseUpNavigation={true}
          />
        )}
        <NavigationDrawerItem
          label={t`Notifications`}
          Icon={IconBell}
          onClick={handleOpenNotificationCenter}
          count={unreadCount > 0 ? unreadCount : undefined}
        />
        <NavigationDrawerItem
          label={t`Dark mode`}
          Icon={colorScheme === 'Dark' ? IconSun : IconMoon}
          onClick={() => setColorScheme(colorScheme === 'Dark' ? 'Light' : 'Dark')}
        />
        <NavigationDrawerItem
          label={t`Simple View`}
          Icon={IconEye}
          onClick={() => setIsSimpleViewEnabled(true)}
        />
        <NavigationDrawerItem
          label={t`Settings`}
          to={getSettingsPath(SettingsPath.ProfilePage)}
          onClick={() => {
            setNavigationDrawerExpandedMemorized(isNavigationDrawerExpanded);
            setIsNavigationDrawerExpanded(true);
            setNavigationMemorizedUrl(location.pathname + location.search);
            navigate(getSettingsPath(SettingsPath.ProfilePage));
          }}
          Icon={IconSettings}
        />
      </>
    )
  );
};
