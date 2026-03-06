import { type MigrationInterface, type QueryRunner } from 'typeorm';

export class CreateNotificationEntity1769900000000
  implements MigrationInterface
{
  name = 'CreateNotificationEntity1769900000000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TYPE "core"."notification_type_enum" AS ENUM('lead_assigned', 'follow_up_reminder', 'ticket_assigned')`,
    );
    await queryRunner.query(
      `CREATE TABLE "core"."notification" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "userId" uuid NOT NULL, "type" "core"."notification_type_enum" NOT NULL, "title" character varying NOT NULL, "body" character varying NOT NULL, "metadata" jsonb DEFAULT '{}', "isRead" boolean NOT NULL DEFAULT false, "readAt" TIMESTAMP WITH TIME ZONE, "emailSent" boolean NOT NULL DEFAULT false, "pushSent" boolean NOT NULL DEFAULT false, "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(), "workspaceId" uuid NOT NULL, CONSTRAINT "PK_notification_id" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE INDEX "IDX_NOTIFICATION_USER_ID" ON "core"."notification" ("userId")`,
    );
    await queryRunner.query(
      `CREATE INDEX "IDX_NOTIFICATION_WORKSPACE_ID" ON "core"."notification" ("workspaceId")`,
    );
    await queryRunner.query(
      `CREATE INDEX "IDX_NOTIFICATION_IS_READ" ON "core"."notification" ("isRead")`,
    );
    await queryRunner.query(
      `CREATE INDEX "IDX_NOTIFICATION_CREATED_AT" ON "core"."notification" ("createdAt")`,
    );
    await queryRunner.query(
      `ALTER TABLE "core"."notification" ADD CONSTRAINT "FK_notification_userId" FOREIGN KEY ("userId") REFERENCES "core"."user"("id") ON DELETE CASCADE ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "core"."notification" ADD CONSTRAINT "FK_notification_workspaceId" FOREIGN KEY ("workspaceId") REFERENCES "core"."workspace"("id") ON DELETE CASCADE ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "core"."notification" DROP CONSTRAINT "FK_notification_workspaceId"`,
    );
    await queryRunner.query(
      `ALTER TABLE "core"."notification" DROP CONSTRAINT "FK_notification_userId"`,
    );
    await queryRunner.query(
      `DROP INDEX "core"."IDX_NOTIFICATION_CREATED_AT"`,
    );
    await queryRunner.query(
      `DROP INDEX "core"."IDX_NOTIFICATION_IS_READ"`,
    );
    await queryRunner.query(
      `DROP INDEX "core"."IDX_NOTIFICATION_WORKSPACE_ID"`,
    );
    await queryRunner.query(
      `DROP INDEX "core"."IDX_NOTIFICATION_USER_ID"`,
    );
    await queryRunner.query(`DROP TABLE "core"."notification"`);
    await queryRunner.query(`DROP TYPE "core"."notification_type_enum"`);
  }
}
