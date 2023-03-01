%% Projet S5 - Asservissement d'un syst�me dynamique
% Auteurs: [insert cips]
close all
clear all
clc

% Position � l'�quilibre de la sph�re (pour tests statiques)
sig = 1.0;         % Pr�sence (1) ou non (0) de la sph�re
xSeq = 0.000;      % Position x de la sph�re � l'�quilibre en metres
ySeq = 0.000;      % Position y de la sph�re � l'�quilibre en metres

% Point d'op�ration choisi pour la plaque
Axeq = 0;               %en degres
Ayeq = 0;               %en degres
Pzeq = .015;            %en metres

% Exemple de trajectoire
t_des     = [0:1:40]';
% x_des     = [t_des, [0 0 0.5 1  0 -1 0 1 0]'*0.05];
% y_des     = [t_des, [0 0 0 0 -1  0 1 0 0]'*0.05];
% z_des     = [t_des, [1 1 1 1  1  1 1 1 1]'*.015];
tfin = 50;

% Initialisation
constantes_lineaire % call le fichier des constantes

% Modele d'�tats

A = 


% Vecteurs de tensions simul�es
VA = [t_des, (linspace(0, -Vmax, length(t_des)))'];
VB = [t_des, (linspace(0, -Vmax, length(t_des)))'];
VC = [t_des, (linspace(0, -Vmax, length(t_des)))'];


% Calcul des compensateurs
%iniCTL_ver4    %Calculez vos compensateurs ici

%% Simulation
open_system('modele_lineaire')
set_param('modele_lineaire','AlgebraicLoopSolver','LineSearch')
sim('modele_lineaire')

%affichage
%trajectoires