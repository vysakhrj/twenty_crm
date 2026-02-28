import {
  type WorkspaceMemberDateFormatEnum,
  type WorkspaceMemberNumberFormatEnum,
  type WorkspaceMemberTimeFormatEnum,
} from '~/generated/graphql';

export type ColorScheme = 'Dark' | 'Light' | 'System';

export type WorkspaceMember = {
  __typename: 'WorkspaceMember';
  id: string;
  name: {
    __typename?: 'FullName';
    firstName: string;
    lastName: string;
  };
  avatarUrl?: string | null;
  locale: string | null;
  colorScheme: ColorScheme;
  createdAt: string;
  updatedAt: string;
  userEmail: string;
  userId: string;
  timeZone?: string | null;
  dateFormat?: WorkspaceMemberDateFormatEnum | null;
  timeFormat?: WorkspaceMemberTimeFormatEnum | null;
  numberFormat?: WorkspaceMemberNumberFormatEnum | null;
  calendarStartDay?: number | null;
  availabilityHours?: number | null;
  availabilityStartTime?: string | null;
  availabilityEndTime?: string | null;
  availableDays?: string[] | null;
  leaveStartDate?: string | null;
  leaveEndDate?: string | null;
};

export type WorkspaceInvitation = {
  __typename: 'WorkspaceInvitation';
  id: string;
  email: string;
  expiresAt: string;
  value?: string | null;
};
