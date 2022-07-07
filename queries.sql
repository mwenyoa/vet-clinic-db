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
/* Delete animals born after 2022-01-01, create savepoint update weight and commit changes*/
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT mydata;
UPDATE animals SET weight_kg = weight_kg * (-1);
ROLLBACK TO mydata;
UPDATE animals SET weight_kg = weight_kg * (-1) 
WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;
/* How many animals are there? */
SELECT COUNT(*) as total_number_of_naimals FROM animals;
/*How many animals have never tried to escape?*/
SELECT COUNT(*) as animals_without_escape_attempts FROM animals WHERE escape_attempts = 0;
/* What is the average weight of animals?*/
SELECT AVG(weight_kg) as Average_Weight_Of_Animals FROM animals;
/* Who escapes the most, neutered or not neutered animals? */
SELECT name as Animal_Escaping_The_Most,
MAX(escape_attempts) as Max_Escape_Attempts
FROM animals GROUP BY neutered,  
Animal_Escaping_The_Most ORDER BY Max_Escape_Attempts DESC LIMIT 1;
/* What is the minimum and maximum weight of each type of animal? */
SELECT  species, MAX(weight_kg) as ANIMAL_MAX_WEIGHT,
MIN(weight_kg) as ANIMAL_MIN_WEIGHT FROM animals GROUP BY species;
/* */
SELECT species, AVG(escape_attempts) as AVERAGE_ESCAPE_ATTEMPTS  FROM animals
WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;

/* Write queries (using JOIN) to answer 
the following questions*/

/* Query 1: What animals belong to Melody Pond?*/
 SELECT animals.name as Animal_Name, owners.full_name as Animal_Owner
 FROM animals INNER JOIN owners ON animals.owners_id = owners.id
 WHERE owners.full_name ='Melody Pond';

 /* Query 2: List of all animals that are pokemon (their type is Pokemon).*/
SELECT animals.name as Animal_Name, 
species.name as Animal_Species
FROM animals INNER JOIN 
species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

/* Query 3: List all owners and their animals, remember to include those that don't own any animal.*/
SELECT owners.full_name as Owner, 
animals.name as Animal_Name
FROM owners INNER JOIN 
animals ON owners.id = animals.owners_id;

/* Query 4: How many animals are there per species?*/
SELECT COUNT(animals.species_id) as Total_Animals_Per_Species, 
species.name as Species_Name
FROM animals INNER JOIN 
species ON animals.species_id = species.id 
WHERE species.name = 'Pokemon' OR 
species.name = 'Digimon'
GROUP BY species.name;

/* Query 5: List all Digimon owned by Jennifer Orwell*/
SELECT  animals.name as Animal_Name, 
owners.full_name as Owned_by, species.name as Species_Name
FROM animals INNER JOIN  species ON animals.species_id = species.id 
 INNER JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name= 'Digimon'
ORDER BY Animal_Name ASC; 

/* List all animals owned by Dean Winchester that haven't tried to escape. */
SELECT  animals.name as Animal_Name, animals.escape_attempts,
owners.full_name as Owned_By
FROM animals
INNER JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0 
ORDER BY Animal_Name ASC; 

/* Query 7: Who owns the most animals?. */
SELECT  owners.full_name as Who_Owns_most_animals, 
COUNT(animals.owners_id) as Animal_Highest_Count
FROM animals INNER JOIN owners ON animals.owners_id = owners.id
WHERE animals.owners_id = owners.id 
GROUP BY Who_Owns_most_animals
ORDER BY Animal_Highest_Count DESC LIMIT 1; 

  /*Who was the last animal seen by William Tatcher?*/
      SELECT vets.name as VET_NAME, animals.name as Animal_Last_Seen,
      visits.date_of_visit FROM vets JOIN visits ON vets.id = visits.vets_id
      JOIN animals ON animals.id = visits.animals_id
      WHERE vets.name ='William Tatcher' ORDER BY visits.date_of_visit DESC LIMIT 1;

