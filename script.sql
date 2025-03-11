-- Création des tables principales

CREATE TABLE Diplomes (
    IdDiplome NUMBER PRIMARY KEY,
    IntituleDiplome VARCHAR2(100),
    NiveauEtudeDiplome VARCHAR2(50)
);

CREATE TABLE Fonctions (
    IdFonction NUMBER PRIMARY KEY,
    DescriptionFonction VARCHAR2(255)
);

CREATE TABLE Candidats (
    IdCandidat NUMBER PRIMARY KEY,
    NomCandidat VARCHAR2(50),
    PrenomCandidat VARCHAR2(50),
    AgeCandidat NUMBER,
    MailCandidat VARCHAR2(100),
    SituationFamilialeCandidat VARCHAR2(50),
    MobiliteCandidat VARCHAR2(50),
    TelephoneCandidat VARCHAR2(20),
    AdresseCandidat VARCHAR2(255),
    SituationProfessionnelleCandidat VARCHAR2(50)
);

CREATE TABLE Entreprises (
    IdEntreprise NUMBER PRIMARY KEY,
    NomEntreprise VARCHAR2(100),
    ActiviteEntreprise VARCHAR2(100),
    AdresseEntreprise VARCHAR2(255),
    EstCliente CHAR(1) CHECK (EstCliente IN ('Y', 'N')),
    SIRETEntreprise VARCHAR2(14),
    NumeroTelephoneEntreprise VARCHAR2(20),
    EmailEntreprise VARCHAR2(100)
);

CREATE TABLE Instituts (
    IdInstitut NUMBER PRIMARY KEY,
    SIRETInstitut VARCHAR2(14),
    NomInstitut VARCHAR2(100),
    AdresseInstitut VARCHAR2(255),
    ActiviteInstitut VARCHAR2(100)
);

CREATE TABLE Formations (
    IdFormation NUMBER PRIMARY KEY,
    IntituleFormation VARCHAR2(100),
    NiveauEtude VARCHAR2(50),
    Description VARCHAR2(255)
);

CREATE TABLE Etudiants (
    IdEtudiant NUMBER PRIMARY KEY,
    NEtudiant VARCHAR2(20),
    NomEtudiant VARCHAR2(50),
    PrenomEtudiant VARCHAR2(50),
    TelephoneEtudiant VARCHAR2(20),
    AdresseEtudiant VARCHAR2(255),
    MailEtudiant VARCHAR2(100)
);

CREATE TABLE Annonces (
    IdAnnonce NUMBER PRIMARY KEY,
    IntituleAnnonce VARCHAR2(100),
    DescriptionAnnonce VARCHAR2(255)
);

CREATE TABLE Missions (
    IdMission NUMBER PRIMARY KEY,
    Remuneration NUMBER,
    DateOuverture DATE,
    DescriptionMission VARCHAR2(255),
    EtatMission VARCHAR2(50)
);

CREATE TABLE Conventions (
    IdConvention NUMBER PRIMARY KEY,
    DateDebutConvention DATE,
    DateFinConvention DATE
);

CREATE TABLE Candidatures (
    IdCandidature NUMBER PRIMARY KEY,
    DateCandidature DATE,
    StatutCandidature VARCHAR2(50),
    CommentaireRH VARCHAR2(255)
);

CREATE TABLE Contacts (
    IdContact NUMBER PRIMARY KEY,
    IdCandidat NUMBER,
    IdMission NUMBER,
    DateContact DATE,
    FOREIGN KEY (IdCandidat) REFERENCES Candidats(IdCandidat),
    FOREIGN KEY (IdMission) REFERENCES Missions(IdMission)
);

-- Création des tables de liaison

CREATE TABLE Diplomes_Fonctions (
    IdDiplome NUMBER,
    IdFonction NUMBER,
    PRIMARY KEY (IdDiplome, IdFonction),
    FOREIGN KEY (IdDiplome) REFERENCES Diplomes(IdDiplome),
    FOREIGN KEY (IdFonction) REFERENCES Fonctions(IdFonction)
);

