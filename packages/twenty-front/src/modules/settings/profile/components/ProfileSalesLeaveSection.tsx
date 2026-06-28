import styled from '@emotion/styled';
import { useEffect, useMemo, useState } from 'react';

import { useCurrentUserRole } from '@/auth/hooks/useCurrentUserRole';
import { useSalesAvailability } from '@/settings/members/hooks/useSalesAvailability';
import { useSnackBar } from '@/ui/feedback/snack-bar-manager/hooks/useSnackBar';
import { useLingui } from '@lingui/react/macro';
import { H2Title, Status } from 'twenty-ui/display';
import { Button } from 'twenty-ui/input';
import { Section } from 'twenty-ui/layout';

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

const StyledLeaveGrid = styled.div`
  display: grid;
  gap: ${({ theme }) => theme.spacing(3)};
  grid-template-columns: repeat(2, minmax(200px, 1fr));

  @media (max-width: 768px) {
    grid-template-columns: 1fr;
  }
`;

const StyledDateInput = styled.input`
  background: ${({ theme }) => theme.background.transparent.lighter};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.sm};
  box-sizing: border-box;
  color: ${({ theme }) => theme.font.color.primary};
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.md};
  min-height: 36px;
  padding: ${({ theme }) => `${theme.spacing(2)} ${theme.spacing(3)}`};
  width: 100%;
`;

const StyledActionsRow = styled.div`
  display: flex;
  flex-wrap: wrap;
  gap: ${({ theme }) => theme.spacing(2)};
  margin-top: ${({ theme }) => theme.spacing(3)};
`;

const StyledSimpleTitle = styled.h3`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  margin: 0;
`;

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

const mapStatusToColor = (status: 'ACTIVE' | 'INACTIVE') =>
  status === 'ACTIVE' ? 'green' : 'orange';

type ProfileSalesLeaveSectionProps = {
  variant?: 'settings' | 'simple';
};

export const ProfileSalesLeaveSection = ({
  variant = 'settings',
}: ProfileSalesLeaveSectionProps) => {
  const { t } = useLingui();
  const { enqueueErrorSnackBar, enqueueSuccessSnackBar } = useSnackBar();
  const { currentWorkspaceMemberId } = useCurrentUserRole();
  const {
    salesStatusesByMemberId,
    isLoadingSalesStatuses,
    isSavingSalesLeave,
    fetchSelfSalesStatus,
    updateSalesLeave,
  } = useSalesAvailability();
  const [hasSelfLeaveAccess, setHasSelfLeaveAccess] = useState(false);
  const [leaveStartDate, setLeaveStartDate] = useState('');
  const [leaveEndDate, setLeaveEndDate] = useState('');

  useEffect(() => {
    if (!currentWorkspaceMemberId) {
      return;
    }

    let isMounted = true;

    const loadSelfSalesStatus = async () => {
      try {
        await fetchSelfSalesStatus();

        if (isMounted) {
          setHasSelfLeaveAccess(true);
        }
      } catch {
        if (isMounted) {
          setHasSelfLeaveAccess(false);
        }
      }
    };

    void loadSelfSalesStatus();

    return () => {
      isMounted = false;
    };
  }, [currentWorkspaceMemberId, fetchSelfSalesStatus]);

  const currentSalesStatus = useMemo(() => {
    if (!currentWorkspaceMemberId) {
      return undefined;
    }

    return salesStatusesByMemberId[currentWorkspaceMemberId]?.status;
  }, [currentWorkspaceMemberId, salesStatusesByMemberId]);

  useEffect(() => {
    if (!currentWorkspaceMemberId) {
      return;
    }

    const salesStatus = salesStatusesByMemberId[currentWorkspaceMemberId];

    setLeaveStartDate(toDateInputValue(salesStatus?.leaveStartDate));
    setLeaveEndDate(toDateInputValue(salesStatus?.leaveEndDate));
  }, [currentWorkspaceMemberId, salesStatusesByMemberId]);

  const handleApplyLeave = async () => {
    if (!currentWorkspaceMemberId) {
      return;
    }

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
      await updateSalesLeave(currentWorkspaceMemberId, {
        leaveStartDate: `${leaveStartDate}T00:00:00.000Z`,
        leaveEndDate: `${leaveEndDate}T23:59:59.999Z`,
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
    if (!currentWorkspaceMemberId) {
      return;
    }

    setLeaveStartDate('');
    setLeaveEndDate('');

    try {
      await updateSalesLeave(currentWorkspaceMemberId, { clearLeave: true });
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

  if (!hasSelfLeaveAccess || !currentWorkspaceMemberId) {
    return null;
  }

  const content = (
    <>
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
        {isLoadingSalesStatuses && (
          <StyledMutedText>{t`Refreshing status...`}</StyledMutedText>
        )}
      </StyledStatusRow>

      <StyledLeaveGrid>
        <div>
          <StyledMutedText>{t`Leave start date`}</StyledMutedText>
          <StyledDateInput
            type="date"
            value={leaveStartDate}
            onChange={(event) => setLeaveStartDate(event.target.value)}
            aria-label={t`Leave start date`}
          />
        </div>
        <div>
          <StyledMutedText>{t`Leave end date`}</StyledMutedText>
          <StyledDateInput
            type="date"
            value={leaveEndDate}
            onChange={(event) => setLeaveEndDate(event.target.value)}
            aria-label={t`Leave end date`}
          />
        </div>
      </StyledLeaveGrid>

      <StyledActionsRow>
        <Button
          title={t`Apply leave`}
          variant="secondary"
          onClick={handleApplyLeave}
          isLoading={isSavingSalesLeave}
        />
        <Button
          title={t`Clear leave`}
          variant="tertiary"
          onClick={handleClearLeave}
          isLoading={isSavingSalesLeave}
        />
      </StyledActionsRow>
    </>
  );

  if (variant === 'simple') {
    return (
      <StyledLeavePanel>
        <StyledSimpleTitle>{t`Leave`}</StyledSimpleTitle>
        {content}
      </StyledLeavePanel>
    );
  }

  return (
    <Section>
      <H2Title
        title={t`Leave`}
        description={t`Set your leave period. You will not be assigned new leads while on leave.`}
      />
      {content}
    </Section>
  );
};

const StyledLeavePanel = styled.div`
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.sm};
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(3)};
  padding: ${({ theme }) => theme.spacing(3)};
`;
