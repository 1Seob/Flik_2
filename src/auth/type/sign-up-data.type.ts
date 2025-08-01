import { Gender } from '@prisma/client';

export type SignUpData = {
  loginId: string;
  gender: Gender;
  birthday: Date;
  email: string;
  password: string;
  name: string;
  interestCategories: number[];
};