CREATE TABLE Candidats_Diplomes (
    IdCandidat NUMBER,
    IdDiplome NUMBER,
    PRIMARY KEY (IdCandidat, IdDiplome),
    FOREIGN KEY (IdCandidat) REFERENCES Candidats(IdCandidat),
    FOREIGN KEY (IdDiplome) REFERENCES Diplomes(IdDiplome)
);

CREATE TABLE Aptitudes_Candidats (
    IdAptitude NUMBER PRIMARY KEY,
    IdCandidat NUMBER,
    FOREIGN KEY (IdCandidat) REFERENCES Candidats(IdCandidat)
);

CREATE TABLE Candidats_Entreprises (
    IdCandidat NUMBER,
    IdEntreprise NUMBER,
    PRIMARY KEY (IdCandidat, IdEntreprise),
    FOREIGN KEY (IdCandidat) REFERENCES Candidats(IdCandidat),
    FOREIGN KEY (IdEntreprise) REFERENCES Entreprises(IdEntreprise)
);
CREATE TABLE Candidats_Contacts (
    IdCandidat NUMBER,
    IdContact NUMBER,
    PRIMARY KEY (IdCandidat, IdContact),
    FOREIGN KEY (IdCandidat) REFERENCES Candidats(IdCandidat),
    FOREIGN KEY (IdContact) REFERENCES Contacts(IdContact)
);

CREATE TABLE Conventions_Entreprises (
    IdConvention NUMBER,
    IdEntreprise NUMBER,
    PRIMARY KEY (IdConvention, IdEntreprise),
    FOREIGN KEY (IdConvention) REFERENCES Conventions(IdConvention),
    FOREIGN KEY (IdEntreprise) REFERENCES Entreprises(IdEntreprise)
);

CREATE TABLE Conventions_Missions (
    IdConvention NUMBER,
    IdMission NUMBER,
    PRIMARY KEY (IdConvention, IdMission),
    FOREIGN KEY (IdConvention) REFERENCES Conventions(IdConvention),
    FOREIGN KEY (IdMission) REFERENCES Missions(IdMission)
);

CREATE TABLE Conventions_Etudiants (
    IdConvention NUMBER,
    IdEtudiant NUMBER,
    PRIMARY KEY (IdConvention, IdEtudiant),
    FOREIGN KEY (IdConvention) REFERENCES Conventions(IdConvention),
    FOREIGN KEY (IdEtudiant) REFERENCES Etudiants(IdEtudiant)
);

CREATE TABLE Formations_Instituts (
    IdFormation NUMBER,
    IdInstitut NUMBER,
    PRIMARY KEY (IdFormation, IdInstitut),
    FOREIGN KEY (IdFormation) REFERENCES Formations(IdFormation),
    FOREIGN KEY (IdInstitut) REFERENCES Instituts(IdInstitut)
);

CREATE TABLE Etudiants_Instituts (
    IdEtudiant NUMBER,
    IdInstitut NUMBER,
    PRIMARY KEY (IdEtudiant, IdInstitut),
    FOREIGN KEY (IdEtudiant) REFERENCES Etudiants(IdEtudiant),
    FOREIGN KEY (IdInstitut) REFERENCES Instituts(IdInstitut)
);

CREATE TABLE Annonces_Missions (
    IdAnnonce NUMBER,
    IdMission NUMBER,
    PRIMARY KEY (IdAnnonce, IdMission),
    FOREIGN KEY (IdAnnonce) REFERENCES Annonces(IdAnnonce),
    FOREIGN KEY (IdMission) REFERENCES Missions(IdMission)
);

CREATE TABLE Annonces_Instituts (
    IdAnnonce NUMBER,
    IdInstitut NUMBER,
    PRIMARY KEY (IdAnnonce, IdInstitut),
    FOREIGN KEY (IdAnnonce) REFERENCES Annonces(IdAnnonce),
    FOREIGN KEY (IdInstitut) REFERENCES Instituts(IdInstitut)
);

CREATE TABLE Fonctions_Missions (
    IdFonction NUMBER,
    IdMission NUMBER,
    PRIMARY KEY (IdFonction, IdMission),
    FOREIGN KEY (IdFonction) REFERENCES Fonctions(IdFonction),
    FOREIGN KEY (IdMission) REFERENCES Missions(IdMission)
);

