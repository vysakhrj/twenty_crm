import styled from '@emotion/styled';
import { t } from '@lingui/core/macro';
import { useEffect, useMemo, useState } from 'react';
import { isDefined } from 'twenty-shared/utils';

import { useSalesAvailability } from '@/settings/members/hooks/useSalesAvailability';
import { useSnackBar } from '@/ui/feedback/snack-bar-manager/hooks/useSnackBar';
import { type WorkspaceMember } from '@/workspace-member/types/WorkspaceMember';
import { H2Title, Status } from 'twenty-ui/display';
import { Button, Checkbox } from 'twenty-ui/input';
import { Section } from 'twenty-ui/layout';

const WEEKDAY_KEYS = [
  'MONDAY',
  'TUESDAY',
  'WEDNESDAY',
  'THURSDAY',
  'FRIDAY',
  'SATURDAY',
  'SUNDAY',
] as const;

const getWeekdayLabel = (key: string): string => {
  switch (key) {
    case 'MONDAY':
      return t`Mon`;
    case 'TUESDAY':
      return t`Tue`;
    case 'WEDNESDAY':
      return t`Wed`;
    case 'THURSDAY':
      return t`Thu`;
    case 'FRIDAY':
      return t`Fri`;
    case 'SATURDAY':
      return t`Sat`;
    case 'SUNDAY':
      return t`Sun`;
    default:
      return key;
  }
};

const StyledStatusRow = styled.div`
  align-items: center;
  display: flex;
  gap: ${({ theme }) => theme.spacing(2)};
  margin-bottom: ${({ theme }) => theme.spacing(3)};
`;

const StyledMutedText = styled.div`
  color: ${({ theme }) => theme.font.color.tertiary};
  font-size: ${({ theme }) => theme.font.size.sm};
`;

const StyledControlsGrid = styled.div`
  display: grid;
  gap: ${({ theme }) => theme.spacing(3)};
  grid-template-columns: 1fr;
`;

const StyledTimeGrid = styled.div`
  display: grid;
  gap: ${({ theme }) => theme.spacing(3)};
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
`;

const StyledDaysGrid = styled.div`
  display: grid;
  gap: ${({ theme }) => theme.spacing(2)};
  grid-template-columns: repeat(auto-fit, minmax(84px, 1fr));
  width: 100%;
`;

const StyledDayCard = styled.button<{ checked: boolean; disabled?: boolean }>`
  align-items: center;
  appearance: none;
  background: ${({ theme }) => theme.background.primary};
  border: 1px solid
    ${({ checked, theme }) =>
      checked ? theme.border.color.strong : theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.md};
  color: ${({ disabled, theme }) =>
    disabled ? theme.font.color.tertiary : theme.font.color.primary};
  cursor: ${({ disabled }) => (disabled ? 'not-allowed' : 'pointer')};
  display: flex;
  flex-direction: column;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.md};
  gap: ${({ theme }) => theme.spacing(1)};
  justify-content: center;
  opacity: ${({ disabled }) => (disabled ? 0.6 : 1)};
  padding: ${({ theme }) => theme.spacing(2)};
  width: 100%;
`;

const StyledActionsRow = styled.div`
  display: flex;
  flex-wrap: wrap;
  gap: ${({ theme }) => theme.spacing(2)};
  margin-top: ${({ theme }) => theme.spacing(3)};
`;

const StyledLeaveGrid = styled.div`
  display: grid;
  gap: ${({ theme }) => theme.spacing(3)};
  grid-template-columns: repeat(2, minmax(200px, 1fr));
  margin-top: ${({ theme }) => theme.spacing(3)};

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
  min-height: 36px;
  padding: ${({ theme }) => `${theme.spacing(2)} ${theme.spacing(3)}`};
  width: 100%;
`;

const StyledTimeInput = styled(StyledDateInput)`
  font-variant-numeric: tabular-nums;
`;

type MemberSalesAvailabilitySectionProps = {
  member: WorkspaceMember;
  isSalesMember: boolean;
  canEdit: boolean;
};

const mapStatusToColor = (status: 'ACTIVE' | 'INACTIVE') =>
  status === 'ACTIVE' ? 'green' : 'orange';

