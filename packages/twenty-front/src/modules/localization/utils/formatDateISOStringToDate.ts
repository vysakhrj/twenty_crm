import { UNIFIED_DATE_ONLY_FORMAT } from '@/localization/constants/UnifiedDateFormat';
import { type DateFormat } from '@/localization/constants/DateFormat';
import { formatInTimeZone } from 'date-fns-tz';

export const formatDateISOStringToDate = ({
  date,
  timeZone,
  dateFormat: _dateFormat,
  localeCatalog,
}: {
  date: string;
  timeZone: string;
  dateFormat: DateFormat;
  localeCatalog?: Locale;
}) => {
  return formatInTimeZone(new Date(date), timeZone, UNIFIED_DATE_ONLY_FORMAT, {
    locale: localeCatalog,
  });
};