-- Création des relations pour les candidatures

CREATE TABLE Requiert (
    IdMission NUMBER,
    IdCandidature NUMBER,
    PRIMARY KEY (IdMission, IdCandidature),
    FOREIGN KEY (IdMission) REFERENCES Missions(IdMission),
    FOREIGN KEY (IdCandidature) REFERENCES Candidatures(IdCandidature)
);

CREATE TABLE Candidate (
    IdCandidat NUMBER,
    IdCandidature NUMBER,
    PRIMARY KEY (IdCandidat, IdCandidature),
    FOREIGN KEY (IdCandidat) REFERENCES Candidats(IdCandidat),
    FOREIGN KEY (IdCandidature) REFERENCES Candidatures(IdCandidature)
);

-- Insertion des Diplomes
INSERT INTO Diplomes (IdDiplome, IntituleDiplome, NiveauEtudeDiplome) VALUES (1, 'Baccalauréat Scientifique', 'Bac');
INSERT INTO Diplomes (IdDiplome, IntituleDiplome, NiveauEtudeDiplome) VALUES (2, 'Licence en Mathématiques', 'Bac+3');
INSERT INTO Diplomes (IdDiplome, IntituleDiplome, NiveauEtudeDiplome) VALUES (3, 'Master en Informatique', 'Bac+5');

-- Insertion des Fonctions
INSERT INTO Fonctions (IdFonction, DescriptionFonction) VALUES (1, 'Ingénieur Logiciel');
INSERT INTO Fonctions (IdFonction, DescriptionFonction) VALUES (2, 'Data Scientist');
INSERT INTO Fonctions (IdFonction, DescriptionFonction) VALUES (3, 'Chef de Projet');

-- Insertion des Candidats
INSERT INTO Candidats (IdCandidat, NomCandidat, PrenomCandidat, AgeCandidat, MailCandidat, SituationFamilialeCandidat, MobiliteCandidat, TelephoneCandidat, AdresseCandidat, SituationProfessionnelleCandidat) 
VALUES (1, 'Bernard', 'Luc', 25, 'luc.bernard@example.com', 'Célibataire', 'Mobile', '0712345678', '1 Rue de la Paix', 'En recherche');
INSERT INTO Candidats (IdCandidat, NomCandidat, PrenomCandidat, AgeCandidat, MailCandidat, SituationFamilialeCandidat, MobiliteCandidat, TelephoneCandidat, AdresseCandidat, SituationProfessionnelleCandidat) 
VALUES (2, 'Petit', 'Chloé', 30, 'chloe.petit@example.com', 'Marié(e)', 'Non mobile', '0723456789', '2 Avenue du Roi', 'Salarié');
INSERT INTO Candidats (IdCandidat, NomCandidat, PrenomCandidat, AgeCandidat, MailCandidat, SituationFamilialeCandidat, MobiliteCandidat, TelephoneCandidat, AdresseCandidat, SituationProfessionnelleCandidat) 
VALUES (3, 'Moreau', 'Lucas', 27, 'lucas.moreau@example.com', 'Célibataire', 'Mobile', '0734567890', '3 Boulevard de l''Amiral', 'Étudiant');

-- Insertion des Entreprises
INSERT INTO Entreprises (IdEntreprise, NomEntreprise, ActiviteEntreprise, AdresseEntreprise, EstCliente, SIRETEntreprise, NumeroTelephoneEntreprise, EmailEntreprise) 
VALUES (1, 'TechCorp', 'Informatique', '5 Rue de l''Innovation', 'Y', '45678901234567', '0812345678', 'contact@techcorp.com');
INSERT INTO Entreprises (IdEntreprise, NomEntreprise, ActiviteEntreprise, AdresseEntreprise, EstCliente, SIRETEntreprise, NumeroTelephoneEntreprise, EmailEntreprise) 
VALUES (2, 'MediHealth', 'Santé', '10 Avenue de la Santé', 'N', '56789012345678', '0823456789', 'info@medihealth.com');

