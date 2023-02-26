close all
clear all
clc

%% Position à l'équilibre de la sphère (pour tests statiques)
sig = 1.0;         % Présence (1) ou non (0) de la sphère
xSeq = 0.000;      % Position x de la sphère à l'équilibre en metres
ySeq = 0.000;      % Position y de la sphère à l'équilibre en metres

%% Point d'opération choisi pour la plaque
Axeq = 0;               %en degres
Ayeq = 0;               %en degres
Pzeq = .015;            %en metres

%% Exemple de trajectoire
t_des     = [0:1:40]';
% x_des     = [t_des, [0 0 0.5 1  0 -1 0 1 0]'*0.05];
% y_des     = [t_des, [0 0 0 0 -1  0 1 0 0]'*0.05];
% z_des     = [t_des, [1 1 1 1  1  1 1 1 1]'*.015];
tfin = 50;

%% Initialisation
bancEssaiConstantes
%bancessai_ini  %faites tous vos calculs de modele ici

%% Vecteurs de tensions simulées
VA = [t_des, (linspace(0, -Vmax, length(t_des)))'];
VB = [t_des, (linspace(0, -Vmax, length(t_des)))'];
VC = [t_des, (linspace(0, -Vmax, length(t_des)))'];


%% Calcul des compensateurs
%iniCTL_ver4    %Calculez vos compensateurs ici

%% Simulation
open_system('simulink_non_lineaire')
set_param('simulink_non_lineaire','AlgebraicLoopSolver','LineSearch')
sim('simulink_non_lineaire')

%affichage
%trajectoires