import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddCanReadOwnObjectRecordsOnlyToRole1769500000000
  implements MigrationInterface
{
  name = 'AddCanReadOwnObjectRecordsOnlyToRole1769500000000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "core"."role" ADD COLUMN IF NOT EXISTS "canReadOwnObjectRecordsOnly" boolean NOT NULL DEFAULT false`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "core"."role" DROP COLUMN IF EXISTS "canReadOwnObjectRecordsOnly"`,
    );
  }
}
