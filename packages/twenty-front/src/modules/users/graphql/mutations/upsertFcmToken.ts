import { gql } from '@apollo/client';

export const UPSERT_FCM_TOKEN = gql`
  mutation UpsertFcmToken($input: UpsertFcmTokenInput!) {
    upsertFcmToken(input: $input)
  }
`;
