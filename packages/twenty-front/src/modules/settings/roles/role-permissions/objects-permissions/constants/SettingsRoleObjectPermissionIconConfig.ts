import {
  type IconComponent,
  IconEye,
  IconEyeOff,
  IconPencil,
  IconPencilOff,
  IconTrash,
  IconTrashOff,
  IconTrashX,
  IconTrashXOff,
  IconUser,
} from 'twenty-ui/display';

type SettingsRoleObjectPermissionIconConfig = {
  Icon: IconComponent;
  IconForbidden: IconComponent;
};

export type SettingsRoleObjectPermissionKey =
  | 'canReadObjectRecords'
  | 'canUpdateObjectRecords'
  | 'canSoftDeleteObjectRecords'
  | 'canDestroyObjectRecords';

export type SettingsRolePermissionKey =
  | SettingsRoleObjectPermissionKey
  | 'canReadOwnObjectRecordsOnly';

export const SETTINGS_ROLE_OBJECT_PERMISSION_ICON_CONFIG: Record<
  SettingsRolePermissionKey,
  SettingsRoleObjectPermissionIconConfig
> = {
  canReadObjectRecords: {
    Icon: IconEye,
    IconForbidden: IconEyeOff,
  },
  canReadOwnObjectRecordsOnly: {
    Icon: IconUser,
    IconForbidden: IconEyeOff,
  },
  canUpdateObjectRecords: {
    Icon: IconPencil,
    IconForbidden: IconPencilOff,
  },
  canSoftDeleteObjectRecords: {
    Icon: IconTrash,
    IconForbidden: IconTrashOff,
  },
  canDestroyObjectRecords: {
    Icon: IconTrashX,
    IconForbidden: IconTrashXOff,
  },
};
