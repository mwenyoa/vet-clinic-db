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

 /* remove species column in animals table*/
 ALTER TABLE animals DROP species;

 /*Add foreign key to animals table from species table*/
 ALTER TABLE animals ADD species_id INT;
 ALTER TABLE animals
 ADD CONSTRAINT species_id
 FOREIGN KEY(species_id) REFERENCES species(id);

 /*Add foreign key to animals table from owners table*/
 ALTER TABLE animals ADD  owners_id INT;
 ALTER TABLE animals 
 ADD CONSTRAINT owners_id
 FOREIGN KEY(owners_id) REFERENCES owners(id);

 /*Create a table named vets */
 CREATE TABLE vets(
   id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   name VARCHAR(200),
   age INT,
   date_of_graduation DATE
);

/* Create specialization table */
CREATE TABLE specializations(
    specialty_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    species_id INT REFERENCES species(id),
    vets_id INT REFERENCES vets(id)
);


/* create visits table */
CREATE TABLE visits(
    visits_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    animals_id INT REFERENCES animals(id),
    vets_id INT REFERENCES vets(id)
);
ALTER TABLE visits ADD date_of_visit DATE;

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Add animals_id index to visits table
CREATE INDEX visits_animals_id_asc ON visits(animals_id ASC);
-- Create vets_id index on visits table
CREATE INDEX visits_vets_id_asc ON visits(vets_id ASC);
-- CREATE email index on owners table
CREATE INDEX owners_email_asc ON owners(email, ASC);