import {
  getLeadAssigneeIdFromRecord,
  isAssignedSalespersonViewingLead,
  isReadAtValueEmpty,
} from '@/object-record/utils/lead-read-at.utils';

describe('lead-read-at.utils', () => {
  describe('isReadAtValueEmpty', () => {
    it('returns true for nullish and empty readAt values', () => {
      expect(isReadAtValueEmpty(null)).toBe(true);
      expect(isReadAtValueEmpty(undefined)).toBe(true);
      expect(isReadAtValueEmpty('')).toBe(true);
      expect(isReadAtValueEmpty('   ')).toBe(true);
      expect(isReadAtValueEmpty('null')).toBe(true);
      expect(isReadAtValueEmpty('undefined')).toBe(true);
    });

    it('returns false when readAt has a timestamp', () => {
      expect(isReadAtValueEmpty('2026-03-02T13:34:06.021Z')).toBe(false);
    });
  });

  describe('getLeadAssigneeIdFromRecord', () => {
    it('prefers assigneeId over relation id', () => {
      expect(
        getLeadAssigneeIdFromRecord({
          assigneeId: 'assignee-1',
          assignee: { id: 'assignee-2' },
        }),
      ).toBe('assignee-1');
    });

    it('falls back to assignee relation id', () => {
      expect(
        getLeadAssigneeIdFromRecord({
          assignee: { id: 'assignee-2' },
        }),
      ).toBe('assignee-2');
    });
  });

  describe('isAssignedSalespersonViewingLead', () => {
    it('returns true only when the current member is the assignee', () => {
      expect(
        isAssignedSalespersonViewingLead({
          leadAssigneeId: 'assignee-1',
          currentMemberId: 'assignee-1',
        }),
      ).toBe(true);
    });

    it('returns false for admins or other members', () => {
      expect(
        isAssignedSalespersonViewingLead({
          leadAssigneeId: 'assignee-1',
          currentMemberId: 'member-2',
        }),
      ).toBe(false);
      expect(
        isAssignedSalespersonViewingLead({
          leadAssigneeId: null,
          currentMemberId: 'member-2',
        }),
      ).toBe(false);
    });
  });
});
