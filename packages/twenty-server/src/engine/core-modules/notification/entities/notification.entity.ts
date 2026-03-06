import { Field, ObjectType, registerEnumType } from '@nestjs/graphql';
import { IDField } from '@ptc-org/nestjs-query-graphql';
import graphqlTypeJson from 'graphql-type-json';
import {
  Column,
  CreateDateColumn,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
  type Relation,
  UpdateDateColumn,
} from 'typeorm';

import { UUIDScalarType } from 'src/engine/api/graphql/workspace-schema-builder/graphql-types/scalars';
import { NotificationType } from 'src/engine/core-modules/notification/enums/notification-type.enum';
import { UserEntity } from 'src/engine/core-modules/user/user.entity';
import { WorkspaceRelatedEntity } from 'src/engine/workspace-manager/types/workspace-related-entity';

registerEnumType(NotificationType, { name: 'NotificationType' });

export type NotificationMetadata = {
  leadId?: string;
  ticketId?: string;
  taskId?: string;
  [key: string]: string | undefined;
};

@Entity({ name: 'notification', schema: 'core' })
@Index('IDX_NOTIFICATION_USER_ID', ['userId'])
@Index('IDX_NOTIFICATION_WORKSPACE_ID', ['workspaceId'])
@Index('IDX_NOTIFICATION_IS_READ', ['isRead'])
@Index('IDX_NOTIFICATION_CREATED_AT', ['createdAt'])
@ObjectType('Notification')
export class NotificationEntity extends WorkspaceRelatedEntity {
  @IDField(() => UUIDScalarType)
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ nullable: false, type: 'uuid' })
  userId: string;

  @ManyToOne(() => UserEntity, {
    nullable: false,
    onDelete: 'CASCADE',
    createForeignKeyConstraints: false,
  })
  @JoinColumn({ name: 'userId' })
  user: Relation<UserEntity>;

  @Field(() => NotificationType)
  @Column({
    type: 'enum',
    enum: Object.values(NotificationType),
    nullable: false,
  })
  type: NotificationType;

  @Field()
  @Column({ nullable: false })
  title: string;

  @Field()
  @Column({ nullable: false })
  body: string;

  @Field(() => graphqlTypeJson, { nullable: true })
  @Column({ nullable: true, type: 'jsonb', default: {} })
  metadata: NotificationMetadata;

  @Field()
  @Column({ nullable: false, default: false })
  isRead: boolean;

  @Field(() => Date, { nullable: true })
  @Column({ nullable: true, type: 'timestamptz' })
  readAt: Date | null;

  @Column({ nullable: false, default: false })
  emailSent: boolean;

  @Column({ nullable: false, default: false })
  pushSent: boolean;

  @Field()
  @CreateDateColumn({ type: 'timestamptz' })
  createdAt: Date;

  @Field()
  @UpdateDateColumn({ type: 'timestamptz' })
  updatedAt: Date;
}
