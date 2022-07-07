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
