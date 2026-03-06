import { Field, InputType } from '@nestjs/graphql';

import { NotificationType } from 'src/engine/core-modules/notification/enums/notification-type.enum';

@InputType()
export class NotificationFilterInput {
  @Field(() => NotificationType, { nullable: true })
  type?: NotificationType;

  @Field({ nullable: true })
  isRead?: boolean;
}
