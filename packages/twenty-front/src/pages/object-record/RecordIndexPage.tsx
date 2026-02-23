import { useRecoilValue } from 'recoil';
import { useParams } from 'react-router-dom';

import { MAIN_CONTEXT_STORE_INSTANCE_ID } from '@/context-store/constants/MainContextStoreInstanceId';
import { contextStoreCurrentObjectMetadataItemIdComponentState } from '@/context-store/states/contextStoreCurrentObjectMetadataItemIdComponentState';
import { ContextStoreComponentInstanceContext } from '@/context-store/states/contexts/ContextStoreComponentInstanceContext';
import { useObjectMetadataItems } from '@/object-metadata/hooks/useObjectMetadataItems';
import { RecordIndexContainerGater } from '@/object-record/record-index/components/RecordIndexContainerGater';
import { PageContainer } from '@/ui/layout/page/components/PageContainer';
import { SimpleRecordListPage } from '@/ui/layout/simple-view/components/SimpleRecordListPage';
import { isSimpleViewEnabledState } from '@/ui/layout/simple-view/states/isSimpleViewEnabledState';
import { useRecoilComponentValue } from '@/ui/utilities/state/component-state/hooks/useRecoilComponentValue';
import { isUndefined } from '@sniptt/guards';

export const RecordIndexPage = () => {
  const params = useParams<{ objectNamePlural: string }>();
  const contextStoreCurrentObjectMetadataItemId = useRecoilComponentValue(
    contextStoreCurrentObjectMetadataItemIdComponentState,
    MAIN_CONTEXT_STORE_INSTANCE_ID,
  );

  const { objectMetadataItems } = useObjectMetadataItems();
  const isSimpleViewEnabled = useRecoilValue(isSimpleViewEnabledState);

  // In simple view, resolve the object directly from URL params (no context store dependency)
  if (isSimpleViewEnabled) {
    const objectFromUrl = objectMetadataItems.find(
      (item) => item.namePlural === params.objectNamePlural,
    );

    if (objectFromUrl) {
      return (
        <SimpleRecordListPage
          objectNameSingular={objectFromUrl.nameSingular}
        />
      );
    }
  }

  if (isUndefined(contextStoreCurrentObjectMetadataItemId)) {
    return <></>;
  }

  const objectMetadataItem = objectMetadataItems.find(
    (objectMetadataItem) =>
      objectMetadataItem.id === contextStoreCurrentObjectMetadataItemId,
  );

  if (isUndefined(objectMetadataItem)) {
    return <></>;
  }

  return (
    <PageContainer>
      <ContextStoreComponentInstanceContext.Provider
        value={{
          instanceId: MAIN_CONTEXT_STORE_INSTANCE_ID,
        }}
      >
        <RecordIndexContainerGater />
      </ContextStoreComponentInstanceContext.Provider>
    </PageContainer>
  );
};
