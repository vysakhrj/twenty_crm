import { Field, InputType } from '@nestjs/graphql';

import { IsNotEmpty, IsString, MaxLength } from 'class-validator';

@InputType()
export class UpsertFcmTokenInput {
  @Field()
  @IsString()
  @IsNotEmpty()
  @MaxLength(4000)
  token: string;

  @Field()
  @IsString()
  @IsNotEmpty()
  @MaxLength(255)
  deviceId: string;
}
