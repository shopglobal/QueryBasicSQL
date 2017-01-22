-- Group by exercise, (database -> RIVISTE)

-- 1) Name of "rivista" and number of subscribers for each magazine
select nomeRivista, count(*) as 'N. abbonati'
	from Rivista as R1 
		join Abbonamenti on R1.idRivista = Abbonamenti.ksRivista
	group by (nomeRivista);
    
-- 2) As number 1, exept Turin subscribers
select nomeRivista, count(*) as 'N. abbonati'
	from Rivista as R1
		join Abbonamenti on R1.idRivista = Abbonamenti.ksRivista
        join Abbonati on Abbonati.idAbbonato = Abbonamenti.ksAbbonato
        join Citta on Citta.idCitta = Abbonati.ksCitta
	where Citta.nomeCitta <> "Torino"
	group by (nomeRivista);
    
-- 3) As number 2, but with magazines that has more than 1 subscriber

SELECT nomeRivista, COUNT(*) AS 'N. abbonati'
	FROM Rivista r
		JOIN Abbonamenti ON r.idRivista = Abbonamenti.ksRivista
        JOIN Abbonati ON Abbonamenti.ksAbbonato = Abbonati.idAbbonato
        JOIN Citta ON Abbonati.ksCitta = Citta.idCitta
        WHERE Citta.nomeCitta <> "Torino"
        GROUP BY idRivista, nomeRivista
        HAVING COUNT(*) > 1;
        
-- 4) As number 3, but with ordered columns for "N. abbonati" (even result,
-- 	  order by "nome rivista" column)

SELECT nomeRivista, COUNT(*) AS 'N. abbonati'
	FROM Rivista r
		JOIN Abbonamenti ON r.idRivista = Abbonamenti.ksRivista
        JOIN Abbonati ON Abbonamenti.ksAbbonato = Abbonati.idAbbonato
        JOIN Citta ON Abbonati.ksCitta = Citta.idCitta
        WHERE Citta.nomeCitta <> "Torino"
        GROUP BY idRivista, nomeRivista
        HAVING COUNT(*) > 1
        ORDER BY COUNT(*) DESC, nomeRivista ASC;
        
-- 5) "Nome abbonato" and "N. magazines" that he's subscribed

SELECT nomeAbbonato, count(*) as `N. riviste`
	FROM Abbonati
		JOIN Abbonamenti ON
			Abbonamenti.ksAbbonato = Abbonati.idAbbonato
		GROUP BY(nomeAbbonato);

-- 6) As number 5, excluding "Panorama" magazine and with people with 4 different subscribes

SELECT nomeAbbonato, count(*) as `N. riviste`
	FROM Abbonati
		JOIN Abbonamenti ON
			Abbonamenti.ksAbbonato = Abbonati.idAbbonato
		JOIN Rivista ON
			Rivista.idRivista = Abbonamenti.ksRivista
		WHERE Rivista.nomeRivista <> 'Panorama'
        GROUP BY nomeAbbonato
        HAVING `N. riviste` = 4;
        
-- 7) For each city, every subscribers

SELECT Citta.nomeCitta, count(*) as `N. abbonati`
	FROM Citta
		JOIN Abbonati ON
			Abbonati.ksCitta= Citta.idCitta 
		GROUP BY Citta.nomeCitta;
        
-- 8) For each city, number of subscribers in "Panorama" magazine

SELECT Citta.nomeCitta, count(*) as `Abbonati a Panorama`
	FROM Citta
		JOIN Abbonati ON
			Abbonati.ksCitta = Citta.idCitta
		JOIN Abbonamenti ON
			Abbonamenti.ksAbbonato = Abbonati.idAbbonato
		JOIN Rivista ON
			Rivista.idRivista = Abbonamenti.ksRivista
		WHERE Rivista.nomeRivista = 'Panorama'
        GROUP BY (Citta.nomeCitta);

-- 9) Magazines with at least 3 subscribers

SELECT Rivista.nomeRivista, count(*) `Iscritti`
	FROM Rivista
		JOIN Abbonamenti ON
			Abbonamenti.ksRivista = Rivista.idRivista
		GROUP BY Rivista.nomeRivista
        HAVING `Iscritti` >= 3;
    
-- 10) Avarage price for each magazines selled in Milan

SELECT Citta.nomeCitta, avg(Rivista.costo) 
	FROM Citta
		JOIN Abbonati ON
			Abbonati.ksCitta = Citta.idCitta
		JOIN Abbonamenti ON
			Abbonamenti.ksAbbonato = Abbonati.idAbbonato
		JOIN Rivista ON
			Rivista.idRivista = Abbonamenti.ksRivista
		WHERE Citta.nomeCitta = 'Milano'
		GROUP BY(Citta.nomeCitta);
        
-- 11) Ranking of best seller magazines

SELECT Rivista.nomeRivista, count(*) `N. Abbonati`
	FROM Rivista
		JOIN Abbonamenti ON
			Abbonamenti.ksRivista = Rivista.idRivista
		GROUP BY Rivista.nomeRivista
        ORDER BY  `N. Abbonati` DESC;
