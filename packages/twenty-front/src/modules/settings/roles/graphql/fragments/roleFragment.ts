import { gql } from '@apollo/client';

export const ROLE_FRAGMENT = gql`
  fragment RoleFragment on Role {
    id
    label
    description
    icon
    canUpdateAllSettings
    canAccessAllTools
    isEditable
    canReadAllObjectRecords
    canReadOwnObjectRecordsOnly
    canUpdateAllObjectRecords
    canSoftDeleteAllObjectRecords
    canDestroyAllObjectRecords
    canBeAssignedToUsers
    canBeAssignedToAgents
    canBeAssignedToApiKeys
  }
`;
