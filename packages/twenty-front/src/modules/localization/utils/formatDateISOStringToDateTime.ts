import { UNIFIED_DATE_TIME_FORMAT } from '@/localization/constants/UnifiedDateFormat';
import { type DateFormat } from '@/localization/constants/DateFormat';
import { type TimeFormat } from '@/localization/constants/TimeFormat';
import { isValid } from 'date-fns';
import { formatInTimeZone } from 'date-fns-tz';

export const formatDateISOStringToDateTime = ({
  date,
  timeZone,
  dateFormat: _dateFormat,
  timeFormat: _timeFormat,
  localeCatalog,
}: {
  date: string;
  timeZone: string;
  dateFormat: DateFormat;
  timeFormat: TimeFormat;
  localeCatalog: Locale;
}) => {
  const parsedDate = new Date(date);

  if (!isValid(parsedDate)) {
    return '';
  }

  const formatted = formatInTimeZone(
    parsedDate,
    timeZone,
    UNIFIED_DATE_TIME_FORMAT,
    { locale: localeCatalog },
  );
  return formatted.replace(/\s*([ap]m)$/i, (_, ampm) => ampm.toUpperCase());
};
