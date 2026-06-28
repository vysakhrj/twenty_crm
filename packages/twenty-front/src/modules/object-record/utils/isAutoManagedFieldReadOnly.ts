const AUTO_MANAGED_READONLY_FIELD_NAMES = new Set(['readAt']);

export const isAutoManagedFieldReadOnly = (fieldName: string): boolean => {
  return AUTO_MANAGED_READONLY_FIELD_NAMES.has(fieldName);
};
