import { isNonEmptyString } from '@sniptt/guards';

// IANA legacy/deprecated names that some PostgreSQL builds do not recognize.
// Maps to the canonical name that PostgreSQL accepts.
const POSTGRES_TIMEZONE_ALIASES: Record<string, string> = {
  'Asia/Calcutta': 'Asia/Kolkata',
};

export const normalizeTimeZoneForPostgres = (timeZone: string): string => {
  if (!isNonEmptyString(timeZone)) {
    return timeZone;
  }
  const normalized = POSTGRES_TIMEZONE_ALIASES[timeZone];
  return normalized ?? timeZone;
};
