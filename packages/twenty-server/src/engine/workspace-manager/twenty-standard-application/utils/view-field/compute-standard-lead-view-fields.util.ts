import { type FlatViewField } from 'src/engine/metadata-modules/flat-view-field/types/flat-view-field.type';
import {
  createStandardViewFieldFlatMetadata,
  type CreateStandardViewFieldArgs,
} from 'src/engine/workspace-manager/twenty-standard-application/utils/view-field/create-standard-view-field-flat-metadata.util';

export const computeStandardLeadViewFields = (
  args: Omit<CreateStandardViewFieldArgs<'lead'>, 'context'>,
): Record<string, FlatViewField> => {
  return {
    allLeadsTitle: createStandardViewFieldFlatMetadata({
      ...args,
      objectName: 'lead',
      context: {
        viewName: 'allLeads',
        viewFieldName: 'title',
        fieldName: 'title',
        position: 0,
        isVisible: true,
        size: 210,
      },
    }),
    allLeadsStatus: createStandardViewFieldFlatMetadata({
      ...args,
      objectName: 'lead',
      context: {
        viewName: 'allLeads',
        viewFieldName: 'status',
        fieldName: 'status',
        position: 1,
        isVisible: true,
        size: 150,
      },
    }),
    allLeadsCreatedBy: createStandardViewFieldFlatMetadata({
      ...args,
      objectName: 'lead',
      context: {
        viewName: 'allLeads',
        viewFieldName: 'createdBy',
        fieldName: 'createdBy',
        position: 2,
        isVisible: true,
        size: 150,
      },
    }),
    allLeadsDueAt: createStandardViewFieldFlatMetadata({
      ...args,
      objectName: 'lead',
      context: {
        viewName: 'allLeads',
        viewFieldName: 'dueAt',
        fieldName: 'dueAt',
        position: 3,
        isVisible: true,
        size: 150,
      },
    }),
    allLeadsAssignee: createStandardViewFieldFlatMetadata({
      ...args,
      objectName: 'lead',
      context: {
        viewName: 'allLeads',
        viewFieldName: 'assignee',
        fieldName: 'assignee',
        position: 4,
        isVisible: true,
        size: 150,
      },
    }),
    allLeadsPerson: createStandardViewFieldFlatMetadata({
      ...args,
      objectName: 'lead',
      context: {
        viewName: 'allLeads',
        viewFieldName: 'person',
        fieldName: 'person',
        position: 5,
        isVisible: true,
        size: 150,
      },
    }),
    allLeadsBodyV2: createStandardViewFieldFlatMetadata({
      ...args,
      objectName: 'lead',
      context: {
        viewName: 'allLeads',
        viewFieldName: 'bodyV2',
        fieldName: 'bodyV2',
        position: 6,
        isVisible: true,
        size: 150,
      },
    }),
    allLeadsCreatedAt: createStandardViewFieldFlatMetadata({
      ...args,
      objectName: 'lead',
      context: {
        viewName: 'allLeads',
        viewFieldName: 'createdAt',
        fieldName: 'createdAt',
        position: 7,
        isVisible: true,
        size: 150,
      },
    }),
  };
};
