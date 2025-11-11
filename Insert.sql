--SELECT
-- NomeStudente as 'Nome dello studente',
-- CognomeStudente as Cognome,
-- DataNascita as 'Data di Nascita',
-- Email as 'Inderizzo email dello studente'
--FROM 
--Studente
--Alter Table studente alter column Email varchar(50)

INSERT INTO Studente (NomeStudente, CognomeStudente, Email) 
		       VALUES ('Marco', 'Cogoni', 'm.cogoni@gamil.com'),
					  ('Di Donni', 'Marco', 'm.didonni@gamil.com'),
                      ('Sara', 'Rocco', 'roccco.s@gamil.com'),
                      ('Ilaria', 'Colombraro', 'c.ilaria@gamil.com');

select All from Studente;
select *  From Studente;
select nomeStudente from Studente;
