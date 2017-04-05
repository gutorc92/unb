SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


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
  PRIMARY KEY (`idCopa`),
  UNIQUE INDEX `ano_UNIQUE` (`ano` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `copas`.`Selecao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `copas`.`Selecao` (
  `idSelecao` INT NOT NULL AUTO_INCREMENT,
  `Copa_idCopa` INT NOT NULL,
  `Pais_idPais` INT NOT NULL,
  PRIMARY KEY (`idSelecao`),
  INDEX `fk_Equipe_Copa1_idx` (`Copa_idCopa` ASC),
  INDEX `fk_Equipe_Pais1_idx` (`Pais_idPais` ASC),
  CONSTRAINT `fk_Equipe_Copa1`
    FOREIGN KEY (`Copa_idCopa`)
    REFERENCES `copas`.`Copa` (`idCopa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe_Pais1`
    FOREIGN KEY (`Pais_idPais`)
    REFERENCES `copas`.`Pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


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
  `sexo` BIT NULL,
  `idade` INT NULL,
  `cidade de nascimento` VARCHAR(45) NULL,
  `pais_origem` VARCHAR(45) NULL,
  `nome_mae` VARCHAR(45) NULL,
  `nome_pai` VARCHAR(45) NULL,
  `tipo_pessoa` ENUM('Alteta','Jornalista') NULL,
  PRIMARY KEY (`idPessoa`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `copas`.`Partidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `copas`.`Partidas` (
  `Partidas` INT NOT NULL AUTO_INCREMENT,
  `Selecao_idSelecao` INT NOT NULL,
  `Selecao_idSelecao1` INT NOT NULL,
  `local` VARCHAR(45) NULL,
  `horario` TIME NULL,
  PRIMARY KEY (`Partidas`),
  INDEX `fk_Partidas_Selecao1_idx` (`Selecao_idSelecao` ASC),
  INDEX `fk_Partidas_Selecao2_idx` (`Selecao_idSelecao1` ASC),
  CONSTRAINT `fk_Partidas_Selecao1`
    FOREIGN KEY (`Selecao_idSelecao`)
    REFERENCES `copas`.`Selecao` (`idSelecao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partidas_Selecao2`
    FOREIGN KEY (`Selecao_idSelecao1`)
    REFERENCES `copas`.`Selecao` (`idSelecao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `copas`.`Ocorrencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `copas`.`Ocorrencia` (
  `idOcorrencia` INT NOT NULL AUTO_INCREMENT,
  `Partidas_Partidas` INT NOT NULL,
  `Pessoa_idPessoa` INT NOT NULL,
  `tipo_ocorrencia` ENUM('Gol', 'Cartão Vermelho', 'Cartão Amarelo') NOT NULL,
  PRIMARY KEY (`idOcorrencia`),
  INDEX `fk_Gols_Partidas1_idx` (`Partidas_Partidas` ASC),
  INDEX `fk_Gols_Pessoa1_idx` (`Pessoa_idPessoa` ASC),
  CONSTRAINT `fk_Gols_Partidas1`
    FOREIGN KEY (`Partidas_Partidas`)
    REFERENCES `copas`.`Partidas` (`Partidas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gols_Pessoa1`
    FOREIGN KEY (`Pessoa_idPessoa`)
    REFERENCES `copas`.`Pessoa` (`idPessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `copas`.`Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `copas`.`Equipe` (
  `idMembro` INT NOT NULL,
  `Selecao_idSelecao` INT NOT NULL,
  `Pessoa_idPessoa` INT NOT NULL,
  `posicao_na_equipe` ENUM('Goleiro','Atacante','Zagueiro') NULL,
  `posicao_no_time` ENUM('Jogador','Treinador') NULL,
  PRIMARY KEY (`idMembro`),
  INDEX `fk_Equipe_Selecao1_idx` (`Selecao_idSelecao` ASC),
  INDEX `fk_Equipe_Pessoa1_idx` (`Pessoa_idPessoa` ASC),
  CONSTRAINT `fk_Equipe_Selecao1`
    FOREIGN KEY (`Selecao_idSelecao`)
    REFERENCES `copas`.`Selecao` (`idSelecao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe_Pessoa1`
    FOREIGN KEY (`Pessoa_idPessoa`)
    REFERENCES `copas`.`Pessoa` (`idPessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
