import styled from '@emotion/styled';
import { useEffect, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useRecoilState, useRecoilValue } from 'recoil';

import { currentWorkspaceMemberState } from '@/auth/states/currentWorkspaceMemberState';
import { currentWorkspaceMembersState } from '@/auth/states/currentWorkspaceMembersState';
import { currentWorkspaceState } from '@/auth/states/currentWorkspaceState';
import { useDefaultHomePagePath } from '@/navigation/hooks/useDefaultHomePagePath';
import { useSalesAvailability } from '@/settings/members/hooks/useSalesAvailability';
import { NameFields } from '@/settings/profile/components/NameFields';
import { ProfileSalesLeaveSection } from '@/settings/profile/components/ProfileSalesLeaveSection';
import { useHasPermissionFlag } from '@/settings/roles/hooks/useHasPermissionFlag';
import { WorkspaceMemberPictureUploader } from '@/settings/workspace-member/components/WorkspaceMemberPictureUploader';
import { useSnackBar } from '@/ui/feedback/snack-bar-manager/hooks/useSnackBar';
import { isSimpleViewEnabledState } from '@/ui/layout/simple-view/states/isSimpleViewEnabledState';
import { useColorScheme } from '@/ui/theme/hooks/useColorScheme';
import { WorkspaceInviteLink } from '@/workspace/components/WorkspaceInviteLink';
import { WorkspaceInviteTeam } from '@/workspace/components/WorkspaceInviteTeam';
import { useLingui } from '@lingui/react/macro';
import {
  IconHome,
  IconLayoutSidebarRightCollapse,
  IconMoon,
  IconSun,
} from 'twenty-ui/display';
import { PermissionFlagType } from '~/generated/graphql';

const StyledContainer = styled.div`
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(3)};
  margin: 0 auto;
  max-width: 760px;
  padding: ${({ theme }) => theme.spacing(4)} ${({ theme }) => theme.spacing(3)};
  width: 100%;
`;

const StyledSectionTitle = styled.h2`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.xl};
  margin: 0;
`;

const StyledSectionDescription = styled.p`
  color: ${({ theme }) => theme.font.color.secondary};
  font-size: ${({ theme }) => theme.font.size.md};
  margin: 0;
`;

const StyledCard = styled.div`
  background: ${({ theme }) => theme.background.primary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.md};
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(3)};
  padding: ${({ theme }) => theme.spacing(4)};
`;

const StyledRow = styled.div`
  align-items: center;
  display: flex;
  justify-content: space-between;
  min-height: ${({ theme }) => theme.spacing(10)};
`;

const StyledProfileSection = styled.div`
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(3)};
`;

const StyledMembersSection = styled.div`
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(3)};
`;

const StyledMemberList = styled.div`
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.sm};
  overflow: hidden;
`;

const StyledMemberRow = styled.div`
  align-items: center;
  background: ${({ theme }) => theme.background.transparent.light};
  display: flex;
  justify-content: space-between;
  padding: ${({ theme }) => theme.spacing(2)} ${({ theme }) => theme.spacing(3)};

  & + & {
    border-top: 1px solid ${({ theme }) => theme.border.color.medium};
  }
`;

const StyledMemberName = styled.span`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.medium};
`;

const StyledMemberEmail = styled.span`
  color: ${({ theme }) => theme.font.color.tertiary};
  font-size: ${({ theme }) => theme.font.size.sm};
`;

const StyledLeavePanel = styled.div`
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.sm};
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(3)};
  padding: ${({ theme }) => theme.spacing(3)};
`;

const StyledSubTitle = styled.h3`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.md};
  margin: 0;
`;

const StyledMemberSelector = styled.div`
  display: flex;
  flex-wrap: wrap;
  gap: ${({ theme }) => theme.spacing(2)};
`;

const StyledMemberChip = styled.button<{ isActive: boolean }>`
  background: ${({ isActive, theme }) =>
    isActive ? theme.color.blue : theme.background.transparent.light};
  border: 1px solid
    ${({ isActive, theme }) =>
      isActive ? theme.color.blue : theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.pill};
  color: ${({ isActive, theme }) =>
    isActive ? '#FFFFFF' : theme.font.color.primary};
  cursor: pointer;
  font-size: ${({ theme }) => theme.font.size.sm};
  padding: ${({ theme }) => `${theme.spacing(1)} ${theme.spacing(2)}`};
`;

const StyledDateGrid = styled.div`
  display: grid;
  gap: ${({ theme }) => theme.spacing(2)};
  grid-template-columns: repeat(2, minmax(140px, 1fr));

  > * {
    min-width: 0;
  }

  @media (max-width: 768px) {
    grid-template-columns: 1fr;
  }
`;

