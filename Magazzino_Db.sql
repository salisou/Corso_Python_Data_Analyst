-- Database Magazzino
CREATE DATABASE Magazzino_Db;
GO

use Magazzino_Db;
Go

/*=====================
		Prodotti
=======================*/
CREATE TABLE Prodotto(
	ProdottoId INT PRIMARY KEY IDENTITY(1,1),
	Nome NVARCHAR(50) NOT NULL,
	Prezzo DECIMAL(10,2) NOT NULL,
	CategoriaId INT NOT NULL,
	FornitoreId INT NULL,

	FOREIGN KEY (CategoriaId) REFERENCES Categoria(CategoriaId),
	FOREIGN KEY (FornitoreId) REFERENCES Fornitore(FornitoreId)
);
GO
/*=====================
		Categorie
=======================*/
CREATE TABLE Categoria(
	CategoriaId INT PRIMARY KEY IDENTITY(1,1),
	Nome NVARCHAR(100) NOT NULL,
	Descizione NVARCHAR(Max)
);
GO
/*=====================
		Fornitori		
=======================*/
CREATE TABLE Fornitore
(
	FornitoreId INT PRIMARY KEY IDENTITY(1,1),
	Nome NVARCHAR(150) NOT NULL,
	Indirizzo NVARCHAR(200) NULL,
	Telefono NVARCHAR(20) UNIQUE NOT NULL,
	Email NVARCHAR(50) UNIQUE NOT NULL
);
GO

/*=====================
		Clienti
=======================*/
CREATE TABLE Cliente(
	ClienteId INT PRIMARY KEY IDENTITY(1,1),
	Nome NVARCHAR(150) NOT NULL,
	Indirizzo NVARCHAR(200) NULL,
	Telefono NVARCHAR(20) UNIQUE NOT NULL,
	Email NVARCHAR(50) UNIQUE NOT NULL
);
GO

/*=====================
	Magazzino
=======================*/
CREATE TABLE Magazzino(
	MagazzinoId INT PRIMARY KEY IDENTITY(1,1),
	Nome NVARCHAR(150) NOT NULL,
	Indirizzo NVARCHAR(200) NULL,
);
GO

/*=====================
	Stock 
=======================*/
CREATE TABLE Stock(
	StockId INT NOT NULL,
	ProdottoId INT NOT NULL,
	MagazzinoId INT NOT NULL,
	Quantita INT NOT NULL DEFAULT 0,

	PRIMARY KEY (ProdottoId, MagazzinoId),

	FOREIGN KEY (ProdottoId) REFERENCES Prodotto(ProdottoId),
	FOREIGN KEY (MagazzinoId) REFERENCES Magazzino(MagazzinoId)
);
GO
/*=====================
	Movimenti di Magazzino
=======================*/
CREATE TABLE MovimentiMagazzino(
	MovimentoId INT PRIMARY KEY IDENTITY(1,1),
	ProdottoId INT NOT NULL,
	MagazzinoId INT NOT NULL,
	Quantita INT NOT NULL,
	Tipo CHAR(1) NOT NULL CHECK (Tipo in ('E','U')), -- E=Entrata, U=Uscita
	DataMovimento DATETIME NOT NULL DEFAULT GETDATE(),

	FOREIGN KEY (ProdottoId) REFERENCES Prodotto(ProdottoId),
	FOREIGN KEY (MagazzinoId) REFERENCES Magazzino(MagazzinoId)
);
GO

/*=====================
	OrdiniFornitore
=======================*/
CREATE TABLE OrdiniFornitore(
	OrdiniFornitoreId INT PRIMARY KEY IDENTITY(1,1),
	FornitoreId INT NOT NULL,
	DataOrdine DATETIME NOT NULL DEFAULT GETDATE(),

	FOREIGN KEY (FornitoreId) REFERENCES Fornitore(FornitoreId)
);
GO

/*============================
	DettagliOrdineFornitore
==============================*/
CREATE TABLE DettagliOrdineFornitore(
	DettaglioId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	OrdiniFornitoreId INT NOT NULL,
	ProdottoId INT NOT NULL,
	Quantita INT NOT NULL,
	Prezzo DECIMAL(10,2) NOT NULL 

	FOREIGN KEY (OrdiniFornitoreId) REFERENCES OrdiniFornitore(OrdiniFornitoreId),
	FOREIGN KEY (ProdottoId) REFERENCES Prodotto(ProdottoId)

);
GO
/*=====================
	OrdiniCliente
=======================*/
CREATE TABLE OrdineCliente (
    OrdineClienteId INT IDENTITY(1,1) PRIMARY KEY,
    ClienteId INT NOT NULL,
    DataOrdine DATE NOT NULL DEFAULT GETDATE(),

    FOREIGN KEY (ClienteId) REFERENCES Cliente(ClienteId)
);
GO
/*=====================
	DettagliOrdineCliente
=======================*/
CREATE TABLE DettaglioOrdineCliente (
    DettaglioId INT IDENTITY(1,1) PRIMARY KEY,
    OrdineClienteId INT NOT NULL,
    ProdottoId INT NOT NULL,
    Quantita INT NOT NULL,
    Prezzo DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (OrdineClienteId) REFERENCES OrdineCliente(OrdineClienteId),
    FOREIGN KEY (ProdottoId) REFERENCES Prodotto(ProdottoId)
);
GO