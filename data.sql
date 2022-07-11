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

/* Sam Smith owns Agumon. */
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name ='Sam Smith') WHERE name = 'Agumon';

/*Jennifer Orwell owns Gabumon and Pikachu. */
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name ='Jennifer Orwell') WHERE name = 'Gabumon' OR name = 'Pikachu';

/* Bob owns Devimon and Plantmon.*/
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name ='Bob') WHERE name = 'Devimon' OR name = 'Plantmon';

/* Melody Pond owns Charmander, Squirtle, and Blossom.*/
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name ='Melody Pond')
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

/* Dean Winchester owns Angemon and Boarmon. */
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name ='Dean Winchester') WHERE name = 'Angemon' OR name = 'Boarmon';
SELECT * FROM animals;

/*Project 4:  Insert the following data for vets: */
INSERT INTO vets(name, age, date_of_graduation)
VALUES('William Tatcher', 45, 'Apr-23-2000'),
('Maisy Smith', 26, 'Jan-17-2019'),
('Stephanie Mendez', 64, 'May-4-1981'),
('Jack Harkness', 38,'Jun-8-2008');

/*Project 4: Insert the following data for specialties: */
INSERT INTO specializations(species_id, vets_id)
VALUES((SELECT id FROM species WHERE name = 'Pokemon'),
(SELECT id FROM vets WHERE name = 'William Tatcher')),
((SELECT id FROM species WHERE name = 'Digimon'),
(SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
((SELECT id FROM species WHERE name = 'Digimon'),
(SELECT id FROM vets WHERE name = 'Jack Harkness'));

/*Project 4:  Insert the following data for visits: */
INSERT INTO visits(animals_id, vets_id, date_of_visit)
VALUES((SELECT id  FROM animals WHERE name ='Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'May-24-2020'),
       ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'Jul-22-2020'),
       ((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'Feb-02-2021'),
       ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Jan-05-2020'),
       ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Mar-08-2020'),
       ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'May-14-2020'),
       ((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'May-04-2021'),
       ((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'Feb-24-2021'),
       ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Dec-21-2019'),
       ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'Aug-10-2020'),
       ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Apr-07-2021'),
       ((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'Sep-29-2019'),
       ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'Oct-03-2020'),
       ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'Nov-04-2020'),
       ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Jan-24-2019'),
       ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'May-15-2019'),
       ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Feb-27-2020'),
       ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Aug-03-2020'),
       ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'May-24-2020'),
       ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'Jan-11-2021');

     -- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
      INSERT INTO visits (animals_id, vets_id, date_of_visit)
      SELECT * FROM (SELECT id FROM animals) animal_ids, 
      (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours')
      visit_timestamp;

      -- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
      insert into owners (full_name, email)
      select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';   