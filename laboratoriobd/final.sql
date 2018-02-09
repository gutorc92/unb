SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `copas` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
SHOW WARNINGS;
USE `copas` ;

-- -----------------------------------------------------
-- Table `copas`.`Pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `copas`.`Pais` (
  `idPais` INT NOT NULL AUTO_INCREMENT,
  `sigla` VARCHAR(3) NOT NULL,
  `nome` VARCHAR(100) NULL,
  `DDI` VARCHAR(45) NULL,
  PRIMARY KEY (`idPais`),
  UNIQUE INDEX `sigla_UNIQUE` (`sigla` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `copas`.`Copa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `copas`.`Copa` (
  `idCopa` INT NOT NULL AUTO_INCREMENT,
  `ano` YEAR NULL,
  `dt_inicio` DATE NULL,
  `dt_fim` DATE NULL,
  `abertura` VARCHAR(200) NULL,
  `encerramento` VARCHAR(200) NULL,
  `pais_sede` INT NOT NULL,
  `nome_fantasia` VARCHAR(200) NULL,
  PRIMARY KEY (`idCopa`, `pais_sede`),
  UNIQUE INDEX `ano_UNIQUE` (`ano` ASC),
  INDEX `fk_Copa_Pais1_idx` (`pais_sede` ASC),
  CONSTRAINT `fk_Copa_Pais1`
    FOREIGN KEY (`pais_sede`)
    REFERENCES `copas`.`Pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `copas`.`Selecao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `copas`.`Selecao` (
  `idSelecao` INT NOT NULL AUTO_INCREMENT,
  `participante_da_copa` INT NOT NULL,
  `pais_representado` INT NOT NULL,
  PRIMARY KEY (`idSelecao`),
  INDEX `fk_Equipe_Copa1_idx` (`participante_da_copa` ASC),
  INDEX `fk_Equipe_Pais1_idx` (`pais_representado` ASC),
  UNIQUE INDEX `participacao` USING BTREE (`participante_da_copa` ASC, `pais_representado` ASC),
  CONSTRAINT `fk_Equipe_Copa1`
    FOREIGN KEY (`participante_da_copa`)
    REFERENCES `copas`.`Copa` (`idCopa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe_Pais1`
    FOREIGN KEY (`pais_representado`)
    REFERENCES `copas`.`Pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `copas`.`Pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `copas`.`Pessoa` (
  `idPessoa` INT NOT NULL AUTO_INCREMENT,
  `cpf` VARCHAR(11) NULL,
  `nome` VARCHAR(200) NULL,
  `dt_nascimento` DATE NULL,
  `login` VARCHAR(45) NULL,
  `password` CHAR(1) NULL,
  `sexo` BIT(1) NULL,
  `idade` INT NULL,
  `cidade de nascimento` VARCHAR(45) NULL,
  `pais_origem` VARCHAR(45) NULL,
  `nome_mae` VARCHAR(45) NULL,
  `nome_pai` VARCHAR(45) NULL,
  `tipo_pessoa` ENUM('Atleta','Jornalista') NULL,
  PRIMARY KEY (`idPessoa`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `copas`.`Partidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `copas`.`Partidas` (
  `Partidas` INT NOT NULL AUTO_INCREMENT,
  `mandante` INT NOT NULL,
  `convidado` INT NOT NULL,
  `local` VARCHAR(45) NULL,
  PRIMARY KEY (`Partidas`),
  INDEX `fk_Partidas_Selecao1_idx` (`mandante` ASC),
  INDEX `fk_Partidas_Selecao2_idx` (`convidado` ASC),
  CONSTRAINT `fk_Partidas_Selecao1`
    FOREIGN KEY (`mandante`)
    REFERENCES `copas`.`Selecao` (`idSelecao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partidas_Selecao2`
    FOREIGN KEY (`convidado`)
    REFERENCES `copas`.`Selecao` (`idSelecao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `copas`.`Ocorrencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `copas`.`Ocorrencia` (
  `idOcorrencia` INT NOT NULL AUTO_INCREMENT,
  `partida` INT NOT NULL,
  `pessoa` INT NOT NULL,
  `tipo_ocorrencia` ENUM('Gol', 'Vermelho', 'Amarelo') NOT NULL,
  PRIMARY KEY (`idOcorrencia`),
  INDEX `fk_Gols_Partidas1_idx` (`partida` ASC),
  INDEX `fk_Gols_Pessoa1_idx` (`pessoa` ASC),
  CONSTRAINT `fk_Gols_Partidas1`
    FOREIGN KEY (`partida`)
    REFERENCES `copas`.`Partidas` (`Partidas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gols_Pessoa1`
    FOREIGN KEY (`pessoa`)
    REFERENCES `copas`.`Pessoa` (`idPessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `copas`.`Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `copas`.`Equipe` (
  `idMembro` INT NOT NULL AUTO_INCREMENT,
  `selecao` INT NOT NULL,
  `pessoa` INT NOT NULL,
  `posicao_na_equipe` ENUM('Goleiro','Atacante','Zagueiro') NULL,
  `posicao_no_time` ENUM('Jogador','Treinador') NULL,
  PRIMARY KEY (`idMembro`),
  INDEX `fk_Equipe_Selecao1_idx` (`selecao` ASC),
  INDEX `fk_Equipe_Pessoa1_idx` (`pessoa` ASC),
  CONSTRAINT `fk_Equipe_Selecao1`
    FOREIGN KEY (`selecao`)
    REFERENCES `copas`.`Selecao` (`idSelecao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe_Pessoa1`
    FOREIGN KEY (`pessoa`)
    REFERENCES `copas`.`Pessoa` (`idPessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
USE `copas` ;

-- -----------------------------------------------------
-- Placeholder table for view `copas`.`copa_pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `copas`.`copa_pais` (`nome` INT, `idPais` INT, `idSelecao` INT, `idCopa` INT, `nome_fantasia` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `copas`.`equipe_selecao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `copas`.`equipe_selecao` (`'Selecao'` INT, `'Jogador'` INT, `'Posicao'` INT, `idPais` INT, `idPessoa` INT, `idMembro` INT, `idSelecao` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `copas`.`jogos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `copas`.`jogos` (`'Mandante'` INT, `'Convidado'` INT, `'Local'` INT, `'idPaisMandante'` INT, `'idPaisConvidado'` INT, `'idSelecaoMandante'` INT, `'idSelecaoConvidado'` INT, `Partidas` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `copas`.`placar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `copas`.`placar` (`Selecao` INT, `partida` INT, `'Gols'` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `copas`.`copa_pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `copas`.`copa_pais`;
SHOW WARNINGS;
USE `copas`;
create  OR REPLACE view copa_pais as 
	select 
		p.nome,
		p.idPais,
		s.idSelecao,
		c.idCopa,
		c.nome_fantasia
	from 
		Selecao s 
	inner join 
		Pais p 
	on s.pais_representado = p.idPais
	inner join
		Copa c 
	on s.participante_da_copa = c.idCopa;

SHOW WARNINGS;

-- -----------------------------------------------------
-- View `copas`.`equipe_selecao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `copas`.`equipe_selecao`;
SHOW WARNINGS;
USE `copas`;
CREATE  OR REPLACE VIEW `equipe_selecao` AS
	select 
		   p.nome              as 'Selecao', 
		   pe.nome             as 'Jogador',
           e.posicao_na_equipe as 'Posicao', 
		   p.idPais,
		   pe.idPessoa,	
		   e.idMembro,
		   s.idSelecao
	from 
		Equipe e 
		inner join Pessoa pe 
			on e.pessoa = pe.idPessoa 
		inner join Selecao s 
			on  e.selecao = s.idSelecao 
		inner join Pais p 
			on s.pais_representado = p.idPais;

SHOW WARNINGS;

-- -----------------------------------------------------
-- View `copas`.`jogos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `copas`.`jogos`;
SHOW WARNINGS;
USE `copas`;
CREATE  OR REPLACE VIEW `jogos` AS
	select 
		cp.nome as 'Mandante', 
		c.nome as 'Convidado', 
		p.local as 'Local', 
		cp.idPais as 'idPaisMandante', 
		c.idPais as 'idPaisConvidado', 
		cp.idSelecao as 'idSelecaoMandante', 
		c.idSelecao as 'idSelecaoConvidado',
		p.Partidas 
	from 
		Partidas p 
	join 
		copa_pais c 
	on 
		p.convidado = c.idSelecao 
	join 
		copa_pais cp 
	on p.mandante = cp.idSelecao;

SHOW WARNINGS;

-- -----------------------------------------------------
-- View `copas`.`placar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `copas`.`placar`;
SHOW WARNINGS;
USE `copas`;
CREATE  OR REPLACE VIEW `placar` AS
select 
	es.Selecao, 
	o.partida, 
	count(tipo_ocorrencia) as 'Gols' 
from 
	Ocorrencia o 
inner join 
	jogos j 
on 
	o.partida = j.partidas 
inner join 
	equipe_selecao es 
on 
	o.pessoa = es.idPessoa 
where 
	tipo_ocorrencia = 'Gol' 
group by 
	es.Selecao, o.partida
;
SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `copas`.`Pais`
-- -----------------------------------------------------
START TRANSACTION;
USE `copas`;
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (1, 'AFG', 'Afeganistão', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (2, 'AFS', 'África do Sul', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (3, 'AHL', 'Antilhas Holandesas', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (4, 'ALB', 'Albânia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (5, 'ANB', 'Antigua', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (6, 'AND', 'Andorra', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (7, 'ANG', 'Angola', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (8, 'ARA', 'Arábia Saudita', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (9, 'ARG', 'Argentina', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (10, 'ARL', 'Argélia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (11, 'ARM', 'Armênia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (12, 'ASM', 'Samoa Americana', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (13, 'ATC', 'Antartida', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (14, 'AUS', 'Austrália', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (15, 'AUT', 'Austria', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (16, 'AZE', 'Azerbaijão', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (17, 'BAR', 'Barein', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (18, 'BEA', 'Belarus', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (19, 'BEL', 'Bélgica', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (20, 'BEN', 'Benin', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (21, 'BER', 'Bermudas', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (22, 'BGD', 'Bangladesh', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (23, 'BHS', 'Bahamas', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (24, 'BIR', 'Birmânia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (25, 'BKF', 'Burkina Fasso', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (26, 'BLZ', 'Belize', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (27, 'BOL', 'Bolívia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (28, 'BOS', 'Bósnia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (29, 'BOT', 'Botsuana', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (30, 'BRA', 'Brasil', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (31, 'BRB', 'Barbados', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (32, 'BRN', 'Brunei', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (33, 'BUL', 'Bulgária', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (34, 'BUR', 'Burundi', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (35, 'BUT', 'Butão', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (36, 'CAM', 'Camarões', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (37, 'CAN', 'Canadá', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (38, 'CAT', 'Catar', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (39, 'CAZ', 'Cazaquistão', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (40, 'CBJ', 'Camboja', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (41, 'CBV', 'Cabo Verde', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (42, 'CCK', 'Ilhas Cocos', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (43, 'CHA', 'Chade', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (44, 'CHL', 'Chile', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (45, 'CHN', 'China', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (46, 'CHP', 'Chipre', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (47, 'CIN', 'Cingapura', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (48, 'CMF', 'Costa do Marfim', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (49, 'COK', 'Ilhas Cook', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (50, 'COL', 'Colômbia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (51, 'COM', 'Comores', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (52, 'CON', 'Congo', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (53, 'CRC', 'Costa Rica', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (54, 'CRN', 'Coréia do Norte', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (55, 'CRO', 'Croácia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (56, 'CRS', 'Coréia do Sul', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (57, 'CUB', 'Cuba', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (58, 'CXR', 'Christmas Island', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (59, 'CYM', 'Ilhas Cayman', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (60, 'DIN', 'Dinamarca', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (61, 'DJI', 'Djibuti', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (62, 'DOM', 'República Dominicana', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (63, 'DON', 'Dominica', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (64, 'EAU', 'Emirados Árabes', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (65, 'EGI', 'Egito', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (66, 'ELS', 'El Salvador', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (67, 'EQU', 'Equador', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (68, 'ERT', 'Eritréa', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (69, 'ESC', 'Escócia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (70, 'ESH', 'Western Sahara', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (71, 'ESP', 'Espanha', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (72, 'EST', 'Estônia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (73, 'ETP', 'Etiópia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (74, 'EUA', 'Estados Unidos', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (75, 'FIL', 'Filipinas', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (76, 'FIN', 'Finlândia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (77, 'FJI', 'Fiji', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (78, 'FLK', 'Ilhas Falkland', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (79, 'FOR', 'Formosa', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (80, 'FRA', 'França', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (81, 'FSM', 'Micronésia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (82, 'GAB', 'Gabão', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (83, 'GAL', 'Gales', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (84, 'GAM', 'Gâmbia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (85, 'GAN', 'Gana', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (86, 'GBR', 'Grã-Bretanha', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (87, 'GDL', 'Guadalupe', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (88, 'GEO', 'Geórgia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (89, 'GFR', 'Guiana Francesa', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (90, 'GIB', 'Gibraltar', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (91, 'GNB', 'Guiné Bissau', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (92, 'GNE', 'Guiné', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (93, 'GNQ', 'Guiné Equatorial', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (94, 'GRD', 'Granada', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (95, 'GRE', 'Grécia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (96, 'GRL', 'Groênlandia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (97, 'GUA', 'Guatemala', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (98, 'GUI', 'Guiana', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (99, 'GUM', 'Guam', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (100, 'HKG', 'Hong Kong', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (101, 'HOL', 'Holanda', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (102, 'HON', 'Honduras', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (103, 'HTI', 'Haiti', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (104, 'HUN', 'Hungria', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (105, 'IDN', 'Indonésia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (106, 'IEM', 'Iêmem', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (107, 'IFA', 'Ilhas Faroe', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (108, 'IMH', 'Ilhas Marshall', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (109, 'IMS', 'Iêmen do Sul', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (110, 'IND', 'Índia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (111, 'ING', 'Inglaterra', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (112, 'IOT', 'Britsh Indian Ocean', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (113, 'IRA', 'Irã', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (114, 'IRL', 'Irlanda', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (115, 'IRN', 'Irlanda do Norte', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (116, 'IRQ', 'Iraque', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (117, 'ISL', 'Islândia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (118, 'ISR', 'Israel', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (119, 'ITA', 'Itália', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (120, 'IUG', 'Iugoslávia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (121, 'IVA', 'Ilhas Vírgens EUA', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (122, 'JAM', 'Jamaica', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (123, 'JAP', 'Japão', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (124, 'JOR', 'Jordânia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (125, 'KIR', 'Kiribati', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (126, 'KNA', 'São Cristóvão Nevis', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (127, 'KWT', 'Kuweit', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (128, 'LAO', 'Laos', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (129, 'LBN', 'Líbano', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (130, 'LBR', 'Libéria', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (131, 'LCA', 'Santa Lúcia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (132, 'LES', 'Lesoto', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (133, 'LET', 'Letônia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (134, 'LIB', 'Líbia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (135, 'LIE', 'Liechtenstein', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (136, 'LIT', 'Lituânia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (137, 'LUX', 'Luxemburgo', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (138, 'MAC', 'Macau', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (139, 'MAD', 'Madagascar', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (140, 'MAL', 'Malásia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (141, 'MAR', 'Marrocos', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (142, 'MAU', 'Maurício', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (143, 'MBQ', 'Moçambique', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (144, 'MCD', 'Macedônia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (145, 'MDV', 'Maldivas', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (146, 'MEX', 'México', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (147, 'MGL', 'Mongólia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (148, 'MID', 'Ilhas Midway', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (149, 'MLI', 'Mali', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (150, 'MLT', 'Malta', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (151, 'MLV', 'Malavi', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (152, 'MMR', 'Mianmar', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (153, 'MOL', 'Moldova', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (154, 'MON', 'Mônaco', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (155, 'MRT', 'Martinica', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (156, 'MSR', 'Montserrat', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (157, 'MTN', 'Mauritânia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (158, 'NAM', 'Namíbia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (159, 'NCL', 'Nova Caledônia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (160, 'NFK', 'Ilhas Norfolk', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (161, 'NGA', 'Nigéria', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (162, 'NIC', 'Nicarágua', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (163, 'NIG', 'Niger', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (164, 'NIU', 'Niue', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (165, 'NOR', 'Noruega', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (166, 'NPL', 'Nepal', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (167, 'NRU', 'Nauru', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (168, 'NZL', 'Nova Zelândia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (169, 'OMA', 'Oma', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (170, 'PAN', 'Panamá', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (171, 'PAQ', 'Paquistão', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (172, 'PCI', 'Pacific Islands', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (173, 'PCN', 'Pitcairn', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (174, 'PER', 'Peru', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (175, 'PLF', 'Polinésia Francesa', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (176, 'PLU', 'Palau', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (177, 'PNG', 'Papua Nova Guiné', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (178, 'POL', 'Polônia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (179, 'POR', 'Portugal', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (180, 'PRG', 'Paraguai', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (181, 'PTR', 'Porto Rico', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (182, 'QUE', 'Quênia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (183, 'QUI', 'Quirgistão', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (184, 'RCA', 'Rep.Centro-Africana', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (185, 'REU', 'Reunião', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (186, 'RFA', 'Alemanha', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (187, 'ROM', 'Romênia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (188, 'RSS', 'Rússia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (189, 'RUA', 'Ruanda', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (190, 'SAM', 'Samoa Ocidental', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (191, 'SEN', 'Senegal', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (192, 'SHN', 'Ilhas Santa Helena', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (193, 'SIR', 'Síria', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (194, 'SLB', 'Ilhas Salamão', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (195, 'SMR', 'San Marino', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (196, 'SOM', 'Somália', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (197, 'SPM', 'São Pedro Miquelon', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (198, 'SRI', 'Sri Lanka', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (199, 'SRL', 'Serra Leoa', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (200, 'STP', 'São Tomé e Príncipe', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (201, 'SUA', 'Suazilândia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (202, 'SUD', 'Sudão', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (203, 'SUE', 'Suécia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (204, 'SUI', 'Suiça', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (205, 'SUR', 'Suriname', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (206, 'SVK', 'Eslováquia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (207, 'SVN', 'Eslovênia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (208, 'SYC', 'Seychelles', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (209, 'TAD', 'Tadjaquistão', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (210, 'TAI', 'Tailândia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (211, 'TAN', 'Tanzânia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (212, 'TCA', 'Ilhas Turcas Caicos', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (213, 'TCH', 'República Tcheca', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (214, 'TGO', 'Togo', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (215, 'TKL', 'Tokelau', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (216, 'TMP', 'Timor', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (217, 'TON', 'Tonga', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (218, 'TRT', 'Trinidad e Tobago', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (219, 'TUC', 'Turcomenistão', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (220, 'TUN', 'Tunísia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (221, 'TUR', 'Turquia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (222, 'TUV', 'Tuvalu', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (223, 'UCR', 'Ucrânia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (224, 'UGA', 'Uganda', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (225, 'URS', 'União Soviética', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (226, 'URU', 'Uruguai', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (227, 'UZB', 'Uzbekistan', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (228, 'VAT', 'Vaticano', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (229, 'VCT', 'São Vicente Granadi', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (230, 'VEN', 'Venezuela', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (231, 'VGB', 'Ilhas Vírgens GBR', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (232, 'VTN', 'Vietnã', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (233, 'VUT', 'Vanuatu', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (234, 'WAK', 'Ilhas Wake', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (235, 'WLF', 'Ilhas Wallis Futuna', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (236, 'ZAN', 'Zâmbia', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (237, 'ZAR', 'Zaire', '');
INSERT INTO `copas`.`Pais` (`idPais`, `sigla`, `nome`, `DDI`) VALUES (238, 'ZIN', 'Zimbabue', '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `copas`.`Copa`
-- -----------------------------------------------------
START TRANSACTION;
USE `copas`;
INSERT INTO `copas`.`Copa` (`idCopa`, `ano`, `dt_inicio`, `dt_fim`, `abertura`, `encerramento`, `pais_sede`, `nome_fantasia`) VALUES (1, 2014, '2014-06-01', '2014-07-01', 'Brasília', 'Rio de Janeiro', 30, 'Copa do Brasil');
INSERT INTO `copas`.`Copa` (`idCopa`, `ano`, `dt_inicio`, `dt_fim`, `abertura`, `encerramento`, `pais_sede`, `nome_fantasia`) VALUES (2, 2010, '2010-06-01', '2014-07-01', 'Jonesburgo', 'Jonesburgo', 2, 'Copa da Africa');

COMMIT;


-- -----------------------------------------------------
-- Data for table `copas`.`Selecao`
-- -----------------------------------------------------
START TRANSACTION;
USE `copas`;
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (1, 1, 9);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (2, 1, 50);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (3, 1, 44);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (4, 1, 67);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (5, 1, 226);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (6, 1, 19);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (7, 1, 119);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (8, 1, 186);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (9, 1, 101);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (10, 1, 204);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (11, 1, 188);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (12, 1, 30);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (13, 1, 71);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (14, 1, 74);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (15, 1, 111);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (16, 1, 179);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (17, 1, 53);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (18, 1, 102);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (19, 1, 146);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (20, 1, 55);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (21, 1, 95);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (22, 1, 28);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (23, 1, 123);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (24, 1, 113);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (25, 1, 56);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (26, 1, 14);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (27, 1, 48);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (28, 1, 161);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (29, 1, 36);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (30, 1, 85);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (31, 1, 10);
INSERT INTO `copas`.`Selecao` (`idSelecao`, `participante_da_copa`, `pais_representado`) VALUES (32, 1, 80);

COMMIT;


-- -----------------------------------------------------
-- Data for table `copas`.`Pessoa`
-- -----------------------------------------------------
START TRANSACTION;
USE `copas`;
INSERT INTO `copas`.`Pessoa` (`idPessoa`, `cpf`, `nome`, `dt_nascimento`, `login`, `password`, `sexo`, `idade`, `cidade de nascimento`, `pais_origem`, `nome_mae`, `nome_pai`, `tipo_pessoa`) VALUES (1, '1', 'Thiago Silva', '1971-05-01', '', '', 1, 23, 'Sem cidade', 'Brasil', '', 'NULL', 'Atleta');
INSERT INTO `copas`.`Pessoa` (`idPessoa`, `cpf`, `nome`, `dt_nascimento`, `login`, `password`, `sexo`, `idade`, `cidade de nascimento`, `pais_origem`, `nome_mae`, `nome_pai`, `tipo_pessoa`) VALUES (2, '2', 'David Luiz', '1971-05-01', '', '', 1, 23, 'Sem cidade', 'Brasil', '', 'NULL', 'Atleta');
INSERT INTO `copas`.`Pessoa` (`idPessoa`, `cpf`, `nome`, `dt_nascimento`, `login`, `password`, `sexo`, `idade`, `cidade de nascimento`, `pais_origem`, `nome_mae`, `nome_pai`, `tipo_pessoa`) VALUES (3, '3', 'Daniel Alves', '1971-05-01', '', '', 1, 23, 'Sem cidade', 'Brasil', '', 'NULL', 'Atleta');
INSERT INTO `copas`.`Pessoa` (`idPessoa`, `cpf`, `nome`, `dt_nascimento`, `login`, `password`, `sexo`, `idade`, `cidade de nascimento`, `pais_origem`, `nome_mae`, `nome_pai`, `tipo_pessoa`) VALUES (4, '4', 'Julio César', '1971-05-01', '', '', 1, 23, 'Sem cidade', 'Brasil', '', 'NULL', 'Atleta');
INSERT INTO `copas`.`Pessoa` (`idPessoa`, `cpf`, `nome`, `dt_nascimento`, `login`, `password`, `sexo`, `idade`, `cidade de nascimento`, `pais_origem`, `nome_mae`, `nome_pai`, `tipo_pessoa`) VALUES (5, '5', 'Marcelo', '1971-05-01', '', '', 1, 23, 'Sem cidade', 'Brasil', '', 'NULL', 'Atleta');
INSERT INTO `copas`.`Pessoa` (`idPessoa`, `cpf`, `nome`, `dt_nascimento`, `login`, `password`, `sexo`, `idade`, `cidade de nascimento`, `pais_origem`, `nome_mae`, `nome_pai`, `tipo_pessoa`) VALUES (6, '6', 'Luiz Gustavo', '1971-05-01', '', '', 1, 23, 'Sem cidade', 'Brasil', '', 'NULL', 'Atleta');
INSERT INTO `copas`.`Pessoa` (`idPessoa`, `cpf`, `nome`, `dt_nascimento`, `login`, `password`, `sexo`, `idade`, `cidade de nascimento`, `pais_origem`, `nome_mae`, `nome_pai`, `tipo_pessoa`) VALUES (7, '7', 'Paulinho', '1971-05-01', '', '', 1, 23, 'Sem cidade', 'Brasil', '', 'NULL', 'Atleta');
INSERT INTO `copas`.`Pessoa` (`idPessoa`, `cpf`, `nome`, `dt_nascimento`, `login`, `password`, `sexo`, `idade`, `cidade de nascimento`, `pais_origem`, `nome_mae`, `nome_pai`, `tipo_pessoa`) VALUES (8, '8', 'Oscar', '1971-05-01', '', '', 1, 23, 'Sem cidade', 'Brasil', '', 'NULL', 'Atleta');
INSERT INTO `copas`.`Pessoa` (`idPessoa`, `cpf`, `nome`, `dt_nascimento`, `login`, `password`, `sexo`, `idade`, `cidade de nascimento`, `pais_origem`, `nome_mae`, `nome_pai`, `tipo_pessoa`) VALUES (9, '9', 'Hulk', '1971-05-01', '', '', 1, 23, 'Sem cidade', 'Brasil', '', 'NULL', 'Atleta');
INSERT INTO `copas`.`Pessoa` (`idPessoa`, `cpf`, `nome`, `dt_nascimento`, `login`, `password`, `sexo`, `idade`, `cidade de nascimento`, `pais_origem`, `nome_mae`, `nome_pai`, `tipo_pessoa`) VALUES (10, '10', 'Neymar', '1971-05-01', '', '', 1, 23, 'Sem cidade', 'Brasil', '', 'NULL', 'Atleta');
INSERT INTO `copas`.`Pessoa` (`idPessoa`, `cpf`, `nome`, `dt_nascimento`, `login`, `password`, `sexo`, `idade`, `cidade de nascimento`, `pais_origem`, `nome_mae`, `nome_pai`, `tipo_pessoa`) VALUES (11, '11', 'Fred', '1971-05-01', '', '', 1, 23, 'Sem cidade', 'Brasil', '', 'NULL', 'Atleta');
INSERT INTO `copas`.`Pessoa` (`idPessoa`, `cpf`, `nome`, `dt_nascimento`, `login`, `password`, `sexo`, `idade`, `cidade de nascimento`, `pais_origem`, `nome_mae`, `nome_pai`, `tipo_pessoa`) VALUES (12, '12', 'Thomas Muller', '1971-05-01', '', '', 1, 23, 'Sem cidade', 'Alemanha', '', 'NULL', 'Atleta');
INSERT INTO `copas`.`Pessoa` (`idPessoa`, `cpf`, `nome`, `dt_nascimento`, `login`, `password`, `sexo`, `idade`, `cidade de nascimento`, `pais_origem`, `nome_mae`, `nome_pai`, `tipo_pessoa`) VALUES (13, '13', 'Toni Kroos', '1971-05-01', '', '', 1, 23, 'Sem cidade', 'Alemanha', '', 'NULL', 'Atleta');
INSERT INTO `copas`.`Pessoa` (`idPessoa`, `cpf`, `nome`, `dt_nascimento`, `login`, `password`, `sexo`, `idade`, `cidade de nascimento`, `pais_origem`, `nome_mae`, `nome_pai`, `tipo_pessoa`) VALUES (14, '14', 'Andre Schurrle', '1971-05-01', '', '', 1, 23, 'Sem cidade', 'Alemanha', '', 'NULL', 'Atleta');
INSERT INTO `copas`.`Pessoa` (`idPessoa`, `cpf`, `nome`, `dt_nascimento`, `login`, `password`, `sexo`, `idade`, `cidade de nascimento`, `pais_origem`, `nome_mae`, `nome_pai`, `tipo_pessoa`) VALUES (15, '15', 'Matip', '1971-05-01', '', '', 1, 23, 'Sem cidade', 'Camaroes', '', 'NULL', 'Atleta');

COMMIT;


-- -----------------------------------------------------
-- Data for table `copas`.`Partidas`
-- -----------------------------------------------------
START TRANSACTION;
USE `copas`;
INSERT INTO `copas`.`Partidas` (`Partidas`, `mandante`, `convidado`, `local`) VALUES (1, 12, 8, '\'Belo Horizone\'');
INSERT INTO `copas`.`Partidas` (`Partidas`, `mandante`, `convidado`, `local`) VALUES (2, 12, 29, '\'Brasília\'');
INSERT INTO `copas`.`Partidas` (`Partidas`, `mandante`, `convidado`, `local`) VALUES (3, 12, 20, '\'Belo Horizone\'');
INSERT INTO `copas`.`Partidas` (`Partidas`, `mandante`, `convidado`, `local`) VALUES (4, 12, 19, '\'Belo Horizone\'');
INSERT INTO `copas`.`Partidas` (`Partidas`, `mandante`, `convidado`, `local`) VALUES (5, 20, 19, '\'Belo Horizone\'');
INSERT INTO `copas`.`Partidas` (`Partidas`, `mandante`, `convidado`, `local`) VALUES (6, 20, 29, '\'Manaus\'');

COMMIT;


-- -----------------------------------------------------
-- Data for table `copas`.`Ocorrencia`
-- -----------------------------------------------------
START TRANSACTION;
USE `copas`;
INSERT INTO `copas`.`Ocorrencia` (`idOcorrencia`, `partida`, `pessoa`, `tipo_ocorrencia`) VALUES (1, 1, 8, 'Gol');
INSERT INTO `copas`.`Ocorrencia` (`idOcorrencia`, `partida`, `pessoa`, `tipo_ocorrencia`) VALUES (2, 1, 12, 'Gol');
INSERT INTO `copas`.`Ocorrencia` (`idOcorrencia`, `partida`, `pessoa`, `tipo_ocorrencia`) VALUES (3, 1, 13, 'Gol');
INSERT INTO `copas`.`Ocorrencia` (`idOcorrencia`, `partida`, `pessoa`, `tipo_ocorrencia`) VALUES (4, 1, 13, 'Gol');
INSERT INTO `copas`.`Ocorrencia` (`idOcorrencia`, `partida`, `pessoa`, `tipo_ocorrencia`) VALUES (5, 1, 14, 'Gol');
INSERT INTO `copas`.`Ocorrencia` (`idOcorrencia`, `partida`, `pessoa`, `tipo_ocorrencia`) VALUES (6, 1, 14, 'Gol');
INSERT INTO `copas`.`Ocorrencia` (`idOcorrencia`, `partida`, `pessoa`, `tipo_ocorrencia`) VALUES (7, 1, 14, 'Gol');
INSERT INTO `copas`.`Ocorrencia` (`idOcorrencia`, `partida`, `pessoa`, `tipo_ocorrencia`) VALUES (8, 2, 11, 'Gol');
INSERT INTO `copas`.`Ocorrencia` (`idOcorrencia`, `partida`, `pessoa`, `tipo_ocorrencia`) VALUES (9, 2, 10, 'Gol');
INSERT INTO `copas`.`Ocorrencia` (`idOcorrencia`, `partida`, `pessoa`, `tipo_ocorrencia`) VALUES (10, 2, 10, 'Gol');
INSERT INTO `copas`.`Ocorrencia` (`idOcorrencia`, `partida`, `pessoa`, `tipo_ocorrencia`) VALUES (11, 2, 7, 'Gol');
INSERT INTO `copas`.`Ocorrencia` (`idOcorrencia`, `partida`, `pessoa`, `tipo_ocorrencia`) VALUES (12, 2, 15, 'Gol');
INSERT INTO `copas`.`Ocorrencia` (`idOcorrencia`, `partida`, `pessoa`, `tipo_ocorrencia`) VALUES (13, 1, 14, 'Amarelo');

COMMIT;


-- -----------------------------------------------------
-- Data for table `copas`.`Equipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `copas`;
INSERT INTO `copas`.`Equipe` (`idMembro`, `selecao`, `pessoa`, `posicao_na_equipe`, `posicao_no_time`) VALUES (1, 12, 1, 'Atacante', 'Jogador');
INSERT INTO `copas`.`Equipe` (`idMembro`, `selecao`, `pessoa`, `posicao_na_equipe`, `posicao_no_time`) VALUES (2, 8, 14, 'Atacante', 'Jogador');
INSERT INTO `copas`.`Equipe` (`idMembro`, `selecao`, `pessoa`, `posicao_na_equipe`, `posicao_no_time`) VALUES (3, 8, 13, 'Atacante', 'Jogador');
INSERT INTO `copas`.`Equipe` (`idMembro`, `selecao`, `pessoa`, `posicao_na_equipe`, `posicao_no_time`) VALUES (4, 8, 12, 'Atacante', 'Jogador');
INSERT INTO `copas`.`Equipe` (`idMembro`, `selecao`, `pessoa`, `posicao_na_equipe`, `posicao_no_time`) VALUES (5, 12, 11, 'Atacante', 'Jogador');
INSERT INTO `copas`.`Equipe` (`idMembro`, `selecao`, `pessoa`, `posicao_na_equipe`, `posicao_no_time`) VALUES (6, 12, 8, 'Atacante', 'Jogador');
INSERT INTO `copas`.`Equipe` (`idMembro`, `selecao`, `pessoa`, `posicao_na_equipe`, `posicao_no_time`) VALUES (7, 29, 15, 'Atacante', 'Jogador');

COMMIT;