-- Insertion des Instituts
INSERT INTO Instituts (IdInstitut, SIRETInstitut, NomInstitut, AdresseInstitut, ActiviteInstitut) 
VALUES (1, '12345678901234', 'Institut Polytechnique', '1 Rue de l''Ingénieur', 'Enseignement');
INSERT INTO Instituts (IdInstitut, SIRETInstitut, NomInstitut, AdresseInstitut, ActiviteInstitut) 
VALUES (2, '23456789012345', 'Université des Sciences', '12 Avenue de la Recherche', 'Enseignement');
INSERT INTO Instituts (IdInstitut, SIRETInstitut, NomInstitut, AdresseInstitut, ActiviteInstitut) 
VALUES (3, '34567890123456', 'Ecole Supérieure de Commerce', '34 Boulevard des Affaires', 'Commerce');

-- Insertion des Formations
INSERT INTO Formations (IdFormation, IntituleFormation, NiveauEtude, Description) 
VALUES (1, 'Licence Informatique', 'Bac+3', 'Formation en informatique générale');
INSERT INTO Formations (IdFormation, IntituleFormation, NiveauEtude, Description) 
VALUES (2, 'Master Data Science', 'Bac+5', 'Formation en science des données');
INSERT INTO Formations (IdFormation, IntituleFormation, NiveauEtude, Description) 
VALUES (3, 'Bachelor Commerce', 'Bac+3', 'Formation en commerce international');

-- Insertion des Etudiants
INSERT INTO Etudiants (IdEtudiant, NEtudiant, NomEtudiant, PrenomEtudiant, TelephoneEtudiant, AdresseEtudiant, MailEtudiant) 
VALUES (1, 'ET001', 'Dupont', 'Jean', '0612345678', '1 Rue de Paris', 'jean.dupont@example.com');
INSERT INTO Etudiants (IdEtudiant, NEtudiant, NomEtudiant, PrenomEtudiant, TelephoneEtudiant, AdresseEtudiant, MailEtudiant) 
VALUES (2, 'ET002', 'Martin', 'Marie', '0623456789', '2 Avenue des Champs', 'marie.martin@example.com');
INSERT INTO Etudiants (IdEtudiant, NEtudiant, NomEtudiant, PrenomEtudiant, TelephoneEtudiant, AdresseEtudiant, MailEtudiant) 
VALUES (3, 'ET003', 'Nguyen', 'Thierry', '0634567890', '3 Boulevard de la Liberté', 'thierry.nguyen@example.com');

-- Insertion des Annonces
INSERT INTO Annonces (IdAnnonce, IntituleAnnonce, DescriptionAnnonce) 
VALUES (1, 'Offre Développeur Junior', 'Poste de développeur pour débutants');
INSERT INTO Annonces (IdAnnonce, IntituleAnnonce, DescriptionAnnonce) 
VALUES (2, 'Offre Data Scientist', 'Poste pour expert en data science');

