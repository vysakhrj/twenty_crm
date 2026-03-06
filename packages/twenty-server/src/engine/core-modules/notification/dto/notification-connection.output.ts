import { Field, ObjectType } from '@nestjs/graphql';

import { NotificationEntity } from 'src/engine/core-modules/notification/entities/notification.entity';

@ObjectType('NotificationPageInfo')
export class NotificationPageInfo {
  @Field(() => Boolean)
  hasNextPage: boolean;

  @Field(() => String, { nullable: true })
  endCursor: string | null;
}

@ObjectType()
export class NotificationConnection {
  @Field(() => [NotificationEntity])
  edges: NotificationEntity[];

  @Field(() => NotificationPageInfo)
  pageInfo: NotificationPageInfo;
}
