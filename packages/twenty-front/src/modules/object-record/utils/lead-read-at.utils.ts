import { isDefined } from 'twenty-shared/utils';

export const isReadAtValueEmpty = (readAt: unknown): boolean => {
  if (!isDefined(readAt)) {
    return true;
  }

  if (typeof readAt === 'string') {
    const normalizedReadAt = readAt.trim().toLowerCase();

    return (
      normalizedReadAt.length === 0 ||
      normalizedReadAt === 'null' ||
      normalizedReadAt === 'undefined'
    );
  }

  return false;
};

export const getLeadAssigneeIdFromRecord = (
  record: Record<string, unknown>,
): string | null => {
  const assigneeId =
    typeof record.assigneeId === 'string' && record.assigneeId.length > 0
      ? record.assigneeId
      : null;
  const assigneeRelation =
    record.assignee &&
    typeof record.assignee === 'object' &&
    !Array.isArray(record.assignee)
      ? (record.assignee as Record<string, unknown>)
      : null;
  const assigneeRelationId =
    assigneeRelation && typeof assigneeRelation.id === 'string'
      ? assigneeRelation.id
      : null;

  return assigneeId ?? assigneeRelationId;
};

export const isAssignedSalespersonViewingLead = ({
  leadAssigneeId,
  currentMemberId,
}: {
  leadAssigneeId: string | null;
  currentMemberId: string | null;
}): boolean => {
  return (
    isDefined(leadAssigneeId) &&
    leadAssigneeId !== '' &&
    isDefined(currentMemberId) &&
    currentMemberId !== '' &&
    currentMemberId === leadAssigneeId
  );
};
