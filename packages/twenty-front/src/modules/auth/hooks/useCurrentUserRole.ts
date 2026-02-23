import { currentWorkspaceMemberState } from '@/auth/states/currentWorkspaceMemberState';
import { currentUserState } from '@/auth/states/currentUserState';
import { currentUserWorkspaceState } from '@/auth/states/currentUserWorkspaceState';
import { useRecoilValue } from 'recoil';
import { PermissionFlagType } from '~/generated/graphql';

export const useCurrentUserRole = () => {
  const currentUser = useRecoilValue(currentUserState);
  const currentWorkspaceMember = useRecoilValue(currentWorkspaceMemberState);
  const currentUserWorkspace = useRecoilValue(currentUserWorkspaceState);

  const permissionFlags = currentUserWorkspace?.permissionFlags ?? [];
  const objectsPermissions = currentUserWorkspace?.objectsPermissions ?? [];

  // A user is considered an admin if they have ROLES permission or full admin panel access
  const isAdmin =
    permissionFlags.includes(PermissionFlagType.ROLES) ||
    permissionFlags.includes(PermissionFlagType.WORKSPACE_MEMBERS) ||
    currentUser?.canAccessFullAdminPanel === true;

  // Helper function to get permissions for a specific object
  const getObjectPermissions = (objectMetadataId: string) => {
    return objectsPermissions.find(
      (perm) => perm.objectMetadataId === objectMetadataId,
    );
  };

  // Check if user can only read own records for any object
  const hasAnyOwnRecordsOnlyPermission = objectsPermissions.some(
    (perm) => perm.canReadOwnObjectRecordsOnly,
  );

  return {
    permissionFlags,
    objectsPermissions,
    isAdmin,
    hasAnyOwnRecordsOnlyPermission,
    currentWorkspaceMemberId: currentWorkspaceMember?.id,
    getObjectPermissions,
  };
};
