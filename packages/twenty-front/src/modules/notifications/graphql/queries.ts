import { gql } from '@apollo/client';

export const GET_NOTIFICATIONS = gql`
  query GetNotifications(
    $filter: NotificationFilterInput
    $first: Int
    $after: String
  ) {
    notifications(filter: $filter, first: $first, after: $after) {
      edges {
        id
        type
        title
        body
        metadata
        isRead
        readAt
        createdAt
      }
      pageInfo {
        hasNextPage
        endCursor
      }
    }
  }
`;

export const GET_UNREAD_NOTIFICATIONS_COUNT = gql`
  query GetUnreadNotificationsCount {
    unreadNotificationsCount
  }
`;

export const MARK_NOTIFICATION_AS_READ = gql`
  mutation MarkNotificationAsRead($id: String!) {
    markNotificationAsRead(id: $id) {
      id
      isRead
      readAt
    }
  }
`;

export const MARK_ALL_NOTIFICATIONS_AS_READ = gql`
  mutation MarkAllNotificationsAsRead {
    markAllNotificationsAsRead
  }
`;

export const DELETE_NOTIFICATION = gql`
  mutation DeleteNotification($id: String!) {
    deleteNotification(id: $id)
  }
`;

export const NOTIFICATION_RECEIVED_SUBSCRIPTION = gql`
  subscription NotificationReceived {
    notificationReceived {
      id
      type
      title
      body
      metadata
      isRead
      readAt
      createdAt
    }
  }
`;