const StyledDateInput = styled.input`
  background: ${({ theme }) => theme.background.transparent.lighter};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  box-sizing: border-box;
  border-radius: ${({ theme }) => theme.border.radius.sm};
  color: ${({ theme }) => theme.font.color.primary};
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.md};
  min-height: 38px;
  padding: ${({ theme }) => `${theme.spacing(2)} ${theme.spacing(3)}`};
  width: 100%;
`;

const StyledLeaveActions = styled.div`
  display: flex;
  gap: ${({ theme }) => theme.spacing(2)};

  @media (max-width: 768px) {
    flex-direction: column;
  }
`;

const StyledDialogBackdrop = styled.div`
  align-items: center;
  background: ${({ theme }) => theme.background.overlayPrimary};
  display: flex;
  inset: 0;
  justify-content: center;
  padding: ${({ theme }) => theme.spacing(4)};
  position: fixed;
  z-index: 200;
`;

const StyledDialog = styled.div`
  background: ${({ theme }) => theme.background.primary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.md};
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(3)};
  max-height: min(680px, 92vh);
  max-width: 560px;
  overflow-y: auto;
  padding: ${({ theme }) => theme.spacing(4)};
  width: 100%;
`;

const StyledWeekdayGrid = styled.div`
  display: grid;
  gap: ${({ theme }) => theme.spacing(2)};
  grid-template-columns: repeat(2, minmax(120px, 1fr));
`;

const StyledWeekdayCheck = styled.label`
  align-items: center;
  color: ${({ theme }) => theme.font.color.primary};
  cursor: pointer;
  display: flex;
  font-size: ${({ theme }) => theme.font.size.sm};
  gap: ${({ theme }) => theme.spacing(2)};
`;

const StyledWeekdayCheckbox = styled.input`
  accent-color: ${({ theme }) => theme.color.blue};
`;

const StyledEmptyMembers = styled.div`
  color: ${({ theme }) => theme.font.color.tertiary};
  font-size: ${({ theme }) => theme.font.size.sm};
  padding: ${({ theme }) => theme.spacing(3)};
  text-align: center;
`;

const StyledLabel = styled.span`
  align-items: center;
  color: ${({ theme }) => theme.font.color.primary};
  display: inline-flex;
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  gap: ${({ theme }) => theme.spacing(2)};
`;

const StyledToggle = styled.button<{ isOn: boolean }>`
  background: ${({ theme, isOn }) =>
    isOn ? theme.color.blue : theme.background.transparent.medium};
  border: none;
  border-radius: ${({ theme }) => theme.border.radius.pill};
  cursor: pointer;
  height: 24px;
  padding: 2px;
  position: relative;
  transition: background 0.2s;
  width: 44px;

  &::after {
    background: white;
    border-radius: 50%;
    content: '';
    height: 20px;
    left: ${({ isOn }) => (isOn ? '22px' : '2px')};
    position: absolute;
    top: 2px;
    transition: left 0.2s;
    width: 20px;
  }
`;

const StyledActions = styled.div`
  display: flex;
  flex-direction: row;
  gap: ${({ theme }) => theme.spacing(2)};

  @media (max-width: 768px) {
    flex-direction: column;
  }
`;

const StyledActionButton = styled.button<{ variant?: 'primary' | 'secondary' }>`
  align-items: center;
  background: ${({ theme, variant }) =>
    variant === 'primary' ? theme.color.blue : theme.background.transparent.light};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.sm};
  color: ${({ theme, variant }) =>
    variant === 'primary' ? '#FFFFFF' : theme.font.color.primary};
  cursor: pointer;
  display: flex;
  flex: 1;
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  gap: ${({ theme }) => theme.spacing(2)};
  justify-content: center;
  padding: ${({ theme }) => theme.spacing(2)} ${({ theme }) => theme.spacing(3)};

  &:hover {
    background: ${({ theme, variant }) =>
      variant === 'primary' ? theme.color.blue : theme.background.transparent.medium};
  }
`;

const WEEKDAY_KEYS = [
  'MONDAY',
  'TUESDAY',
  'WEDNESDAY',
  'THURSDAY',
  'FRIDAY',
  'SATURDAY',
  'SUNDAY',
] as const;

