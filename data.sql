/* Populate database with sample data. */
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Agumon', 'Feb-03-2020', 0, true,  10.23),
      ('Gabumon', 'Nov-15-2018', 2, true,  8),
      ('Pikachu', 'Jan-7-2021', 1, false,  15.04),
      ('Devimon', 'May-12-2017', 5, true,  11),
      ('Charmander', 'Feb-08-2020', 0, false, 11), 
      ('Plantmon', 'Nov-15-2021', 2, true, 5.7),
      ('Squirtle', 'Apr-02-1993', 3, false, 12.13),
      ('Angemon', 'Jan-12-2005', 1, true, 45),
      ('Boarmon', 'Jun-7-2005', 7, true, 20.4),
      ('Blossom', 'Oct-13-1998', 3, true, 17),
      ('Ditto', 'May-14-2022', 4, true, 22);

/*Insert the following data into the owners table*/
INSERT INTO owners(full_name, age)
VALUES('Sam Smith', 34), ('Jennifer Orwell', 19),
      ('Bob', 45), ('Melody Pond', 77),
      ('Dean Winchester', 14), ('Jodie Whittaker', 38);

/*Insert the following data into species table*/
INSERT INTO species(name)
VALUES('Pokemon'), ('Digimon');

SELECT * FROM species;

/* Modify your inserted animals so it includes the species_id value:
If the name ends in "mon" it will be Digimon */
UPDATE animals SET species_id = (
SELECT id FROM species WHERE name ='Digimon') 
WHERE name LIKE '%mon';
SELECT * FROM animals;

/* Modify your inserted animals so it includes the species_id value:
All other animals are Pokemon*/
UPDATE animals SET species_id = (
SELECT id FROM species WHERE name ='Pokemon') 
WHERE name NOT LIKE '%mon';
SELECT * FROM animals;