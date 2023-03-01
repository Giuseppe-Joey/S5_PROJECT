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



%% Constantes lineaires a lequilibre devant les deltas

ib_eq = VB/RB;
ic_eq = VC/RC;
z_eq = Pzeq;        %Pzeq est une variable globale declaree plus haut

% section derivee de phi double dot par rapport a ic
den = Jx*abs(ic_eq)*(ae0 + ae1*z_eq + ae2*z_eq^2 + ae3*z_eq^3)
del_phi2dot_del_ic = (YB*((2*ic_eq)^2 + be1*abs(ic_eq)))/den;


% section derivee de phi double dot par rapport a ib
den = Jx*abs(ib_eq)*(ae0+ae1*z_eq+ae2*z_eq^2+ae3*z_eq^3);
del_phi2dot_del_ib = -(YB*((2*ib_eq)^2 + be1*abs(ib_eq)))/den;


% section derivee de phi double dot par rapport a z
del_phi2dot_del_z = 0;


% section derivee de phi double dot par rapport a phi
phi_eq = 0;
del_phi2dot_del_phi = 0;


% section derivee de phi double dot par rapport a teta
teta_eq = 0;
del_phi2dot_del_teta = 0;









syms f(x)
f(x) = sin(x^2);
Df = diff(f,x)







