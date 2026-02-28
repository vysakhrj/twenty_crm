import { useCurrentUserRole } from '@/auth/hooks/useCurrentUserRole';
import { CoreObjectNameSingular } from '@/object-metadata/types/CoreObjectNameSingular';
import { useFindManyRecords } from '@/object-record/hooks/useFindManyRecords';
import { currentRecordFiltersComponentState } from '@/object-record/record-filter/states/currentRecordFiltersComponentState';
import { type RecordFilter } from '@/object-record/record-filter/types/RecordFilter';
import { useRecordIndexContextOrThrow } from '@/object-record/record-index/contexts/RecordIndexContext';
import { Dropdown } from '@/ui/layout/dropdown/components/Dropdown';
import { DropdownContent } from '@/ui/layout/dropdown/components/DropdownContent';
import { DropdownMenuItemsContainer } from '@/ui/layout/dropdown/components/DropdownMenuItemsContainer';
import { useRecoilComponentState } from '@/ui/utilities/state/component-state/hooks/useRecoilComponentState';
import { type WorkspaceMember } from '@/workspace-member/types/WorkspaceMember';
import styled from '@emotion/styled';
import { t } from '@lingui/core/macro';
import { ViewFilterOperand } from 'twenty-shared/types';
import { isDefined } from 'twenty-shared/utils';
import { Avatar, IconUser, IconUsers } from 'twenty-ui/display';
import { LightButton } from 'twenty-ui/input';
import { MenuItem } from 'twenty-ui/navigation';
import { v4 } from 'uuid';

const StyledDropdownContainer = styled.div`
  margin-left: ${({ theme }) => theme.spacing(1)};
`;

type TeamMemberFilterDropdownProps = {
  dropdownId: string;
};

export const TeamMemberFilterDropdown = ({
  dropdownId,
}: TeamMemberFilterDropdownProps) => {
  const { objectMetadataItem } = useRecordIndexContextOrThrow();
  const { isAdmin, currentWorkspaceMemberId, getObjectPermissions } =
    useCurrentUserRole();

  const { records: workspaceMembers } = useFindManyRecords<WorkspaceMember>({
    objectNameSingular: CoreObjectNameSingular.WorkspaceMember,
  });

  const [currentRecordFilters, setCurrentRecordFilters] =
    useRecoilComponentState(currentRecordFiltersComponentState);

  // Get permissions for the current object
  const objectPermissions = getObjectPermissions(objectMetadataItem.id);
  const canReadOwnObjectRecordsOnly =
    objectPermissions?.canReadOwnObjectRecordsOnly ?? false;

  const supportedObjects = ['task', 'lead'];

  if (!supportedObjects.includes(objectMetadataItem.nameSingular)) {
    return null;
  }

  if (canReadOwnObjectRecordsOnly && !isAdmin) {
    return null;
  }

  const assigneeField = objectMetadataItem.fields.find(
    (field) => field.name === 'assignee',
  );

  if (!isDefined(assigneeField)) {
    return null;
  }

  const currentAssigneeFilter = currentRecordFilters.find(
    (filter) => filter.fieldMetadataId === assigneeField.id,
  );

  const objectLabelPlural = objectMetadataItem.labelPlural ?? 'Tasks';
  const allRecordsLabel = `All ${objectLabelPlural}`;
  const myRecordsLabel = `My ${objectLabelPlural}`;

  const handleSelectMember = (memberId: string | null) => {
    // Remove existing assignee filter
    const filtersWithoutAssignee = currentRecordFilters.filter(
      (filter) => filter.fieldMetadataId !== assigneeField.id,
    );

    if (memberId === null) {
      // Show all tasks
      setCurrentRecordFilters(filtersWithoutAssignee);
      return;
    }

    const selectedMember = workspaceMembers.find(
      (member) => member.id === memberId,
    );

    const isCurrentUser = memberId === currentWorkspaceMemberId;

    // Create new filter for selected member
    const memberFilter: RecordFilter = {
      id: v4(),
      fieldMetadataId: assigneeField.id,
      value: JSON.stringify({
        isCurrentWorkspaceMemberSelected: isCurrentUser,
        selectedRecordIds: [memberId],
      }),
      displayValue: isCurrentUser
        ? 'Me'
        : `${selectedMember?.name?.firstName ?? ''} ${selectedMember?.name?.lastName ?? ''}`.trim(),
      type: 'RELATION',
      operand: ViewFilterOperand.IS,
      label: 'Assignee',
    };

    setCurrentRecordFilters([...filtersWithoutAssignee, memberFilter]);
  };

  const getSelectedMemberName = () => {
    if (!isDefined(currentAssigneeFilter)) {
      return allRecordsLabel;
    }

    try {
      const filterValue = JSON.parse(currentAssigneeFilter.value);

      if (filterValue.isCurrentWorkspaceMemberSelected) {
        return myRecordsLabel;
      }

      const selectedMemberId = filterValue.selectedRecordIds?.[0];

      if (selectedMemberId) {
        const member = workspaceMembers.find(
          (workspaceMember) => workspaceMember.id === selectedMemberId,
        );

        if (member) {
          return `${member.name?.firstName ?? ''} ${member.name?.lastName ?? ''}`.trim();
        }
      }
    } catch {
      // Invalid JSON, show default
    }

    return currentAssigneeFilter.displayValue || t`Filtered`;
  };

  return (
    <StyledDropdownContainer>
      <Dropdown
        dropdownId={dropdownId}
        dropdownPlacement="bottom-start"
        clickableComponent={
          <LightButton
            Icon={IconUsers}
            title={getSelectedMemberName()}
            accent={isDefined(currentAssigneeFilter) ? 'tertiary' : 'tertiary'}
          />
        }
        dropdownComponents={
          <DropdownContent>
            <DropdownMenuItemsContainer>
              <MenuItem
                LeftIcon={IconUsers}
                text={allRecordsLabel}
                onClick={() => handleSelectMember(null)}
              />
              <MenuItem
                LeftIcon={IconUser}
                text={myRecordsLabel}
                onClick={() => handleSelectMember(currentWorkspaceMemberId ?? '')}
              />
              {workspaceMembers
                .filter(
                  (workspaceMember) =>
                    workspaceMember.id !== currentWorkspaceMemberId,
                )
                .map((workspaceMember) => (
                  <MenuItem
                    key={workspaceMember.id}
                    LeftIcon={() => (
                      <Avatar
                        avatarUrl={workspaceMember.avatarUrl ?? undefined}
                        placeholderColorSeed={workspaceMember.id}
                        placeholder={`${workspaceMember.name?.firstName?.[0] ?? ''}${workspaceMember.name?.lastName?.[0] ?? ''}`}
                        size="sm"
                        type="rounded"
                      />
                    )}
                    text={`${workspaceMember.name?.firstName ?? ''} ${workspaceMember.name?.lastName ?? ''}`.trim()}
                    onClick={() => handleSelectMember(workspaceMember.id)}
                  />
                ))}
            </DropdownMenuItemsContainer>
          </DropdownContent>
        }
      />
    </StyledDropdownContainer>
  );
};
