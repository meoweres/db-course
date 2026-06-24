-- CreateTable
CREATE TABLE "authors" (
    "id" SERIAL NOT NULL,
    "fullname" TEXT NOT NULL,
    "country" VARCHAR(60) NOT NULL,

    CONSTRAINT "authors_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bookauthorpublishers" (
    "book_id" INTEGER NOT NULL,
    "author_id" INTEGER NOT NULL,
    "publisher_id" INTEGER NOT NULL,

    CONSTRAINT "bookauthorpublishers_pkey" PRIMARY KEY ("book_id","author_id","publisher_id")
);

-- CreateTable
CREATE TABLE "bookloans" (
    "loan_id" INTEGER NOT NULL,
    "book_id" INTEGER NOT NULL,

    CONSTRAINT "bookloans_pkey" PRIMARY KEY ("loan_id","book_id")
);

-- CreateTable
CREATE TABLE "books" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "year" SMALLINT NOT NULL,
    "quantity" INTEGER NOT NULL,

    CONSTRAINT "books_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "genres" (
    "book_id" INTEGER NOT NULL,
    "genre" VARCHAR(50) NOT NULL,

    CONSTRAINT "genres_pkey" PRIMARY KEY ("book_id","genre")
);

-- CreateTable
CREATE TABLE "loans" (
    "id" SERIAL NOT NULL,
    "reader_id" INTEGER NOT NULL,
    "loan_date" DATE DEFAULT CURRENT_DATE,
    "due_date" DATE NOT NULL,
    "return_date" DATE,

    CONSTRAINT "loans_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "publishers" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "phone" VARCHAR(13) NOT NULL,
    "email" VARCHAR(100) NOT NULL,

    CONSTRAINT "publishers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "readers" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(30) NOT NULL,
    "surname" VARCHAR(30) NOT NULL,
    "phone" VARCHAR(13) NOT NULL,
    "email" VARCHAR(100),
    "address" TEXT NOT NULL,

    CONSTRAINT "readers_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "publishers_name_key" ON "publishers"("name");

-- CreateIndex
CREATE UNIQUE INDEX "publishers_phone_key" ON "publishers"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "publishers_email_key" ON "publishers"("email");

-- CreateIndex
CREATE UNIQUE INDEX "readers_phone_key" ON "readers"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "readers_email_key" ON "readers"("email");

-- AddForeignKey
ALTER TABLE "bookauthorpublishers" ADD CONSTRAINT "bookauthorpublishers_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "authors"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "bookauthorpublishers" ADD CONSTRAINT "bookauthorpublishers_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "books"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "bookauthorpublishers" ADD CONSTRAINT "bookauthorpublishers_publisher_id_fkey" FOREIGN KEY ("publisher_id") REFERENCES "publishers"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "bookloans" ADD CONSTRAINT "bookloans_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "books"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "bookloans" ADD CONSTRAINT "bookloans_loan_id_fkey" FOREIGN KEY ("loan_id") REFERENCES "loans"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "genres" ADD CONSTRAINT "genres_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "books"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "loans" ADD CONSTRAINT "loans_reader_id_fkey" FOREIGN KEY ("reader_id") REFERENCES "readers"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