const toDateInputValue = (dateString: string | null | undefined): string => {
  if (!dateString) {
    return '';
  }

  const date = new Date(dateString);

  if (Number.isNaN(date.getTime())) {
    return '';
  }

  return date.toISOString().slice(0, 10);
};

const TIME_24H_REGEX = /^([01]\d|2[0-3]):([0-5]\d)$/;

const isValidAvailabilityTime = (
  value: string,
  allow24HourBoundary: boolean,
) => {
  if (allow24HourBoundary && value === '24:00') {
    return true;
  }

  return TIME_24H_REGEX.test(value);
};

const parseTimeToMinutes = (value: string, allow24HourBoundary: boolean) => {
  if (allow24HourBoundary && value === '24:00') {
    return 24 * 60;
  }

  if (!TIME_24H_REGEX.test(value)) {
    return Number.NaN;
  }

  const [hours, minutes] = value.split(':').map(Number);

  return hours * 60 + minutes;
};

const toEndTimeFromAvailabilityHours = (availabilityHours: number | null | undefined) => {
  if (typeof availabilityHours !== 'number' || Number.isNaN(availabilityHours)) {
    return '24:00';
  }

  const boundedHours = Math.max(1, Math.min(24, Math.round(availabilityHours)));

  return `${String(boundedHours).padStart(2, '0')}:00`;
};

