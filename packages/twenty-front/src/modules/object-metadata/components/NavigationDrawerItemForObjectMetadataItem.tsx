import { useCurrentUserRole } from '@/auth/hooks/useCurrentUserRole';
import { MAIN_CONTEXT_STORE_INSTANCE_ID } from '@/context-store/constants/MainContextStoreInstanceId';
import { contextStoreCurrentViewIdComponentState } from '@/context-store/states/contextStoreCurrentViewIdComponentState';
import { lastVisitedViewPerObjectMetadataItemState } from '@/navigation/states/lastVisitedViewPerObjectMetadataItemState';
import { type ObjectMetadataItem } from '@/object-metadata/types/ObjectMetadataItem';
import { NavigationDrawerItem } from '@/ui/navigation/navigation-drawer/components/NavigationDrawerItem';
import { NavigationDrawerItemsCollapsableContainer } from '@/ui/navigation/navigation-drawer/components/NavigationDrawerItemsCollapsableContainer';
import { NavigationDrawerSubItem } from '@/ui/navigation/navigation-drawer/components/NavigationDrawerSubItem';
import { getNavigationSubItemLeftAdornment } from '@/ui/navigation/navigation-drawer/utils/getNavigationSubItemLeftAdornment';
import { useRecoilComponentValue } from '@/ui/utilities/state/component-state/hooks/useRecoilComponentValue';
import { coreViewsFromObjectMetadataItemFamilySelector } from '@/views/states/selectors/coreViewsFromObjectMetadataItemFamilySelector';
import { useLocation } from 'react-router-dom';
import { useRecoilValue } from 'recoil';
import { AppPath } from 'twenty-shared/types';
import { getAppPath } from 'twenty-shared/utils';
import { useIcons } from 'twenty-ui/display';
import { AnimatedExpandableContainer } from 'twenty-ui/layout';

export type NavigationDrawerItemForObjectMetadataItemProps = {
  objectMetadataItem: ObjectMetadataItem;
};

export const NavigationDrawerItemForObjectMetadataItem = ({
  objectMetadataItem,
}: NavigationDrawerItemForObjectMetadataItemProps) => {
  const views = useRecoilValue(
    coreViewsFromObjectMetadataItemFamilySelector({
      objectMetadataItemId: objectMetadataItem.id,
    }),
  );

  const { getObjectPermissions, isAdmin } = useCurrentUserRole();

  // Get permissions for this specific object
  const objectPermissions = getObjectPermissions(objectMetadataItem.id);
  const canReadOwnObjectRecordsOnly =
    objectPermissions?.canReadOwnObjectRecordsOnly ?? false;

  const contextStoreCurrentViewId = useRecoilComponentValue(
    contextStoreCurrentViewIdComponentState,
    MAIN_CONTEXT_STORE_INSTANCE_ID,
  );

  const lastVisitedViewPerObjectMetadataItem = useRecoilValue(
    lastVisitedViewPerObjectMetadataItemState,
  );

  const lastVisitedViewId =
    lastVisitedViewPerObjectMetadataItem?.[objectMetadataItem.id];

  const { getIcon } = useIcons();
  const currentPath = useLocation().pathname;

  // Show all views - role-based filtering is applied at data level by RoleBasedRecordFilterEffect
  // This ensures users can use different view types (list, kanban) while still only seeing their data
  const filteredViews = views;

  // Determine the default view ID for navigation
  // For restricted users, use the first allowed view instead of last visited
  const defaultViewId =
    canReadOwnObjectRecordsOnly && !isAdmin && filteredViews.length > 0
      ? filteredViews[0]?.id
      : lastVisitedViewId;

  const navigationPath = getAppPath(
    AppPath.RecordIndexPage,
    { objectNamePlural: objectMetadataItem.namePlural },
    defaultViewId ? { viewId: defaultViewId } : undefined,
  );

  const isActive =
    currentPath ===
      getAppPath(AppPath.RecordIndexPage, {
        objectNamePlural: objectMetadataItem.namePlural,
      }) ||
    currentPath.includes(
      getAppPath(AppPath.RecordShowPage, {
        objectNameSingular: objectMetadataItem.nameSingular,
        objectRecordId: '',
      }) + '/',
    );

  const shouldSubItemsBeDisplayed = isActive && filteredViews.length > 1;

  const sortedObjectMetadataViews = [...filteredViews].sort(
    (viewA, viewB) => viewA.position - viewB.position,
  );

  const selectedSubItemIndex = sortedObjectMetadataViews.findIndex(
    (view) => contextStoreCurrentViewId === view.id,
  );

  const subItemArrayLength = sortedObjectMetadataViews.length;

  return (
    <NavigationDrawerItemsCollapsableContainer
      isGroup={shouldSubItemsBeDisplayed}
    >
      <NavigationDrawerItem
        key={objectMetadataItem.id}
        label={objectMetadataItem.labelPlural}
        to={navigationPath}
        Icon={getIcon(objectMetadataItem.icon)}
        active={isActive}
      />

      <AnimatedExpandableContainer
        isExpanded={shouldSubItemsBeDisplayed}
        dimension="height"
        mode="fit-content"
        containAnimation
      >
        {sortedObjectMetadataViews.map((view, index) => (
          <NavigationDrawerSubItem
            label={view.name}
            to={getAppPath(
              AppPath.RecordIndexPage,
              { objectNamePlural: objectMetadataItem.namePlural },
              { viewId: view.id },
            )}
            active={contextStoreCurrentViewId === view.id}
            subItemState={getNavigationSubItemLeftAdornment({
              index,
              arrayLength: subItemArrayLength,
              selectedIndex: selectedSubItemIndex,
            })}
            Icon={getIcon(view.icon)}
            key={view.id}
          />
        ))}
      </AnimatedExpandableContainer>
    </NavigationDrawerItemsCollapsableContainer>
  );
};
