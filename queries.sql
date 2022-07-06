/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM  animals   WHERE name='Agumon' OR name='Pikachu';
SELECT * FROM animals where neutered = true;
SELECT * FROM animals WHERE name !='Gabumon';
SELECT name, escape_attempts  FROM animals WHERE weight_kg > 10.15;
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- /* update the animals table by setting the species column to unspecified, verify and roolbak .*/
BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;
SELECT * FROM animals;
/*Setting animals species wohse name ending with mon to 
  digimon and the one's without  species to pokemon  */
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS null;
COMMIT;
SELECT * FROM animals;

/* Delete all data from animals table. Rollback and verify that data persists as a result of previous commit */
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;
