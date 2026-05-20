import {
  appendFeedbackEntryToMarkdown,
  formatFeedbackDisplayDate,
  formatFeedbackDisplayDateTime,
  parseFeedbackEntriesFromMarkdown,
} from '@/ui/layout/simple-view/utils/simple-record-feedback.utils';

describe('simple-record-feedback.utils', () => {
  describe('parseFeedbackEntriesFromMarkdown', () => {
    it('returns empty array for empty markdown', () => {
      expect(parseFeedbackEntriesFromMarkdown('')).toEqual([]);
      expect(parseFeedbackEntriesFromMarkdown(null)).toEqual([]);
    });

    it('parses structured feedback entries', () => {
      const markdown = `<!-- feedback-entry:2026-03-17T10:00:00.000Z -->
Older feedback.

<!-- feedback-entry:2026-03-18T10:00:00.000Z -->
Newer feedback.`;

      expect(parseFeedbackEntriesFromMarkdown(markdown)).toEqual([
        {
          createdAt: '2026-03-18T10:00:00.000Z',
          content: 'Newer feedback.',
        },
        {
          createdAt: '2026-03-17T10:00:00.000Z',
          content: 'Older feedback.',
        },
      ]);
    });

    it('wraps legacy unstructured markdown as a single entry', () => {
      expect(
        parseFeedbackEntriesFromMarkdown(
          'Legacy note',
          '2026-03-18T10:00:00.000Z',
        ),
      ).toEqual([
        {
          createdAt: '2026-03-18T10:00:00.000Z',
          content: 'Legacy note',
        },
      ]);
    });
  });

  describe('appendFeedbackEntryToMarkdown', () => {
    it('appends a structured feedback entry', () => {
      expect(
        appendFeedbackEntryToMarkdown({
          content: 'New feedback',
          createdAt: '2026-03-18T10:00:00.000Z',
          existingMarkdown:
            '<!-- feedback-entry:2026-03-17T10:00:00.000Z -->\nOld',
        }),
      ).toBe(
        '<!-- feedback-entry:2026-03-17T10:00:00.000Z -->\nOld\n\n<!-- feedback-entry:2026-03-18T10:00:00.000Z -->\nNew feedback',
      );
    });
  });

  describe('formatFeedbackDisplayDate', () => {
    it('formats dates for accordion headers', () => {
      expect(formatFeedbackDisplayDate('2026-03-18T10:00:00.000Z')).toMatch(
        /18 Mar 2026/,
      );
    });
  });

  describe('formatFeedbackDisplayDateTime', () => {
    it('includes time in formatted output', () => {
      const formatted = formatFeedbackDisplayDateTime(
        '2026-03-18T10:00:00.000Z',
      );
      expect(formatted).toMatch(/18 Mar 2026/);
    });
  });
});
