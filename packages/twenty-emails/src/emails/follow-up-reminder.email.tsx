import { Trans } from '@lingui/react';
import { emailTheme } from 'src/common-style';

import { BaseEmail } from 'src/components/BaseEmail';
import { CallToAction } from 'src/components/CallToAction';
import { HighlightedContainer } from 'src/components/HighlightedContainer';
import { HighlightedText } from 'src/components/HighlightedText';
import { MainText } from 'src/components/MainText';
import { Title } from 'src/components/Title';
import { createI18nInstance } from 'src/utils/i18n.utils';
import { type APP_LOCALES } from 'twenty-shared/translations';

type FollowUpReminderEmailProps = {
  leadName: string;
  leadId: string;
  dueDate: string;
  workspaceName: string;
  serverUrl: string;
  locale: keyof typeof APP_LOCALES;
};

export const FollowUpReminderEmail = ({
  leadName,
  leadId,
  dueDate,
  workspaceName,
  serverUrl,
  locale,
}: FollowUpReminderEmailProps) => {
  const i18n = createI18nInstance(locale);
  const leadUrl = `${serverUrl}/objects/leads/${leadId}`;

  return (
    <BaseEmail width={333} locale={locale}>
      <Title value={i18n._('Follow-up reminder')} />
      <MainText>
        <Trans
          id="This is a reminder that <0>{leadName}</0> is due for follow-up on <1>{dueDate}</1> in <2>{workspaceName}</2>."
          values={{ leadName, dueDate, workspaceName }}
          components={{
            0: <b />,
            1: <b />,
            2: <b />,
          }}
        />
        <br />
      </MainText>
      <HighlightedContainer>
        <HighlightedText value={leadName} />
        <CallToAction href={leadUrl} value={i18n._('View Lead')} />
      </HighlightedContainer>
      <MainText
        style={{
          color: emailTheme.font.colors.secondary,
          fontSize: '12px',
          marginTop: '20px',
        }}
      >
        {i18n._(
          "You're receiving this email because you have notifications enabled for follow-up reminders.",
        )}
      </MainText>
    </BaseEmail>
  );
};

FollowUpReminderEmail.PreviewProps = {
  leadName: 'Acme Corporation',
  leadId: '123e4567-e89b-12d3-a456-426614174000',
  dueDate: '2024-12-25',
  workspaceName: 'Sales Team',
  serverUrl: 'https://app.twenty.com',
  locale: 'en',
} as FollowUpReminderEmailProps;

export default FollowUpReminderEmail;
