-- public."JobTypes" definition

-- Drop table

-- DROP TABLE public."JobTypes";

CREATE TABLE public."JobTypes" (
	"JobTypeId" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE),
	"Name" text NULL,
	CONSTRAINT "PK_JobTypes" PRIMARY KEY ("JobTypeId")
);


-- public."OngType" definition

-- Drop table

-- DROP TABLE public."OngType";

CREATE TABLE public."OngType" (
	"OngTypeId" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE),
	"Name" text NULL,
	CONSTRAINT "PK_OngType" PRIMARY KEY ("OngTypeId")
);


-- public."Roles" definition

-- Drop table

-- DROP TABLE public."Roles";

CREATE TABLE public."Roles" (
	"RoleId" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE),
	"Name" text NULL,
	CONSTRAINT "PK_Roles" PRIMARY KEY ("RoleId")
);


-- public."Users" definition

-- Drop table

-- DROP TABLE public."Users";

CREATE TABLE public."Users" (
	"User_Id" uuid NOT NULL,
	"Name" text NOT NULL,
	"Email" text NOT NULL,
	"AvatarLink" text NULL,
	"Hash" text NOT NULL,
	"Salt" text NOT NULL,
	"RoleId" int4 NOT NULL,
	"CreatedAt" timestamptz NULL,
	"LastUpdatedAt" timestamptz NULL,
	CONSTRAINT "AK_Users_Email" UNIQUE ("Email"),
	CONSTRAINT "PK_Users" PRIMARY KEY ("User_Id"),
	CONSTRAINT "FK_Users_Roles_RoleId" FOREIGN KEY ("RoleId") REFERENCES public."Roles"("RoleId") ON DELETE CASCADE
);
CREATE INDEX "IX_Users_RoleId" ON public."Users" USING btree ("RoleId");


-- public."Assistants" definition

-- Drop table

-- DROP TABLE public."Assistants";

CREATE TABLE public."Assistants" (
	"AssistantId" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE),
	"Name" text NOT NULL,
	"Cnpj_Cpf" text NOT NULL,
	"Phone" text NULL,
	"Cep" text NOT NULL,
	"Email" text NOT NULL,
	"UserId" uuid NOT NULL,
	CONSTRAINT "AK_Assistants_Cnpj_Cpf" UNIQUE ("Cnpj_Cpf"),
	CONSTRAINT "AK_Assistants_Email" UNIQUE ("Email"),
	CONSTRAINT "PK_Assistants" PRIMARY KEY ("AssistantId"),
	CONSTRAINT "FK_Assistants_Users_UserId" FOREIGN KEY ("UserId") REFERENCES public."Users"("User_Id") ON DELETE CASCADE
);
CREATE INDEX "IX_Assistants_UserId" ON public."Assistants" USING btree ("UserId");


-- public."Ong" definition

-- Drop table

-- DROP TABLE public."Ong";

CREATE TABLE public."Ong" (
	"OngId" int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE),
	"OngName" text NOT NULL,
	"Cnpj" text NOT NULL,
	"Cep" text NOT NULL,
	"Email" text NOT NULL,
	"UserId" uuid NOT NULL,
	"OngTypeId" int4 NOT NULL,
	CONSTRAINT "AK_Ong_Cnpj" UNIQUE ("Cnpj"),
	CONSTRAINT "AK_Ong_Email" UNIQUE ("Email"),
	CONSTRAINT "PK_Ong" PRIMARY KEY ("OngId"),
	CONSTRAINT "FK_Ong_OngType_OngTypeId" FOREIGN KEY ("OngTypeId") REFERENCES public."OngType"("OngTypeId") ON DELETE CASCADE,
	CONSTRAINT "FK_Ong_Users_UserId" FOREIGN KEY ("UserId") REFERENCES public."Users"("User_Id") ON DELETE CASCADE
);
CREATE INDEX "IX_Ong_OngTypeId" ON public."Ong" USING btree ("OngTypeId");
CREATE INDEX "IX_Ong_UserId" ON public."Ong" USING btree ("UserId");


-- public."Posts" definition

-- Drop table

-- DROP TABLE public."Posts";

CREATE TABLE public."Posts" (
	"PostId" uuid NOT NULL,
	"Title" varchar(50) NOT NULL,
	"Content" text NOT NULL,
	"OngId" int4 NOT NULL,
	"AssistantId" int4 NULL,
	"CreatedAt" timestamptz NOT NULL,
	"FinishedAt" timestamptz NULL,
	"AssignedAt" timestamptz NULL,
	"StartDate" timestamptz NULL,
	"FinishDate" timestamptz NULL,
	CONSTRAINT "PK_Posts" PRIMARY KEY ("PostId"),
	CONSTRAINT "FK_Posts_Assistants_AssistantId" FOREIGN KEY ("AssistantId") REFERENCES public."Assistants"("AssistantId"),
	CONSTRAINT "FK_Posts_Ong_OngId" FOREIGN KEY ("OngId") REFERENCES public."Ong"("OngId") ON DELETE CASCADE
);
CREATE INDEX "IX_Posts_AssistantId" ON public."Posts" USING btree ("AssistantId");
CREATE INDEX "IX_Posts_OngId" ON public."Posts" USING btree ("OngId");