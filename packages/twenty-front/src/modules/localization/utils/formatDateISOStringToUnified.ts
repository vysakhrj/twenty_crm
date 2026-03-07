import {
  UNIFIED_DATE_ONLY_FORMAT,
  UNIFIED_DATE_TIME_FORMAT,
} from '@/localization/constants/UnifiedDateFormat';
import { isValid } from 'date-fns';
import { format } from 'date-fns';
import { enUS } from 'date-fns/locale';

// Format in local timezone for use without UserContext (e.g. Simple view, inline text).
export const formatDateISOStringToUnifiedDateTime = (isoString: string): string => {
  const date = new Date(isoString);
  if (!isValid(date)) return '';
  const formatted = format(date, UNIFIED_DATE_TIME_FORMAT, { locale: enUS });
  return formatted.replace(/\s+([AP]M)$/i, (_, ampm) => ` ${ampm.toLowerCase()}`);
};

export const formatDateISOStringToUnifiedDate = (isoString: string): string => {
  const date = new Date(isoString);
  if (!isValid(date)) return '';
  return format(date, UNIFIED_DATE_ONLY_FORMAT, { locale: enUS });
};
