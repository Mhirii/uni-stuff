
create table Adherent ( -- member
		NAdher int primary key,
		NomAdher varchar(50),
		PrenomAdher varchar(50),
		SexeAdhere varchar(1),
		DateNaissenceAdher date,
		TeleAdher varchar(20)
);

create table Auteur (
		NAut int primary key,
		NomAut varchar(50),
		PrenomAut varchar(50),
		PayAut varchar(50)
);

create table Rayon (
		NRayon int primary key,
		Intitule varchar(50)
);

create table Ouvrage ( -- book
	Ref int primary key,
	NAut int,
	NRayon int,
	Titre varchar(50),
	NbrPage int,
	foreign key (NAut) references Auteur(NAut),
	foreign key (NRayon) references Rayon(NRayon)
);

create table Emprunt ( -- loan
		NAdher int,
		Ref int,
		DateEmpt date,
		primary key (NAdher, Ref),
		foreign key (NAdher) references Adherent(NAdher),
		foreign key (Ref) references Ouvrage(Ref)
);



alter table Adherent
alter column NomAdher set NOT NULL;

alter table Auteur
alter column NomAut SET NOT NULL;

alter table Rayon
alter column Intitule SET NOT NULL;

alter table Ouvrage
alter column Titre SET NOT NULL;

update Adherent
set NomAdher = UPPER(NomAdher);

update Auteur
set NomAut = UPPER(NomAut);

update Auteur
set PayAut = UPPER(PayAut);



alter table Emprunt alter column DateEmpt set default current_date;

alter table Ouvrage add constraint check_nbrpage check (NbrPage > 5);


create view Auteur_Legend as
select 
    NAut as "N Auteur",
    NomAut as "Nom Auteur",
    PrenomAut as "Prénom Auteur",
    PayAut as "Pays Auteur"
from Auteur;

-- create type Sexe as enum ('F', 'M');
ALTER TABLE Adherent
    ALTER COLUMN SexeAdhere TYPE sexe USING SexeAdhere::sexe;


alter table Emprunt add constraint fk_emprunt_nadher foreign key (NAdher) references Adherent(NAdher);
alter table Emprunt add constraint fk_emprunt_ref foreign key (Ref) references Ouvrage(Ref);

Créer les relations entre les tables en respectant l’intégrité référentielle
ALTER TABLE Adherent
    ALTER COLUMN SexeAdhere TYPE sexe USING SexeAdhere::sexe;

CREATE TABLE FavoriteAuthor (
    NAdher INT,
    NAut INT,
    PRIMARY KEY (NAdher, NAut),
    FOREIGN KEY (NAdher) REFERENCES Adherent(NAdher),
    FOREIGN KEY (NAut) REFERENCES Auteur(NAut)
);


