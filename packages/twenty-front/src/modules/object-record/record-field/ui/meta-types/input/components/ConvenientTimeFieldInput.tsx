import { useContext } from 'react';
import { Temporal } from 'temporal-polyfill';

import { FieldInputEventContext } from '@/object-record/record-field/ui/contexts/FieldInputEventContext';
import { useConvenientTimeField } from '@/object-record/record-field/ui/meta-types/hooks/useConvenientTimeField';
import { RecordFieldComponentInstanceContext } from '@/object-record/record-field/ui/states/contexts/RecordFieldComponentInstanceContext';
import { DateTimeInput } from '@/ui/field/input/components/DateTimeInput';
import { useAvailableComponentInstanceIdOrThrow } from '@/ui/utilities/state/component-state/hooks/useAvailableComponentInstanceIdOrThrow';
import { isNonEmptyString } from '@sniptt/guards';
import { type Nullable } from 'twenty-ui/utilities';

const parseToTemporalInstant = (value: string): Nullable<Temporal.Instant> => {
  if (!isNonEmptyString(value)) return null;
  try {
    const instant = Temporal.Instant.from(value);
    return instant;
  } catch {
    return null;
  }
};

export const ConvenientTimeFieldInput = () => {
  const { fieldValue, setDraftValue } = useConvenientTimeField();

  const { onEnter, onEscape, onClickOutside, onSubmit } = useContext(
    FieldInputEventContext,
  );

  const instanceId = useAvailableComponentInstanceIdOrThrow(
    RecordFieldComponentInstanceContext,
  );

  const getDateToPersist = (newInstant: Nullable<Temporal.Instant>) => {
    if (!newInstant) {
      return '';
    }
    return newInstant.toString();
  };

  const handleEnter = (newDate: Nullable<Temporal.Instant>) => {
    onEnter?.({ newValue: getDateToPersist(newDate) });
  };

  const handleEscape = (newDate: Nullable<Temporal.Instant>) => {
    onEscape?.({ newValue: getDateToPersist(newDate) });
  };

  const handleClickOutside = (
    event: MouseEvent | TouchEvent,
    newDate: Nullable<Temporal.Instant>,
  ) => {
    onClickOutside?.({ newValue: getDateToPersist(newDate), event });
  };

  const handleChange = (newInstant: Nullable<Temporal.Instant>) => {
    setDraftValue(newInstant?.toString() ?? '');
  };

  const handleClear = () => {
    onSubmit?.({ newValue: '' });
  };

  const handleSubmit = (newInstant: Nullable<Temporal.Instant>) => {
    onSubmit?.({ newValue: getDateToPersist(newInstant) });
  };

  const dateValue = parseToTemporalInstant(fieldValue);

  return (
    <DateTimeInput
      instanceId={instanceId}
      onClickOutside={handleClickOutside}
      onEnter={handleEnter}
      onEscape={handleEscape}
      value={dateValue}
      clearable
      onChange={handleChange}
      onClear={handleClear}
      onSubmit={handleSubmit}
    />
  );
};
