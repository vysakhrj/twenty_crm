import {
  IconCheckbox,
  type IconComponent,
  IconNotes,
  IconUserPlus,
} from 'twenty-ui/display';
export const getIconForObjectType = (
  objectType: string,
): IconComponent | undefined => {
  switch (objectType) {
    case 'note':
      return IconNotes;
    case 'task':
      return IconCheckbox;
    case 'lead':
      return IconUserPlus;
    default:
      return undefined;
  }
};
