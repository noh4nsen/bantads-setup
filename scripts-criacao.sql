CREATE DATABASE Autenticacao;

CREATE TABLE usuario (
	id UUID primary key,
	email varchar(50) unique not null,
	senha varchar(500) not null,
	tipo_usuario varchar(15),
	saga UUID
)
--------------------------
CREATE DATABASE Gerente;

CREATE TABLE gerente (
	id UUID primary key,
	idExternoUsuario UUID not null,
	nome varchar(60) not null,
	cpf varchar(11) unique not null,
	saga UUID
)
--------------------------
CREATE DATABASE Cliente;

CREATE TABLE Endereco(
	id UUID Primary Key,
	cep varchar(8),
	logradouro varchar(100),
	numero int,
	complemento varchar(100),
	bairro varchar(60),
	cidade varchar(60),
	estado varchar(60)
) 

CREATE TABLE Analise(
	id UUID Primary Key,
	aprovado boolean,
	motivo varchar(400),
	datahora date,
	idExternoGerente UUID not null,
	saga UUID
)
CREATE TABLE Cliente (
	id UUID Primary Key,
	cpf varchar(11) unique,
	salario decimal(9,2),
	idExternoUsuario UUID not null,
	idEndereco UUID not null,
	idAnalise UUID,
	saga UUID,
	CONSTRAINT fk_endereco FOREIGN KEY(idEndereco) REFERENCES Endereco(id),
	CONSTRAINT fk_analise FOREIGN KEY(idAnalise) REFERENCES Analise(id)
)
-------------------------
CREATE DATABASE ContaCUD;

CREATE TABLE Conta(
	id UUID Primary key not null,
	numero SERIAL,
	saldo decimal(9,2),
	datacriacao date,
	limite decimal(9,2),
	idExternoCliente UUID not null,
	idExternoGerente UUID not null,
	saga UUID
)
CREATE TABLE Movimentacao (
	id UUID Primary Key,
	valor decimal(9,2),
	datahora date,
	tipomovimentacao int,
	origem UUID not null,
	destino UUID,
	saga UUID,
	CONSTRAINT fk_contaorigem FOREIGN KEY(origem) REFERENCES Conta(id),
	CONSTRAINT fk_contadestino FOREIGN KEY(destino) REFERENCES Conta(id)
)
-------------------------
CREATE DATABASE ContaR;

CREATE TABLE Conta(
	id UUID Primary key not null,
	numero SERIAL,
	saldo decimal(9,2),
	datacriacao date,
	limite decimal(9,2),
	idExternoCliente UUID not null,
	idExternoGerente UUID not null,
	saga UUID
)
CREATE TABLE Movimentacao (
	id UUID Primary Key,
	valor decimal(9,2),
	datahora date,
	tipomovimentacao int,
	origem UUID not null,
	destino UUID,
	saga UUID,
	CONSTRAINT fk_contaorigem FOREIGN KEY(origem) REFERENCES Conta(id),
	CONSTRAINT fk_contadestino FOREIGN KEY(destino) REFERENCES Conta(id)
)

CREATE TABLE gerenteconta (
	id UUID primary key,
	idExternoGerente UUID not null,
	quantidadecontas int,
	saldopositivo decimal(9,2),
	saldonegativo decimal(9,2),
	saga UUID
)
