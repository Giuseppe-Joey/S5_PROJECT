%% Projet S5 - Asservissement d'un syst?me dynamique
% Auteurs: [insert cips]
close all
clear all
clc

%% Position ? l'?quilibre de la sph?re (pour tests statiques)
sig = 0.0;         % Pr?sence (1) ou non (0) de la sph?re
xSeq = 0.000;      % Position x de la sph?re ? l'?quilibre en metres
ySeq = 0.000;      % Position y de la sph?re ? l'?quilibre en metres

%% Point d'op?ration choisi pour la plaque
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
linearisation % call le fichier des matrices d'?tats lin?aires
%% Vecteurs de tensions simul?es
% VA = [t_des, [-1.67 -1.67 -1.67 -2  -2 -2 -1 -1 0]'];
% VB = [t_des, [-1.67 -1.67 -1.67 -2  -2 -2 -1 -1 0]'];
% VC = [t_des, [-1.67 -1.67 -1.67 -2  -2 -2 -1 -1 0]'];
% 
%% Calcul des compensateurs
%iniCTL_ver4    %Calculez vos compensateurs ici


%% Simulation
% open_system('schema_lineaire')
% set_param('schema_lineaire','AlgebraicLoopSolver','LineSearch')
% sim('schema_lineaire')
% % 
open_system('banc_essai_lineaire')
set_param('banc_essai_lineaire','AlgebraicLoopSolver','LineSearch')
sim('banc_essai_lineaire')

% affichage
% figure(1)
% plot(ans.tsim(:,1), ans.y_lineaire(:,3))
% axis([0 50 0 0.03])
%trajectoires


