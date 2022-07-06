/* Database schema to keep the structure of entire database. */
CREATE TABLE animals(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
              name VARCHAR(100),
              date_of_birth DATE,
              escape_attempts INT,
              neutered BOOLEAN,
              weight_kg DECIMAL,
            );

ALTER TABLE animals ADD species VARCHAR(100);

/* Add onwer and species table to vet_clinic database. */
CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(100),
    age INT
);

CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100)
);
