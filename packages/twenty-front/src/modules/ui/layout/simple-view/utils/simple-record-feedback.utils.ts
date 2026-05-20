export type SimpleRecordFeedbackEntry = {
  content: string;
  createdAt: string;
};

const FEEDBACK_ENTRY_PATTERN =
  /<!-- feedback-entry:([^>]+) -->\s*([\s\S]*?)(?=<!-- feedback-entry:|$)/g;

export const parseFeedbackEntriesFromMarkdown = (
  markdown: string | null | undefined,
  fallbackDate?: string,
): SimpleRecordFeedbackEntry[] => {
  if (!markdown?.trim()) {
    return [];
  }

  const entries: SimpleRecordFeedbackEntry[] = [];
  let match = FEEDBACK_ENTRY_PATTERN.exec(markdown);

  while (match !== null) {
    const content = match[2].trim();
    if (content.length > 0) {
      entries.push({
        createdAt: match[1].trim(),
        content,
      });
    }
    match = FEEDBACK_ENTRY_PATTERN.exec(markdown);
  }

  FEEDBACK_ENTRY_PATTERN.lastIndex = 0;

  if (entries.length === 0) {
    return [
      {
        createdAt: fallbackDate ?? new Date().toISOString(),
        content: markdown.trim(),
      },
    ];
  }

  return entries.sort(
    (firstEntry, secondEntry) =>
      new Date(secondEntry.createdAt).getTime() -
      new Date(firstEntry.createdAt).getTime(),
  );
};

export const appendFeedbackEntryToMarkdown = ({
  content,
  createdAt = new Date().toISOString(),
  existingMarkdown,
}: {
  content: string;
  createdAt?: string;
  existingMarkdown: string | null | undefined;
}): string => {
  const trimmedContent = content.trim();
  const entry = `<!-- feedback-entry:${createdAt} -->\n${trimmedContent}`;
  const baseMarkdown = existingMarkdown?.trim();

  return baseMarkdown ? `${baseMarkdown}\n\n${entry}` : entry;
};

export const formatFeedbackDisplayDate = (isoDate: string): string => {
  const date = new Date(isoDate);

  if (Number.isNaN(date.getTime())) {
    return isoDate;
  }

  return new Intl.DateTimeFormat('en-GB', {
    day: 'numeric',
    month: 'short',
    year: 'numeric',
  }).format(date);
};

export const formatFeedbackDisplayDateTime = (isoDate: string): string => {
  const date = new Date(isoDate);

  if (Number.isNaN(date.getTime())) {
    return isoDate;
  }

  return new Intl.DateTimeFormat('en-GB', {
    day: 'numeric',
    hour: 'numeric',
    hour12: true,
    minute: '2-digit',
    month: 'short',
    year: 'numeric',
  }).format(date);
};
