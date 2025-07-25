-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE');

-- CreateTable
CREATE TABLE "user" (
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "id" SERIAL NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "refresh_token" TEXT,
    "birthday" TIMESTAMP(3) NOT NULL,
    "gender" "Gender" NOT NULL,
    "login_id" TEXT NOT NULL,
    "profile_image_url" TEXT,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "book" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "author" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "coverImageUrl" TEXT,

    CONSTRAINT "book_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "paragraph" (
    "id" SERIAL NOT NULL,
    "content" TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    "bookId" INTEGER NOT NULL,

    CONSTRAINT "paragraph_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "category" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "paragraph-like" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "paragraphId" INTEGER NOT NULL,

    CONSTRAINT "paragraph-like_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "book-like" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "bookId" INTEGER NOT NULL,

    CONSTRAINT "book-like_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user-book" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "bookId" INTEGER NOT NULL,

    CONSTRAINT "user-book_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user-category" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "categoryId" INTEGER NOT NULL,

    CONSTRAINT "user-category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "book-save" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "bookId" INTEGER NOT NULL,

    CONSTRAINT "book-save_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user-reading-activity" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "book_id" INTEGER NOT NULL,
    "paragraph_id" INTEGER NOT NULL,
    "order" INTEGER NOT NULL,
    "read_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completed_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "daily_goal" INTEGER,

    CONSTRAINT "user-reading-activity_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_name_key" ON "user"("name");

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "user_login_id_key" ON "user"("login_id");

-- CreateIndex
CREATE UNIQUE INDEX "category_name_key" ON "category"("name");

-- CreateIndex
CREATE UNIQUE INDEX "paragraph-like_userId_paragraphId_key" ON "paragraph-like"("userId", "paragraphId");

-- CreateIndex
CREATE UNIQUE INDEX "book-like_userId_bookId_key" ON "book-like"("userId", "bookId");

-- CreateIndex
CREATE UNIQUE INDEX "user-book_userId_bookId_key" ON "user-book"("userId", "bookId");

-- CreateIndex
CREATE UNIQUE INDEX "user-category_userId_categoryId_key" ON "user-category"("userId", "categoryId");

-- CreateIndex
CREATE UNIQUE INDEX "book-save_userId_bookId_key" ON "book-save"("userId", "bookId");

-- CreateIndex
CREATE UNIQUE INDEX "user-reading-activity_user_id_book_id_paragraph_id_read_at_key" ON "user-reading-activity"("user_id", "book_id", "paragraph_id", "read_at");

-- AddForeignKey
ALTER TABLE "paragraph" ADD CONSTRAINT "paragraph_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "book"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "paragraph-like" ADD CONSTRAINT "paragraph-like_paragraphId_fkey" FOREIGN KEY ("paragraphId") REFERENCES "paragraph"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "paragraph-like" ADD CONSTRAINT "paragraph-like_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book-like" ADD CONSTRAINT "book-like_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "book"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book-like" ADD CONSTRAINT "book-like_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user-book" ADD CONSTRAINT "user-book_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "book"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user-book" ADD CONSTRAINT "user-book_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user-category" ADD CONSTRAINT "user-category_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user-category" ADD CONSTRAINT "user-category_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book-save" ADD CONSTRAINT "book-save_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "book"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book-save" ADD CONSTRAINT "book-save_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user-reading-activity" ADD CONSTRAINT "user-reading-activity_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "book"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user-reading-activity" ADD CONSTRAINT "user-reading-activity_paragraph_id_fkey" FOREIGN KEY ("paragraph_id") REFERENCES "paragraph"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user-reading-activity" ADD CONSTRAINT "user-reading-activity_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

