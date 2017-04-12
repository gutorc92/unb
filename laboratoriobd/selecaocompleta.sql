CREATE VIEW `selecao completa` AS 
	select 
		s.idSelecao,
		s.Copa_idCopa,
		p.sigla,
		p.nome,
		p.DDI
	from 
		selecao s inner join pais p 
		on s.Pais_idPais = p.idPais
		
