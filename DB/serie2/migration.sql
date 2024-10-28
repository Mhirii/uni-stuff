
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


-- b. Modifier les propriétés des champs 
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



-- Ajouter une valeur par défaut
alter table Emprunt
alter column DateEmpt set default current_date;

-- Nombre de page : doit être supérieur à 5
-- incorrecte, le message : « Veuillez saisir un nombre de page valide !» 
alter table Ouvrage add constraint check_nbrpage check (NbrPage > 5);


-- don't use triggers
-- -- pour afficher le message:
-- alter table Ouverge drop constraint if exists check_nbrpage;
-- -- trigger function
-- create or replace function check_nbrpage_function() 
-- returns trigger as $$
-- begin
--     if new.NbrPage <= 5 then
--         raise exception 'Veuillez saisir un nombre de page valide !';
--     end if;
--     return new;
-- end;
-- $$ language plpgsql;
--
-- -- trigger
-- create trigger check_nbrpage_trigger
-- before insert or update on Ouverge
-- for each row
-- execute function check_nbrpage_function();


-- Paramétrer la légende pour la table d’auteur de manière à afficher :
-- N Auteur | Nom Auteur | Prénom Auteur | Pays Auteur
create view Auteur_Legend as
select 
    NAut as "N Auteur",
    NomAut as "Nom Auteur",
    PrenomAut as "Prénom Auteur",
    PayAut as "Pays Auteur"
from Auteur;

-- e. Créer une liste de choix pour le champ sexe avec les valeurs (F/M)
create type Sexe as enum ('F', 'M');

-- f.
-- une liste de choix pour le champ « NAdher » de la table Emprunt ui affiche les numéros des 
-- adhérents de la table « Adherent ».

alter table Emprunt add constraint fk_emprunt_nadher foreign key (NAdher) references Adherent(NAdher);

-- une liste de choix pour le champ Ref de la table Emprunt ui affiche les références des ouvrages de la table ouvrage.
alter table Emprunt add constraint fk_emprunt_ref foreign key (Ref) references Ouvrage(Ref);

-- Créer les relations entre les tables en respectant l’intégrité référentielle
ALTER TABLE Adherent
    ALTER COLUMN SexeAdhere TYPE sexe USING SexeAdhere::sexe;

CREATE TABLE FavoriteAuthor (
    NAdher INT,
    NAut INT,
    PRIMARY KEY (NAdher, NAut),
    FOREIGN KEY (NAdher) REFERENCES Adherent(NAdher),
    FOREIGN KEY (NAut) REFERENCES Auteur(NAut)
);


-- Remplir les tables avec des enregistrements de votre choix
insert into Adherent values (1, 'Linus', 'Torvald', 'M', '01-01-1990', '0123456789');
insert into Adherent values (2, 'Bill', 'Gates', 'M', '01-01-1990', '0123456789');
insert into Adherent values (3, 'Elon', 'Musk', 'M', '01-01-1990', '0123456789');
insert into Adherent values (4, 'Jeff', 'Bezos', 'M', '01-01-1990', '0123456789');
insert into Adherent values (5, 'Mark', 'Zuckerberg', 'M', '01-01-1990', '0123456789');

insert into Auteur values (1, 'Linus', 'Torvald', 'USA');
insert into Author values (2, 'Bill', 'Gates', 'USA');
insert into Author values (3, 'Elon', 'Musk', 'USA');
insert into Author values (4, 'Jeff', 'Bezos', 'USA');

insert into Rayon values (1, 'Science');
insert into Rayon values (2, 'Economy');
insert into Rayon values (3, 'Technology');
insert into Rayon values (4, 'Computer Science');
insert into Rayon values (5, 'Physics');

insert into Ouvrage (Ref, NAut, NRayon, Titre, NbrPage) 
values (1, 1, 4, 'Linux Kernel', 300);

insert into Ouvrage (Ref, NAut, NRayon, Titre, NbrPage) 
values (2, 2, 2, 'How to monopolize (and fail)', 900);

insert into Ouvrage (Ref, NAut, NRayon, Titre, NbrPage) 
values (3, 3, 1, 'Mars', 500);

insert into Ouvrage (Ref, NAut, NRayon, Titre, NbrPage) 
values (4, 4, 3, 'Amazon', 700);

insert into Emprunt (NAdher, Ref, DateEmpt) values (2, 2, '01-01-2021');
