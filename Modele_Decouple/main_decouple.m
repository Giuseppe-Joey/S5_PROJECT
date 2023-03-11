%% Projet S5 - Asservissement d'un syst�me dynamique
% Auteurs: [insert cips]
close all
clear all
clc

%% Position � l'�quilibre de la sph�re (pour tests statiques)
sig = 0.0;         % Pr�sence (1) ou non (0) de la sph�re
xSeq = 0.000;      % Position x de la sph�re � l'�quilibre en metres
ySeq = 0.000;      % Position y de la sph�re � l'�quilibre en metres

%% Point d'op�ration choisi pour la plaque
Axeq = 0;               %en degres
Ayeq = 0;               %en degres
Pzeq = .015;            %en metres

%% Exemple de trajectoire
t_des     = [0:1:8]';
x_des     = [t_des, [0 0 0.5 1  0 -1 0 1 0]'*0.0];
y_des     = [t_des, [0 0 0 0 -1  0 1 0 0]'*0.0];
z_des     = [t_des, [1 1 1 1  1  1 1 1 1]'*Pzeq];
tfin = 50;

%% Initialisation constantes
constantes % call le fichier des constantes
linearisation % call le fichier de linearisation
decouplage % call le fichier de decouplage

%% Vecteurs de tensions simul�es
% VA = [t_des, -1.66*ones(length(t_des), 1)];
% VB = [t_des, -1.66*ones(length(t_des), 1)];
% VC = [t_des, -1.66*ones(length(t_des), 1)];

%% Calcul des compensateurs
%iniCTL_ver4    %Calculez vos compensateurs ici

%% Simulation
% open_system('schema_decouple')
% set_param('modele_lineaire_dec','AlgebraicLoopSolver','LineSearch')
% sim('modele_lineaire_dec')

open_system('banc_essai_decouple')
set_param('banc_essai_decouple','AlgebraicLoopSolver','LineSearch')
sim('banc_essai_decouple')
%affichage
%trajectoires


