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

type LeadAssignedEmailProps = {
  leadName: string;
  leadId: string;
  workspaceName: string;
  serverUrl: string;
  locale: keyof typeof APP_LOCALES;
};

export const LeadAssignedEmail = ({
  leadName,
  leadId,
  workspaceName,
  serverUrl,
  locale,
}: LeadAssignedEmailProps) => {
  const i18n = createI18nInstance(locale);
  const leadUrl = `${serverUrl}/objects/leads/${leadId}`;

  return (
    <BaseEmail width={333} locale={locale}>
      <Title value={i18n._('New lead assigned to you')} />
      <MainText>
        <Trans
          id="A new lead has been assigned to you in <0>{workspaceName}</0>."
          values={{ workspaceName }}
          components={{
            0: <b />,
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
          "You're receiving this email because you have notifications enabled for lead assignments.",
        )}
      </MainText>
    </BaseEmail>
  );
};

LeadAssignedEmail.PreviewProps = {
  leadName: 'Acme Corporation',
  leadId: '123e4567-e89b-12d3-a456-426614174000',
  workspaceName: 'Sales Team',
  serverUrl: 'https://app.twenty.com',
  locale: 'en',
} as LeadAssignedEmailProps;

export default LeadAssignedEmail;
