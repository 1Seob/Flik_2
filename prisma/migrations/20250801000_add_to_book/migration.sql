-- AlterTable
ALTER TABLE "book" ADD COLUMN     "isbn" TEXT,
ADD COLUMN     "totalParagraphsCount" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "views" INTEGER NOT NULL DEFAULT 0;