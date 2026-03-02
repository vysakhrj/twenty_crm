import { SettingsTextInput } from '@/ui/input/components/SettingsTextInput';
import { t } from '@lingui/core/macro';

type MemberNameFieldsProps = {
  memberId: string;
  firstName: string;
  lastName: string;
  onChange: (field: 'firstName' | 'lastName', value: string) => void;
  disabled?: boolean;
};

export const MemberNameFields = ({
  memberId,
  firstName,
  lastName,
  onChange,
  disabled = false,
}: MemberNameFieldsProps) => {
  const firstNameInstanceId = `${memberId}-first-name`;
  const lastNameInstanceId = `${memberId}-last-name`;

  return (
    <>
      <SettingsTextInput
        instanceId={firstNameInstanceId}
        label={t`First Name`}
        value={firstName}
        placeholder={t`Tim`}
        onChange={(value) => {
          onChange('firstName', value);
        }}
        disabled={disabled}
        fullWidth
      />
      <SettingsTextInput
        instanceId={lastNameInstanceId}
        label={t`Last name`}
        value={lastName}
        placeholder={t`Cook`}
        onChange={(value) => {
          onChange('lastName', value);
        }}
        disabled={disabled}
        fullWidth
      />
    </>
  );
};