export const SimpleSettingsPage = () => {
  const navigate = useNavigate();
  const { t } = useLingui();
  const { defaultHomePagePath } = useDefaultHomePagePath();
  const { enqueueErrorSnackBar, enqueueSuccessSnackBar } = useSnackBar();
  const { colorScheme, setColorScheme } = useColorScheme();
  const currentWorkspace = useRecoilValue(currentWorkspaceState);
  const currentWorkspaceMember = useRecoilValue(currentWorkspaceMemberState);
  const currentWorkspaceMembers = useRecoilValue(currentWorkspaceMembersState);
  const {
    salesStatusesByMemberId,
    isLoadingSalesStatuses,
    isSavingSalesAvailability,
    isSavingSalesLeave,
    fetchSalesUsersStatus,
    updateSalesAvailability,
    updateSalesLeave,
  } = useSalesAvailability();
  const canManageMembers = useHasPermissionFlag(
    PermissionFlagType.WORKSPACE_MEMBERS,
  );
  const [isSimpleViewEnabled, setIsSimpleViewEnabled] = useRecoilState(
    isSimpleViewEnabledState,
  );
  const [selectedMemberId, setSelectedMemberId] = useState<string | null>(null);
  const [leaveStartDate, setLeaveStartDate] = useState('');
  const [leaveEndDate, setLeaveEndDate] = useState('');
  const [showAvailabilityDialog, setShowAvailabilityDialog] = useState(false);
  const [availabilityStartTime, setAvailabilityStartTime] = useState('09:00');
  const [availabilityEndTime, setAvailabilityEndTime] = useState('18:00');
  const [selectedDays, setSelectedDays] = useState<string[]>([
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
  ]);
  const workspaceInviteLink = currentWorkspace?.inviteHash
    ? `${window.location.origin}/invite/${currentWorkspace.inviteHash}`
    : null;
  const weekdayLabels: Record<(typeof WEEKDAY_KEYS)[number], string> = {
    MONDAY: t`Mon`,
    TUESDAY: t`Tue`,
    WEDNESDAY: t`Wed`,
    THURSDAY: t`Thu`,
    FRIDAY: t`Fri`,
    SATURDAY: t`Sat`,
    SUNDAY: t`Sun`,
  };

  const salesMembers = useMemo(() => {
    const salesMemberIds = new Set(Object.keys(salesStatusesByMemberId));

    return currentWorkspaceMembers.filter((member) => salesMemberIds.has(member.id));
  }, [currentWorkspaceMembers, salesStatusesByMemberId]);

  const selectedMember = useMemo(
    () =>
      salesMembers.find((member) => member.id === selectedMemberId) ?? null,
    [salesMembers, selectedMemberId],
  );

  useEffect(() => {
    if (!canManageMembers) {
      return;
    }

    void fetchSalesUsersStatus();
  }, [canManageMembers, fetchSalesUsersStatus]);

  useEffect(() => {
    if (salesMembers.length === 0) {
      if (selectedMemberId) {
        setSelectedMemberId(null);
      }
      return;
    }

    if (
      !selectedMemberId ||
      !salesMembers.some((member) => member.id === selectedMemberId)
    ) {
      setSelectedMemberId(salesMembers[0].id);
    }
  }, [salesMembers, selectedMemberId]);

  useEffect(() => {
    if (!selectedMemberId) {
      return;
    }

    const selectedStatus = salesStatusesByMemberId[selectedMemberId];
    const start = selectedStatus?.leaveStartDate?.slice(0, 10) ?? '';
    const end = selectedStatus?.leaveEndDate?.slice(0, 10) ?? '';
    const startTime = selectedStatus?.availabilityStartTime ?? '09:00';
    const endTime = selectedStatus?.availabilityEndTime ?? '18:00';
    const days = selectedStatus?.availableDays?.length
      ? selectedStatus.availableDays
      : ['MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY'];

    setLeaveStartDate(start);
    setLeaveEndDate(end);
    setAvailabilityStartTime(startTime);
    setAvailabilityEndTime(endTime);
    setSelectedDays(days);
  }, [salesStatusesByMemberId, selectedMemberId]);

  const handleApplyLeave = async () => {
    if (!selectedMemberId) {
      enqueueErrorSnackBar({ message: t`Select a member first` });
      return;
    }

    if (!leaveStartDate || !leaveEndDate) {
      enqueueErrorSnackBar({ message: t`Select both leave dates` });
      return;
    }

    if (new Date(leaveStartDate) > new Date(leaveEndDate)) {
      enqueueErrorSnackBar({
        message: t`Leave end date must be after leave start date`,
      });
      return;
    }

    try {
      await updateSalesLeave(selectedMemberId, {
        leaveStartDate: `${leaveStartDate}T00:00:00.000Z`,
        leaveEndDate: `${leaveEndDate}T23:59:59.999Z`,
      });

      enqueueSuccessSnackBar({ message: t`Leave updated` });
    } catch (error) {
      enqueueErrorSnackBar({
        message: error instanceof Error ? error.message : t`Unable to update leave`,
      });
    }
  };

  const handleClearLeave = async () => {
    if (!selectedMemberId) {
      enqueueErrorSnackBar({ message: t`Select a member first` });
      return;
    }

    try {
      await updateSalesLeave(selectedMemberId, { clearLeave: true });
      setLeaveStartDate('');
      setLeaveEndDate('');
      enqueueSuccessSnackBar({ message: t`Leave cleared` });
    } catch (error) {
      enqueueErrorSnackBar({
        message: error instanceof Error ? error.message : t`Unable to clear leave`,
      });
    }
  };

  const handleToggleDay = (day: string) => {
    setSelectedDays((previousDays) => {
      if (previousDays.includes(day)) {
        return previousDays.filter((currentDay) => currentDay !== day);
      }

      return [...previousDays, day];
    });
  };

  const handleSaveAvailability = async () => {
    if (!selectedMemberId) {
      enqueueErrorSnackBar({ message: t`Select a member first` });
      return;
    }

    if (!availabilityStartTime || !availabilityEndTime) {
      enqueueErrorSnackBar({ message: t`Select start and end time` });
      return;
    }

    if (selectedDays.length === 0) {
      enqueueErrorSnackBar({ message: t`Select at least one day` });
      return;
    }

    try {
      await updateSalesAvailability(selectedMemberId, {
        availabilityStartTime,
        availabilityEndTime,
        availableDays: selectedDays,
      });
      enqueueSuccessSnackBar({ message: t`Availability updated` });
      setShowAvailabilityDialog(false);
    } catch (error) {
      enqueueErrorSnackBar({
        message:
          error instanceof Error
            ? error.message
            : t`Unable to update availability`,
      });
    }
  };

  return (
    <StyledContainer>
      {currentWorkspaceMember?.id && (
        <StyledCard>
          <StyledSectionTitle>{t`Profile`}</StyledSectionTitle>
          <StyledProfileSection>
            <WorkspaceMemberPictureUploader
              workspaceMemberId={currentWorkspaceMember.id}
            />
            <NameFields />
            <ProfileSalesLeaveSection variant="simple" />
          </StyledProfileSection>
        </StyledCard>
      )}

      {canManageMembers && (
        <StyledCard>
          <StyledSectionTitle>{t`Members`}</StyledSectionTitle>
          <StyledMembersSection>
            {workspaceInviteLink ? (
              <WorkspaceInviteLink inviteLink={workspaceInviteLink} />
            ) : null}
            <WorkspaceInviteTeam />
            <StyledMemberList>
              {currentWorkspaceMembers.length === 0 ? (
                <StyledEmptyMembers>{t`No members yet`}</StyledEmptyMembers>
              ) : (
                currentWorkspaceMembers.slice(0, 6).map((member) => {
                  const fullName =
                    `${member.name.firstName ?? ''} ${member.name.lastName ?? ''}`.trim() ||
                    member.userEmail;

                  return (
                    <StyledMemberRow key={member.id}>
                      <StyledMemberName>{fullName}</StyledMemberName>
                      <StyledMemberEmail>{member.userEmail}</StyledMemberEmail>
                    </StyledMemberRow>
                  );
                })
              )}
            </StyledMemberList>
            <StyledLeavePanel>
              <StyledSubTitle>{t`Leave setup`}</StyledSubTitle>
              <StyledMemberSelector>
                {salesMembers.slice(0, 12).map((member) => {
                  const fullName =
                    `${member.name.firstName ?? ''} ${member.name.lastName ?? ''}`.trim() ||
                    member.userEmail;

                  return (
                    <StyledMemberChip
                      key={member.id}
                      isActive={selectedMemberId === member.id}
                      onClick={() => setSelectedMemberId(member.id)}
                    >
                      {fullName}
                    </StyledMemberChip>
                  );
                })}
              </StyledMemberSelector>
              {salesMembers.length === 0 && !isLoadingSalesStatuses ? (
                <StyledEmptyMembers>{t`No sales members available`}</StyledEmptyMembers>
              ) : null}
              <StyledDateGrid>
                <StyledDateInput
                  type="date"
                  value={leaveStartDate}
                  onChange={(event) => setLeaveStartDate(event.target.value)}
                  aria-label={t`Leave start date`}
                />
                <StyledDateInput
                  type="date"
                  value={leaveEndDate}
                  onChange={(event) => setLeaveEndDate(event.target.value)}
                  aria-label={t`Leave end date`}
                />
              </StyledDateGrid>
              <StyledLeaveActions>
                <StyledActionButton
                  onClick={() => setShowAvailabilityDialog(true)}
                  disabled={!selectedMember}
                >
                  {t`Availability schedule`}
                </StyledActionButton>
                <StyledActionButton
                  onClick={() => {
                    void handleApplyLeave();
                  }}
                  disabled={!selectedMember || isSavingSalesLeave}
                >
                  {isSavingSalesLeave ? t`Saving...` : t`Apply leave`}
                </StyledActionButton>
                <StyledActionButton
                  onClick={() => {
                    void handleClearLeave();
                  }}
                  disabled={!selectedMember || isSavingSalesLeave}
                >
                  {t`Clear leave`}
                </StyledActionButton>
              </StyledLeaveActions>
              {isLoadingSalesStatuses ? (
                <StyledEmptyMembers>{t`Loading member leave status...`}</StyledEmptyMembers>
              ) : null}
            </StyledLeavePanel>
          </StyledMembersSection>
        </StyledCard>
      )}

      <StyledCard>
        <StyledRow>
          <StyledLabel>
            <IconLayoutSidebarRightCollapse size={16} />
            {t`Simple View`}
          </StyledLabel>
          <StyledToggle
            isOn={isSimpleViewEnabled}
            onClick={() => {
              if (isSimpleViewEnabled) {
                setIsSimpleViewEnabled(false);
                navigate(defaultHomePagePath);
                return;
              }

              setIsSimpleViewEnabled(true);
            }}
          />
        </StyledRow>
      </StyledCard>

      <StyledCard>
        <StyledRow>
          <StyledLabel>
            {colorScheme === 'Dark' ? (
              <>
                <IconSun size={16} />
                {t`Light mode`}
              </>
            ) : (
              <>
                <IconMoon size={16} />
                {t`Dark mode`}
              </>
            )}
          </StyledLabel>
          <StyledToggle
            isOn={colorScheme === 'Dark'}
            onClick={() =>
              setColorScheme(colorScheme === 'Dark' ? 'Light' : 'Dark')
            }
          />
        </StyledRow>
      </StyledCard>

      <StyledCard>
        <StyledSectionTitle>{t`More actions`}</StyledSectionTitle>
        <StyledActions>
          <StyledActionButton
            variant="primary"
            onClick={() => navigate(defaultHomePagePath)}
          >
            <IconHome size={16} />
            {t`Back to records`}
          </StyledActionButton>
        </StyledActions>
      </StyledCard>

      {showAvailabilityDialog && (
        <StyledDialogBackdrop
          onClick={() => {
            setShowAvailabilityDialog(false);
          }}
        >
          <StyledDialog
            onClick={(event) => {
              event.stopPropagation();
            }}
          >
            <StyledSectionTitle>{t`Availability schedule`}</StyledSectionTitle>
            <StyledSectionDescription>
              {selectedMember
                ? t`Configure active days and work hours`
                : t`Select a member first`}
            </StyledSectionDescription>

            <StyledDateGrid>
              <StyledDateInput
                type="time"
                value={availabilityStartTime}
                onChange={(event) => setAvailabilityStartTime(event.target.value)}
                aria-label={t`Availability start time`}
              />
              <StyledDateInput
                type="time"
                value={availabilityEndTime}
                onChange={(event) => setAvailabilityEndTime(event.target.value)}
                aria-label={t`Availability end time`}
              />
            </StyledDateGrid>

            <StyledWeekdayGrid>
              {WEEKDAY_KEYS.map((day) => (
                <StyledWeekdayCheck key={day}>
                  <StyledWeekdayCheckbox
                    type="checkbox"
                    checked={selectedDays.includes(day)}
                    onChange={() => handleToggleDay(day)}
                  />
                  {weekdayLabels[day]}
                </StyledWeekdayCheck>
              ))}
            </StyledWeekdayGrid>

            <StyledLeaveActions>
              <StyledActionButton
                variant="primary"
                onClick={() => {
                  void handleSaveAvailability();
                }}
                disabled={!selectedMember || isSavingSalesAvailability}
              >
                {isSavingSalesAvailability ? t`Saving...` : t`Save schedule`}
              </StyledActionButton>
              <StyledActionButton
                onClick={() => setShowAvailabilityDialog(false)}
              >
                {t`Cancel`}
              </StyledActionButton>
            </StyledLeaveActions>
          </StyledDialog>
        </StyledDialogBackdrop>
      )}
    </StyledContainer>
  );
};
