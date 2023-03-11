%% Projet S5 - Asservissement d'un système dynamique
% Auteurs: [insert cips]
close all
clear all
clc

% Position à l'équilibre de la sphère (pour tests statiques)
sig = 0.0;         % Présence (1) ou non (0) de la sphère
xSeq = 0.000;      % Position x de la sphère à l'équilibre en metres
ySeq = 0.000;      % Position y de la sphère à l'équilibre en metres

% Point d'opération choisi pour la plaque
Axeq = 0;               %en degres
Ayeq = 0;               %en degres
Pzeq = .015;            %en metres

% Exemple de trajectoire
t_des     = [0:1:8]'*5;
x_des     = [t_des, [0 0 0.5 1  0 -1 0 1 0]'*sig];
y_des     = [t_des, [0 0 0 0 -1  0 1 0 0]'*sig];
z_des     = [t_des, [1 1 1 1  1  1 1 1 1]'*Pzeq];
tfin = 50;

% Initialisation
constantes % call le fichier des constantes (right click sur add to path le
           %folder des constantes si ça marche pas

%bancessai_ini  %faites tous vos calculs de modele ici

% Vecteurs de tensions simulées
% VA = [t_des, (ones(length(t_des), 1)*-1.6701)];
% VB = [t_des, (ones(length(t_des), 1)*-1.6701)];
% VC = [t_des, (ones(length(t_des), 1)*-1.6701)];

% Calcul des compensateurs
%iniCTL_ver4    %Calculez vos compensateurs ici

%% Simulation

open_system('banc_essai_non_lineaire')
set_param('banc_essai_non_lineaire','AlgebraicLoopSolver','LineSearch')
sim('banc_essai_non_lineaire')

%affichage
figure(1)
plot(tsim, ynonlineaire(:,3))
title('Trajet de la plaque en z')

figure(2)
plot(tsim, ynonlineaire(:,7))
title('Trajet de la bille en x')

figure(3)
plot(tsim, ynonlineaire(:,8))
title('Trajet de la bille en y')
%trajectoires