export const MemberSalesAvailabilitySection = ({
  member,
  isSalesMember,
  canEdit,
}: MemberSalesAvailabilitySectionProps) => {
  const { enqueueErrorSnackBar, enqueueSuccessSnackBar } = useSnackBar();
  const {
    salesStatusesByMemberId,
    isLoadingSalesStatuses,
    isSavingSalesAvailability,
    isSavingSalesLeave,
    fetchSalesUsersStatus,
    updateSalesAvailability,
    updateSalesLeave,
  } = useSalesAvailability();
  const [hasSalesAvailabilityAccess, setHasSalesAvailabilityAccess] =
    useState(false);
  const [resolvedIsSalesMember, setResolvedIsSalesMember] =
    useState(isSalesMember);

  const [availabilityStartTime, setAvailabilityStartTime] = useState<string>(
    member.availabilityStartTime ?? '00:00',
  );
  const [availabilityEndTime, setAvailabilityEndTime] = useState<string>(
    member.availabilityEndTime ??
      toEndTimeFromAvailabilityHours(member.availabilityHours),
  );
  const [selectedDays, setSelectedDays] = useState<string[]>(
    member.availableDays?.length
      ? member.availableDays
      : [...WEEKDAY_KEYS],
  );
  const [leaveStartDate, setLeaveStartDate] = useState(
    toDateInputValue(member.leaveStartDate),
  );
  const [leaveEndDate, setLeaveEndDate] = useState(
    toDateInputValue(member.leaveEndDate),
  );
  const availableDaysSignature = useMemo(
    () => (member.availableDays ?? []).join('|'),
    [member.availableDays],
  );

  useEffect(() => {
    setAvailabilityStartTime(member.availabilityStartTime ?? '00:00');
    setAvailabilityEndTime(
      member.availabilityEndTime ??
        toEndTimeFromAvailabilityHours(member.availabilityHours),
    );
    setSelectedDays(
      member.availableDays?.length
        ? member.availableDays
        : [...WEEKDAY_KEYS],
    );
    setLeaveStartDate(toDateInputValue(member.leaveStartDate));
    setLeaveEndDate(toDateInputValue(member.leaveEndDate));
  }, [
    member.id,
    member.availabilityEndTime,
    member.availabilityHours,
    member.availabilityStartTime,
    availableDaysSignature,
    member.leaveEndDate,
    member.leaveStartDate,
  ]);

  useEffect(() => {
    let isMounted = true;

    const loadSalesStatuses = async () => {
      try {
        const statusMap = await fetchSalesUsersStatus();

        if (!isMounted) {
          return;
        }

        setHasSalesAvailabilityAccess(true);
        setResolvedIsSalesMember(
          isDefined(statusMap) && isDefined(statusMap[member.id]),
        );
      } catch {
        if (!isMounted) {
          return;
        }

        setHasSalesAvailabilityAccess(false);
      }
    };

    void loadSalesStatuses();

    return () => {
      isMounted = false;
    };
  }, [fetchSalesUsersStatus, member.id]);

  const canEditSalesAvailability = canEdit || hasSalesAvailabilityAccess;
  const isResolvedSalesMember =
    resolvedIsSalesMember || isDefined(salesStatusesByMemberId[member.id]);

  const currentSalesStatus = useMemo(
    () => salesStatusesByMemberId[member.id]?.status,
    [member.id, salesStatusesByMemberId],
  );

  const handleToggleDay = (day: string, nextChecked?: boolean) => {
    if (!canEditSalesAvailability) {
      return;
    }

    setSelectedDays((prev) => {
      const isCurrentlyChecked = prev.includes(day);
      const shouldBeChecked = nextChecked ?? !isCurrentlyChecked;

      if (!shouldBeChecked) {
        return prev.filter((d) => d !== day);
      }

      return isCurrentlyChecked ? prev : [...prev, day];
    });
  };

  const handleSaveAvailability = async () => {
    const startTime = availabilityStartTime.trim();
    const endTime = availabilityEndTime.trim();

    if (!isValidAvailabilityTime(startTime, false)) {
      enqueueErrorSnackBar({
        message: t`Start time must be in HH:mm format between 00:00 and 23:59`,
      });
      return;
    }

    if (!isValidAvailabilityTime(endTime, true)) {
      enqueueErrorSnackBar({
        message: t`End time must be in HH:mm format between 00:00 and 24:00`,
      });
      return;
    }

    const startMinutes = parseTimeToMinutes(startTime, false);
    const endMinutes = parseTimeToMinutes(endTime, true);

    if (
      Number.isNaN(startMinutes) ||
      Number.isNaN(endMinutes) ||
      startMinutes >= endMinutes
    ) {
      enqueueErrorSnackBar({
        message: t`End time must be later than start time`,
      });
      return;
    }

    if (selectedDays.length === 0) {
      enqueueErrorSnackBar({
        message: t`Select at least one available day`,
      });
      return;
    }

    try {
      await updateSalesAvailability(member.id, {
        availabilityStartTime: startTime,
        availabilityEndTime: endTime,
        availableDays: selectedDays,
      });
      enqueueSuccessSnackBar({
        message: t`Sales availability updated`,
      });
    } catch (error) {
      enqueueErrorSnackBar({
        message:
          error instanceof Error
            ? error.message
            : t`Unable to update sales availability`,
      });
    }
  };

  const handleApplyLeave = async () => {
    if (!leaveStartDate || !leaveEndDate) {
      enqueueErrorSnackBar({
        message: t`Provide both leave start and end dates`,
      });
      return;
    }

    if (new Date(leaveStartDate) > new Date(leaveEndDate)) {
      enqueueErrorSnackBar({
        message: t`Leave end date must be after leave start date`,
      });
      return;
    }

    try {
      await updateSalesLeave(member.id, {
        leaveStartDate: new Date(leaveStartDate).toISOString(),
        leaveEndDate: new Date(leaveEndDate).toISOString(),
      });
      enqueueSuccessSnackBar({
        message: t`Leave dates updated`,
      });
    } catch (error) {
      enqueueErrorSnackBar({
        message:
          error instanceof Error ? error.message : t`Unable to update leave`,
      });
    }
  };

  const handleClearLeave = async () => {
    setLeaveStartDate('');
    setLeaveEndDate('');

    try {
      await updateSalesLeave(member.id, { clearLeave: true });
      enqueueSuccessSnackBar({
        message: t`Leave cleared`,
      });
    } catch (error) {
      enqueueErrorSnackBar({
        message:
          error instanceof Error ? error.message : t`Unable to clear leave`,
      });
    }
  };

  if (!isResolvedSalesMember && isLoadingSalesStatuses) {
    return (
      <Section>
        <H2Title
          title={t`Sales Availability`}
          description={t`Loading scheduling settings`}
        />
        <StyledMutedText>{t`Refreshing sales availability...`}</StyledMutedText>
      </Section>
    );
  }

  if (!isResolvedSalesMember) {
    return (
      <Section>
        <H2Title
          title={t`Sales Availability`}
          description={t`Only sales members have scheduling settings`}
        />
        <StyledMutedText>{t`This member is not in a sales role.`}</StyledMutedText>
      </Section>
    );
  }

  return (
    <Section>
      <H2Title
        title={t`Sales Availability`}
        description={
          canEditSalesAvailability
            ? t`Set availability time range, active days, and leave period`
            : t`Read-only view. Only manager/super admin can edit sales scheduling.`
        }
      />

      <StyledStatusRow>
        <Status
          color={mapStatusToColor(currentSalesStatus?.status ?? 'ACTIVE')}
          text={
            currentSalesStatus?.status === 'INACTIVE' ? t`Inactive` : t`Active`
          }
        />
        {currentSalesStatus?.reason === 'LEAVE' && (
          <StyledMutedText>{t`On leave`}</StyledMutedText>
        )}
        {currentSalesStatus?.reason === 'UNAVAILABLE_DAY' && (
          <StyledMutedText>{t`Not available today`}</StyledMutedText>
        )}
        {currentSalesStatus?.reason === 'UNAVAILABLE_HOURS' && (
          <StyledMutedText>{t`Outside available hours`}</StyledMutedText>
        )}
        {isLoadingSalesStatuses && (
          <StyledMutedText>{t`Refreshing status...`}</StyledMutedText>
        )}
      </StyledStatusRow>

      <StyledControlsGrid>
        <StyledTimeGrid>
          <div>
            <StyledMutedText>{t`Start time (HH:mm)`}</StyledMutedText>
            <StyledTimeInput
              type="text"
              inputMode="numeric"
              value={availabilityStartTime}
              onChange={(event) => setAvailabilityStartTime(event.target.value)}
              disabled={!canEditSalesAvailability}
              placeholder='00:00'
            />
          </div>
          <div>
            <StyledMutedText>{t`End time (HH:mm)`}</StyledMutedText>
            <StyledTimeInput
              type="text"
              inputMode="numeric"
              value={availabilityEndTime}
              onChange={(event) => setAvailabilityEndTime(event.target.value)}
              disabled={!canEditSalesAvailability}
              placeholder='24:00'
            />
          </div>
        </StyledTimeGrid>
        <StyledDaysGrid>
          {WEEKDAY_KEYS.map((dayKey) => {
            const checked = selectedDays.includes(dayKey);

            return (
              <StyledDayCard
                key={dayKey}
                checked={checked}
                disabled={!canEditSalesAvailability}
                type="button"
                onClick={() => handleToggleDay(dayKey)}
              >
                <div>{getWeekdayLabel(dayKey)}</div>
                <Checkbox
                  checked={checked}
                  disabled={!canEditSalesAvailability}
                  onChange={(event) => {
                    event.stopPropagation();
                    handleToggleDay(dayKey, event.target.checked);
                  }}
                />
              </StyledDayCard>
            );
          })}
        </StyledDaysGrid>
      </StyledControlsGrid>

      <StyledActionsRow>
        <Button
          title={t`Save availability`}
          variant="secondary"
          onClick={handleSaveAvailability}
          disabled={!canEditSalesAvailability}
          isLoading={isSavingSalesAvailability}
        />
      </StyledActionsRow>

      <StyledLeaveGrid>
        <div>
          <StyledMutedText>{t`Leave start date`}</StyledMutedText>
          <StyledDateInput
            type="date"
            value={leaveStartDate}
            onChange={(event) => setLeaveStartDate(event.target.value)}
            disabled={!canEditSalesAvailability}
          />
        </div>
        <div>
          <StyledMutedText>{t`Leave end date`}</StyledMutedText>
          <StyledDateInput
            type="date"
            value={leaveEndDate}
            onChange={(event) => setLeaveEndDate(event.target.value)}
            disabled={!canEditSalesAvailability}
          />
        </div>
      </StyledLeaveGrid>

      <StyledActionsRow>
        <Button
          title={t`Apply leave`}
          variant="secondary"
          onClick={handleApplyLeave}
          disabled={!canEditSalesAvailability}
          isLoading={isSavingSalesLeave}
        />
        <Button
          title={t`Clear leave`}
          variant="tertiary"
          onClick={handleClearLeave}
          disabled={!canEditSalesAvailability}
          isLoading={isSavingSalesLeave}
        />
      </StyledActionsRow>
    </Section>
  );
};
