import styled from '@emotion/styled';
import { useState } from 'react';

import { MemberEmailField } from '@/settings/members/components/MemberEmailField';
import { MemberNameFields } from '@/settings/members/components/MemberNameFields';
import { MemberSalesAvailabilitySection } from '@/settings/members/components/MemberSalesAvailabilitySection';
import { WorkspaceMemberPictureUploader } from '@/settings/workspace-member/components/WorkspaceMemberPictureUploader';
import { type WorkspaceMember } from '@/workspace-member/types/WorkspaceMember';
import { t } from '@lingui/core/macro';
import { H2Title } from 'twenty-ui/display';
import { Button } from 'twenty-ui/input';
import { Section } from 'twenty-ui/layout';

type MemberInfosTabProps = {
  member: WorkspaceMember;
  onNameChange: (firstName: string, lastName: string) => void;
  onImpersonate?: () => void;
  onDelete?: () => void;
  isSalesMember: boolean;
  canManageSalesSettings: boolean;
  canEditDetails: boolean;
};

const StyledNameRow = styled.div`
  display: grid;
  gap: ${({ theme }) => theme.spacing(3)};
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
`;

const StyledActionRow = styled.div`
  display: flex;
  gap: ${({ theme }) => theme.spacing(2)};
`;

export const MemberInfosTab = ({
  member,
  onNameChange,
  onImpersonate,
  onDelete,
  isSalesMember,
  canManageSalesSettings,
  canEditDetails,
}: MemberInfosTabProps) => {
  const [firstName, setFirstName] = useState(member.name.firstName);
  const [lastName, setLastName] = useState(member.name.lastName);
  const [avatarUrl, setAvatarUrl] = useState<string | null>(
    member.avatarUrl || null,
  );

  return (
    <>
      <Section>
        <H2Title title={t`Picture`} />
        <WorkspaceMemberPictureUploader
          workspaceMemberId={member.id}
          avatarUrl={avatarUrl}
          onAvatarUpdated={setAvatarUrl}
          disabled={!canEditDetails}
        />
      </Section>

      <Section>
        <H2Title
          title={t`Name`}
          description={t`As it will be displayed in the workspace`}
        />
        <StyledNameRow>
          <MemberNameFields
            memberId={member.id}
            firstName={firstName}
            lastName={lastName}
            onChange={(field, value) => {
              if (!canEditDetails) {
                return;
              }

              if (field === 'firstName') {
                setFirstName(value);
                onNameChange(value, lastName);
              } else {
                setLastName(value);
                onNameChange(firstName, value);
              }
            }}
            disabled={!canEditDetails}
          />
        </StyledNameRow>
      </Section>

      <Section>
        <H2Title
          title={t`Email`}
          description={t`The email associated to this account`}
        />
        <MemberEmailField email={member.userEmail} />
      </Section>

      <MemberSalesAvailabilitySection
        member={member}
        isSalesMember={isSalesMember}
        canEdit={canManageSalesSettings && canEditDetails}
      />

      <Section>
        <H2Title
          title={t`Admin`}
          description={t`Perform administrative actions or permanently delete this user`}
        />
        <StyledActionRow>
          {onImpersonate && (
            <Button
              title={t`Impersonate`}
              variant="secondary"
              size="small"
              onClick={onImpersonate}
            />
          )}
          {onDelete && (
            <Button
              accent="danger"
              title={t`Delete account`}
              variant="secondary"
              size="small"
              onClick={onDelete}
            />
          )}
        </StyledActionRow>
      </Section>
    </>
  );
};