-- Insertion des Missions
INSERT INTO Missions (IdMission, Remuneration, DateOuverture, DescriptionMission, EtatMission) 
VALUES (1, 3000, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'Développement logiciel', 'Ouverte');
INSERT INTO Missions (IdMission, Remuneration, DateOuverture, DescriptionMission, EtatMission) 
VALUES (2, 4000, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Analyse de données', 'Ouverte');

-- Insertion des Conventions
INSERT INTO Conventions (IdConvention, DateDebutConvention, DateFinConvention) 
VALUES (1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), TO_DATE('2023-06-15', 'YYYY-MM-DD'));
INSERT INTO Conventions (IdConvention, DateDebutConvention, DateFinConvention) 
VALUES (2, TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2024-02-01', 'YYYY-MM-DD'));

-- Insertion d’une prise de contact avec un candidat
INSERT INTO Contacts (IdContact, IdCandidat, IdMission, DateContact)
VALUES (1, 1, 2, SYSDATE);

-- Insertion des Candidatures
INSERT INTO Candidatures (IdCandidature, DateCandidature, StatutCandidature, CommentaireRH) 
VALUES (1, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 'En cours', 'Bonne candidature');
INSERT INTO Candidatures (IdCandidature, DateCandidature, StatutCandidature, CommentaireRH) 
VALUES (2, TO_DATE('2024-02-16', 'YYYY-MM-DD'), 'Refusé', 'Pas assez d''expérience');

-- Insertion des relations entre les tables

-- Diplômes - Fonctions
INSERT INTO Diplomes_Fonctions (IdDiplome, IdFonction) 
VALUES (1, 1);
INSERT INTO Diplomes_Fonctions (IdDiplome, IdFonction) 
VALUES (2, 2);
INSERT INTO Diplomes_Fonctions (IdDiplome, IdFonction) 
VALUES (3, 3);

-- Candidats - Diplômes
INSERT INTO Candidats_Diplomes (IdCandidat, IdDiplome) 
VALUES (1, 1);
INSERT INTO Candidats_Diplomes (IdCandidat, IdDiplome) 
VALUES (1, 2);
INSERT INTO Candidats_Diplomes (IdCandidat, IdDiplome) 
VALUES (2, 2);
INSERT INTO Candidats_Diplomes (IdCandidat, IdDiplome) 
VALUES (3, 3);

-- Candidats - Entreprises
INSERT INTO Candidats_Entreprises (IdCandidat, IdEntreprise) 
VALUES (1, 1);
INSERT INTO Candidats_Entreprises (IdCandidat, IdEntreprise) 
VALUES (2, 2);

-- Conventions - Entreprises
INSERT INTO Conventions_Entreprises (IdConvention, IdEntreprise) 
VALUES (1, 1);
INSERT INTO Conventions_Entreprises (IdConvention, IdEntreprise) 
VALUES (2, 2);

-- Conventions - Etudiants
INSERT INTO Conventions_Etudiants (IdConvention, IdEtudiant) 
VALUES (1, 1);
INSERT INTO Conventions_Etudiants (IdConvention, IdEtudiant) 
VALUES (2, 2);

-- Annonces - Missions
INSERT INTO Annonces_Missions (IdAnnonce, IdMission) 
VALUES (1, 1);
INSERT INTO Annonces_Missions (IdAnnonce, IdMission) 
VALUES (2, 2);

-- Annonces - Instituts
INSERT INTO Annonces_Instituts (IdAnnonce, IdInstitut) 
VALUES (1, 1);
INSERT INTO Annonces_Instituts (IdAnnonce, IdInstitut) 
VALUES (2, 2);

-- Fonctions - Missions
INSERT INTO Fonctions_Missions (IdFonction, IdMission) 
VALUES (1, 1);
INSERT INTO Fonctions_Missions (IdFonction, IdMission) 
VALUES (2, 2);

--Etudiants_Instituts
INSERT INTO Etudiants_Instituts (IdEtudiant, IdInstitut)
VALUES (1, 1);

INSERT INTO Etudiants_Instituts (IdEtudiant, IdInstitut)
VALUES (2, 2);

--Formations_Instituts
INSERT INTO Formations_Instituts (IdFormation, IdInstitut)
VALUES (1, 1);

INSERT INTO Formations_Instituts (IdFormation, IdInstitut)
VALUES (2, 2);

--Requiert 
INSERT INTO Requiert (IdMission, IdCandidature) VALUES (1, 1);
--Candidate
INSERT INTO Candidate (IdCandidat, IdCandidature) VALUES (1, 1);
INSERT INTO Candidate (IdCandidat, IdCandidature) VALUES (2, 2);

CREATE OR REPLACE TRIGGER tr_retrait_candidat
AFTER UPDATE ON Candidats
FOR EACH ROW
BEGIN
    IF :NEW.SituationProfessionnelleCandidat IN ('Recruté', 'Retiré') THEN
        DELETE FROM Candidats WHERE IdCandidat = :NEW.IdCandidat;
    END IF;
END;
/

CREATE OR REPLACE FUNCTION assigner_candidats(p_id_mission IN NUMBER)
RETURN SYS_REFCURSOR
IS
    candidats_cursor SYS_REFCURSOR;
BEGIN
    OPEN candidats_cursor FOR
        SELECT c.IdCandidat, c.NomCandidat, c.PrenomCandidat
        FROM Candidats c
        JOIN Candidats_Diplomes cd ON c.IdCandidat = cd.IdCandidat
        JOIN Diplomes_Fonctions df ON cd.IdDiplome = df.IdDiplome
        JOIN Fonctions_Missions fm ON df.IdFonction = fm.IdFonction
        JOIN Missions m ON fm.IdMission = m.IdMission
        WHERE m.IdMission = p_id_mission
        AND c.SituationProfessionnelleCandidat = 'Sans emploi';
    RETURN candidats_cursor;
END;
/

CREATE OR REPLACE PROCEDURE contacter_candidat(p_id_candidat IN NUMBER, p_id_mission IN NUMBER)
IS
    v_date_contact DATE := SYSDATE;
BEGIN
    INSERT INTO Contacts (IdCandidat, IdMission, DateContact)
    VALUES (p_id_candidat, p_id_mission, v_date_contact);
END;
/

CREATE SEQUENCE seq_candidatures
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;


CREATE OR REPLACE PROCEDURE traiter_candidature_spontanee(p_IdCandidat IN NUMBER, p_IdEntreprise IN NUMBER) AS
BEGIN
    DECLARE
        v_est_cliente CHAR(1);
    BEGIN
        SELECT EstCliente INTO v_est_cliente
        FROM Entreprises
        WHERE IdEntreprise = p_IdEntreprise;
        
        IF v_est_cliente = 'Y' THEN
            INSERT INTO Candidatures (IdCandidature, DateCandidature, StatutCandidature)
            VALUES (seq_candidatures.NEXTVAL, SYSDATE, 'En cours');
            
            INSERT INTO Candidats_Entreprises (IdCandidat, IdEntreprise)
            VALUES (p_IdCandidat, p_IdEntreprise);
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'L''entreprise n''est pas cliente');
        END IF;
    END;
