 SELECT * FROM Studente;
 SELECT * FROM Corso;
 SELECT * FROM Iscrizione;
 SELECT * FROM  Voto;

 -- ALMENO 3 TABELLE COME ABBIAMO FATTO PRIMA
 SELECT NomeStudente FROM Studente
 SELECT DataIscrizione FROM Iscrizione
 SELECT NomeCorso FROM Corso
 SELECT Voto FROM Voto

 /*
 
 | Tabella        | Colonne principali                                        |
 | -------------- | --------------------------------------------------------- |
 | **Studente**   | `StudenteId`, `NomeStudente`, `Cognome`, ...              |
 | **Corso**      | `CorsoId`, `NomeCorso`, `Docente`, ...                    |
 | **Iscrizione** | `IscrizioneId`, `StudenteId`, `CorsoId`, `DataIscrizione` |
 | **Voto**       | `VotoId`, `IscrizioneId`, `Voto`                          |
 */


 -- Modifica del l'indice 
 EXEC sp_rename 'Studente.Id', 'StudenteId', 'COLUMN';

/* 
    Con questa query ottieni una vista completa:
    ogni riga rappresenta uno studente, il corso frequentato,
    la data d’iscrizione e il voto ricevuto.
*/
SELECT DISTINCT
    s.NomeStudente as 'Nome dello Studente',
    c.NomeCorso as 'Nome del Corso',
    i.DataIscrizione,
    v.Voto
FROM Studente AS s
JOIN Iscrizione AS i ON s.StudenteId = i.StudenteId
JOIN Corso AS c ON i.CorsoId = c.CorsoId
JOIN Voto AS v ON i.IscrizioneId = v.IscrizioneId;



/*
    Questa query mostra:
    solo studenti iscritti ai corsi che contengono “SQL”
    con voto ≥ 28
    iscritti dal 2024 in poi
    ordinati per voto decrescente e poi per nome studente.
*/
 SELECT distinct
    s.NomeStudente,
    c.NomeCorso,
    i.DataIscrizione,
    v.Voto
FROM Studente AS s
JOIN Iscrizione AS i ON s.StudenteId = i.StudenteId
JOIN Corso AS c ON i.CorsoId = c.CorsoId
JOIN Voto AS v ON i.IscrizioneId = v.IscrizioneId
WHERE c.NomeCorso LIKE '%Sql%'
  AND v.Voto >= 28
  AND i.DataIscrizione >= '2024-01-01'
ORDER BY v.Voto DESC, s.NomeStudente ASC;

/*
| Funzione  | Descrizione        | Esempio     |
| --------- | ------------------ | ----------- |
| `COUNT()` | Conta quante righe | `COUNT(*)`  |
| `AVG()`   | Calcola la media   | `AVG(Voto)` |
| `MAX()`   | Valore massimo     | `MAX(Voto)` |
| `MIN()`   | Valore minimo      | `MIN(Voto)` |
| `SUM()`   | Somma dei valori   | `SUM(Voto)` |
*/

-- Count() Conta queste righe abbiamo COUNT(*)
select COUNT(*) as NumeroMassino from Studente

-- AVG() Calcola la media AVG(colonna)
select * from Voto
select AVG(Voto) AS 'Voto media' FROM Voto

-- Max() Valore massimo MAX(colonna)
select MAX(Voto) AS 'Voto massimo' FROM Voto

-- Min() Valore minimo MIN(colonna)
select MIN(Voto) AS 'Voto minimo' FROM Voto

-- SUM() Somma dei valori SUM(colonna)
select SUM(Voto) AS 'Somma dei Voto' FROM Voto