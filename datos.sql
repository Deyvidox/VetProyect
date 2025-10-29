-- 1. Insertar roles
INSERT INTO "roles" ("name", "permissions") VALUES
('Admin', '{"all": true, "users": ["create", "read", "update", "delete"], "pets": ["create", "read", "update", "delete"], "consultations": ["create", "read", "update", "delete"]}'),
('Veterinarian', '{"users": ["read"], "pets": ["create", "read", "update"], "consultations": ["create", "read", "update", "delete"], "treatments": ["create", "read", "update"]}'),
('Client', '{"pets": ["read"], "consultations": ["read"]}');

-- 2. Insertar usuarios
INSERT INTO "users" ("role_id", "ci", "first_name", "last_name", "dob", "phone", "address", "username", "email", "password", "photo") VALUES
(1, '12345678', 'María', 'Gonzalez', '1985-03-15', '+584123456789', 'Av. Principal #123, Caracas', 'maria.admin', 'maria@vetclinic.com', '$2b$10$examplehash123', 'maria.jpg'),
(2, '87654321', 'Carlos', 'Rodríguez', '1990-07-22', '+584987654321', 'Calle 45 #67-89, Valencia', 'carlos.vet', 'carlos@vetclinic.com', '$2b$10$examplehash456', 'carlos.jpg'),
(3, '11223344', 'Ana', 'Pérez', '1992-11-30', '+584146372819', 'Urbanización Las Acacias, Maracay', 'ana.client', 'ana.perez@email.com', '$2b$10$examplehash789', 'ana.jpg');

-- 3. Insertar especies
INSERT INTO "species" ("name") VALUES
('Perro'),
('Gato'),
('Conejo');

-- 4. Insertar mascotas
INSERT INTO "pets" ("owner_id", "species_id", "name", "race", "dob", "gender", "color") VALUES
(3, 1, 'Max', 'Labrador Retriever', '2020-05-10', 'Male', 'Dorado'),
(3, 2, 'Luna', 'Siamés', '2021-02-15', 'Female', 'Blanco y café'),
(3, 1, 'Rocky', 'Bulldog Francés', '2019-08-20', 'Male', 'Atigrado');

-- 5. Insertar servicios
INSERT INTO "services" ("name", "category", "cost") VALUES
('Consulta General', 'Consultation', 25.00),
('Vacuna Triple Felina', 'Vaccination', 35.50),
('Cirugía de Esterilización', 'Surgery', 120.00),
('Limpieza Dental', 'Dental', 45.00),
('Urgencias 24h', 'Emergency', 50.00),
('Baño y Corte', 'Grooming', 20.00);

-- 6. Insertar stock/inventario
INSERT INTO "stocks" ("name", "type", "quantity", "unit_price") VALUES
('Amoxicilina 500mg', 'Medicine', 100, 15.75),
('Vacuna Rabia', 'Vaccine', 50, 28.30),
('Correa Ajustable', 'Accessory', 25, 12.00),
('Comida Premium Gato', 'Food', 80, 45.00),
('Antipulgas', 'Medicine', 60, 22.50),
('Juguete Hueso', 'Accessory', 40, 8.99);

-- 7. Insertar consultas
INSERT INTO "consultations" ("veterinarian_id", "pet_id", "reason", "priority", "diagnosis", "notes") VALUES
(2, 1, 'Control anual y vacunación', 'Low', 'Salud óptima, peso ideal', 'Aplicada vacuna anual, próximo control en 6 meses'),
(2, 2, 'Fiebre y decaimiento', 'High', 'Infección respiratoria leve', 'Recetado antibiótico por 7 días, reposo'),
(2, 3, 'Revisión dental', 'Medium', 'Sarro moderado en molares', 'Recomendada limpieza dental programada');

-- 8. Insertar tratamientos
INSERT INTO "treatments" ("pet_id", "consultation_id", "status") VALUES
(1, 1, 'Completed'),
(2, 2, 'Active'),
(3, 3, 'Active');

-- 9. Insertar prescripciones
INSERT INTO "prescriptions" ("medication_id", "instructions") VALUES
(1, 'Tomar 1 tableta cada 12 horas por 7 días con comida'),
(5, 'Aplicar 1 pipeta en la nuca cada mes'),
(1, 'Media tableta cada 24 horas por 5 días');

-- 10. Insertar cirugías
INSERT INTO "surgeries" ("pet_id", "veterinarian_id", "date", "type", "notes") VALUES
(1, 2, '2024-02-15', 'Sterilization', 'Cirugía programada para esterilización rutinaria'),
(2, 2, '2024-01-20', 'Dental', 'Extracción de molar dañado'),
(3, 2, '2024-03-10', 'Emergency', 'Herida por accidente, requiere sutura');

-- 11. Insertar relación tratamiento-prescripción
INSERT INTO "treatment_prescriptions" ("treatment_id", "prescription_id") VALUES
(1, 1),
(2, 2),
(3, 3);

-- 12. Insertar relación consulta-servicios
INSERT INTO "consultation_services" ("consultation_id", "service_id") VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 5),
(3, 1);

-- 13. Insertar relación tratamiento-servicios
INSERT INTO "treatment_services" ("treatment_id", "service_id") VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 5),
(3, 1),
(3, 4);

-- 14. Insertar relación cirugía-servicios
INSERT INTO "surgery_services" ("surgery_id", "service_id") VALUES
(1, 3),
(2, 4),
(3, 5);

-- Más usuarios para testing
INSERT INTO "users" ("role_id", "ci", "first_name", "last_name", "dob", "phone", "address", "username", "email", "password", "photo", "status") VALUES
(3, '55667788', 'Luis', 'Martínez', '1988-09-14', '+584125463789', 'Sector La Floresta, Barquisimeto', 'luis.client', 'luis.martinez@email.com', '$2b$10$examplehashabc', 'luis.jpg', 'Active'),
(2, '99887766', 'Elena', 'Silva', '1987-12-03', '+584198765432', 'Residencias El Parque, Puerto Ordaz', 'elena.vet', 'elena@vetclinic.com', '$2b$10$examplehashdef', 'elena.jpg', 'Active');

-- Más mascotas
INSERT INTO "pets" ("owner_id", "species_id", "name", "race", "dob", "gender", "color", "status") VALUES
(4, 2, 'Mimi', 'Persa', '2022-01-08', 'Female', 'Gris', 'Active'),
(4, 3, 'Snowball', 'Enano', '2021-11-25', 'Male', 'Blanco', 'Active'),
(3, 1, 'Rex', 'Pastor Alemán', '2018-04-12', 'Male', 'Negro y café', 'Active');

-- Consulta con diferentes estados
INSERT INTO "consultations" ("veterinarian_id", "pet_id", "reason", "priority", "diagnosis", "notes", "status") VALUES
(2, 4, 'Primera consulta', 'Low', 'Salud normal', 'Nueva paciente', 'Closed'),
(5, 5, 'Control crecimiento', 'Low', 'Desarrollo adecuado', 'Dieta balanceada', 'Open');