END traiter_candidature_spontanee;
/
CREATE OR REPLACE PROCEDURE ajouter_etudiant_candidat(p_id_etudiant IN NUMBER)
IS
BEGIN
    INSERT INTO Candidats (IdCandidat, NomCandidat, PrenomCandidat, SituationFamilialeCandidat, SituationProfessionnelleCandidat, MobiliteCandidat)
    SELECT IdEtudiant, NomEtudiant, PrenomEtudiant, '', 'Sans emploi', ''
    FROM Etudiants
    WHERE IdEtudiant = p_id_etudiant;
END;
/

CREATE OR REPLACE PROCEDURE terminer_mission(p_id_mission IN NUMBER)
IS
BEGIN
    DELETE FROM Missions WHERE IdMission = p_id_mission
    AND (EtatMission = 'Terminé' OR EtatMission = 'Annulé');
END;
/

CREATE OR REPLACE PROCEDURE mettre_a_jour_statut_candidature(p_IdCandidature IN NUMBER, p_nouveau_statut IN VARCHAR2) AS
BEGIN
    UPDATE Candidatures
    SET StatutCandidature = p_nouveau_statut
    WHERE IdCandidature = p_IdCandidature;
    
    IF p_nouveau_statut = 'Retiré' THEN
        DELETE FROM Candidats_Entreprises
        WHERE IdCandidat = (SELECT IdCandidat FROM Candidatures WHERE IdCandidature = p_IdCandidature);
    END IF;
END mettre_a_jour_statut_candidature;

/
CREATE OR REPLACE TRIGGER trg_supprimer_mission
AFTER UPDATE OF EtatMission ON Missions
FOR EACH ROW
BEGIN
    IF :NEW.EtatMission = 'Terminée' THEN
        terminer_mission(:NEW.IdMission);
    END IF;
END trg_supprimer_mission;
/
CREATE OR REPLACE PROCEDURE cloturer_convention(p_IdConvention IN NUMBER) AS
BEGIN
    UPDATE Conventions
    SET DateFinConvention = SYSDATE
    WHERE IdConvention = p_IdConvention;
    
    DELETE FROM Conventions
    WHERE IdConvention = p_IdConvention;

    COMMIT; -- Valider les modifications
END cloturer_convention;
