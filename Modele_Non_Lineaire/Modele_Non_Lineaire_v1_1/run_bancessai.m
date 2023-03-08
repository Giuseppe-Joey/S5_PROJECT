%% Projet S5 - Asservissement d'un syst�me dynamique
% Auteurs: [insert cips]
close all
clear all
clc

% Position � l'�quilibre de la sph�re (pour tests statiques)
sig = 0.0;         % Pr�sence (1) ou non (0) de la sph�re
xSeq = 0.000;      % Position x de la sph�re � l'�quilibre en metres
ySeq = 0.000;      % Position y de la sph�re � l'�quilibre en metres

% Point d'op�ration choisi pour la plaque
Axeq = 0;               %en degres
Ayeq = 0;               %en degres
Pzeq = .015;            %en metres

% Exemple de trajectoire
t_des     = [0:1:8]'*5;
x_des     = [t_des, [0 0 0.5 1  0 -1 0 1 0]'*0.0];
y_des     = [t_des, [0 0 0 0 -1  0 1 0 0]'*0.0];
z_des     = [t_des, [1 1 1 1  1  1 1 1 1]'*.015];
tfin = 5;

% Initialisation
bancEssaiConstantes
%bancessai_ini  %faites tous vos calculs de modele ici

% Vecteurs de tensions simul�es
VA = [t_des, (ones(length(t_des), 1)*-2)];
VB = [t_des, (ones(length(t_des), 1)*-2)];
VC = [t_des, (ones(length(t_des), 1)*-2)];


% Calcul des compensateurs
%iniCTL_ver4    %Calculez vos compensateurs ici

%% Simulation
% open_system('modele_non_lineaire_schema')
% set_param('modele_non_lineaire_schema','AlgebraicLoopSolver','LineSearch')
% sim('modele_non_lineaire_schema')

open_system('modele_non_lineaire_banc_essai')
set_param('modele_non_lineaire_banc_essai','AlgebraicLoopSolver','LineSearch')
sim('modele_non_lineaire_banc_essai')
%affichage
%trajectoires