import { Field, InputType } from '@nestjs/graphql';

export enum NotificationOrderByDirection {
  ASC = 'ASC',
  DESC = 'DESC',
}

@InputType()
export class NotificationOrderByInput {
  @Field({ nullable: true })
  field: string = 'createdAt';

  @Field(() => NotificationOrderByDirection, { nullable: true })
  direction: NotificationOrderByDirection = NotificationOrderByDirection.DESC;
}
