-- Primero: Crear los tipos ENUM necesarios
CREATE TYPE user_status AS ENUM ('Active', 'Inactive', 'Suspended');
CREATE TYPE pet_gender AS ENUM ('Male', 'Female');
CREATE TYPE pet_status AS ENUM ('Active', 'Inactive', 'Deceased');
CREATE TYPE service_category AS ENUM ('Consultation', 'Vaccination', 'Surgery', 'Grooming', 'Dental', 'Emergency', 'Other');
CREATE TYPE service_status AS ENUM ('Available', 'Unavailable');
CREATE TYPE consultation_priority AS ENUM ('Low', 'Medium', 'High', 'Emergency');
CREATE TYPE consultation_status AS ENUM ('Open', 'Closed');
CREATE TYPE treatment_status AS ENUM ('Active', 'Completed', 'Cancelled');
CREATE TYPE stock_type AS ENUM ('Medicine', 'Vaccine', 'Accessory', 'Food', 'Other');
CREATE TYPE stock_status AS ENUM ('Available', 'Out of Stock', 'Discontinued');
CREATE TYPE surgery_type AS ENUM ('Sterilization', 'Emergency', 'Orthopedic', 'Dental', 'Other');
CREATE TYPE surgery_status AS ENUM ('Scheduled', 'In Progress', 'Completed', 'Cancelled');

-- Ahora crear las tablas
CREATE TABLE "roles" (
  "id" serial PRIMARY KEY,
  "name" varchar(13) UNIQUE NOT NULL,
  "permissions" json NOT NULL
);

CREATE TABLE "users" (
  "id" serial PRIMARY KEY,
  "role_id" integer NOT NULL,
  "ci" varchar(20) UNIQUE NOT NULL,
  "first_name" varchar(20) NOT NULL,
  "last_name" varchar(20) NOT NULL,
  "dob" date NOT NULL,
  "phone" varchar(20) NOT NULL,
  "address" text NOT NULL,
  "username" varchar(50) UNIQUE NOT NULL,
  "email" varchar(100) UNIQUE NOT NULL,
  "password" varchar(60) NOT NULL,
  "photo" text NOT NULL,
  "status" user_status DEFAULT 'Active',
  "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE "species" (
  "id" serial PRIMARY KEY,
  "name" varchar(50) NOT NULL
);

CREATE TABLE "pets" (
  "id" serial PRIMARY KEY,
  "owner_id" integer NOT NULL,
  "species_id" integer NOT NULL,
  "name" varchar(30) NOT NULL,
  "race" varchar(50) NOT NULL,
  "dob" date NOT NULL,
  "gender" pet_gender NOT NULL,
  "color" varchar(30) NOT NULL,
  "status" pet_status DEFAULT 'Active',
  "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE "services" (
  "id" serial PRIMARY KEY,
  "name" varchar(50) NOT NULL,
  "category" service_category NOT NULL,
  "cost" decimal(10,2) NOT NULL,
  "status" service_status DEFAULT 'Available'
);

CREATE TABLE "consultations" (
  "id" serial PRIMARY KEY,
  "veterinarian_id" integer NOT NULL,
  "pet_id" integer NOT NULL,
  "reason" text NOT NULL,
  "priority" consultation_priority NOT NULL,
  "diagnosis" text NOT NULL,
  "notes" text,
  "status" consultation_status DEFAULT 'Open',
  "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE "treatments" (
  "id" serial PRIMARY KEY,
  "pet_id" integer NOT NULL,
  "consultation_id" integer NOT NULL,
  "status" treatment_status DEFAULT 'Active',
  "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE "stocks" (
  "id" serial PRIMARY KEY,
  "name" varchar(50) NOT NULL,
  "type" stock_type NOT NULL,
  "quantity" integer NOT NULL,
  "unit_price" decimal(10,2) NOT NULL,
  "status" stock_status DEFAULT 'Available',
  "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE "prescriptions" (
  "id" serial PRIMARY KEY,
  "medication_id" integer NOT NULL,
  "instructions" text NOT NULL
);

CREATE TABLE "surgeries" (
  "id" serial PRIMARY KEY,
  "pet_id" integer NOT NULL,
  "veterinarian_id" integer NOT NULL,
  "date" date NOT NULL,
  "type" surgery_type NOT NULL,
  "notes" text,
  "status" surgery_status DEFAULT 'Scheduled',
  "created_at" timestamp DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" timestamp DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE "treatment_prescriptions" (
  "id" serial PRIMARY KEY,
  "treatment_id" integer NOT NULL,
  "prescription_id" integer NOT NULL
);

CREATE TABLE "consultation_services" (
  "id" serial PRIMARY KEY,
  "consultation_id" integer NOT NULL,
  "service_id" integer NOT NULL
);

CREATE TABLE "treatment_services" (
  "id" serial PRIMARY KEY,
  "treatment_id" integer NOT NULL,
  "service_id" integer NOT NULL
);

CREATE TABLE "surgery_services" (
  "id" serial PRIMARY KEY,
  "surgery_id" integer NOT NULL,
  "service_id" integer NOT NULL
);

-- Agregar las foreign keys
ALTER TABLE "users" ADD FOREIGN KEY ("role_id") REFERENCES "roles" ("id");

ALTER TABLE "pets" ADD FOREIGN KEY ("owner_id") REFERENCES "users" ("id");

ALTER TABLE "pets" ADD FOREIGN KEY ("species_id") REFERENCES "species" ("id");

ALTER TABLE "consultations" ADD FOREIGN KEY ("veterinarian_id") REFERENCES "users" ("id");

ALTER TABLE "consultations" ADD FOREIGN KEY ("pet_id") REFERENCES "pets" ("id");

ALTER TABLE "treatments" ADD FOREIGN KEY ("pet_id") REFERENCES "pets" ("id");

ALTER TABLE "treatments" ADD FOREIGN KEY ("consultation_id") REFERENCES "consultations" ("id");

ALTER TABLE "prescriptions" ADD FOREIGN KEY ("medication_id") REFERENCES "stocks" ("id");

ALTER TABLE "surgeries" ADD FOREIGN KEY ("pet_id") REFERENCES "pets" ("id");

ALTER TABLE "surgeries" ADD FOREIGN KEY ("veterinarian_id") REFERENCES "users" ("id");

ALTER TABLE "treatment_prescriptions" ADD FOREIGN KEY ("treatment_id") REFERENCES "treatments" ("id");

ALTER TABLE "treatment_prescriptions" ADD FOREIGN KEY ("prescription_id") REFERENCES "prescriptions" ("id");

ALTER TABLE "consultation_services" ADD FOREIGN KEY ("consultation_id") REFERENCES "consultations" ("id");

ALTER TABLE "consultation_services" ADD FOREIGN KEY ("service_id") REFERENCES "services" ("id");

ALTER TABLE "treatment_services" ADD FOREIGN KEY ("treatment_id") REFERENCES "treatments" ("id");

ALTER TABLE "treatment_services" ADD FOREIGN KEY ("service_id") REFERENCES "services" ("id");

ALTER TABLE "surgery_services" ADD FOREIGN KEY ("surgery_id") REFERENCES "surgeries" ("id");

ALTER TABLE "surgery_services" ADD FOREIGN KEY ("service_id") REFERENCES "services" ("id");