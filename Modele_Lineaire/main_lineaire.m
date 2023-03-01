%% Projet S5 - Asservissement d'un syst�me dynamique
% Auteurs: [insert cips]
close all
clear all
clc

%% Position � l'�quilibre de la sph�re (pour tests statiques)
sig = 1.0;         % Pr�sence (1) ou non (0) de la sph�re
xSeq = 0.000;      % Position x de la sph�re � l'�quilibre en metres
ySeq = 0.000;      % Position y de la sph�re � l'�quilibre en metres

%% Point d'op�ration choisi pour la plaque
Axeq = 0;               %en degres
Ayeq = 0;               %en degres
Pzeq = .015;            %en metres

%% Exemple de trajectoire
t_des     = [0:1:40]';
% x_des     = [t_des, [0 0 0.5 1  0 -1 0 1 0]'*0.05];
% y_des     = [t_des, [0 0 0 0 -1  0 1 0 0]'*0.05];
% z_des     = [t_des, [1 1 1 1  1  1 1 1 1]'*.015];
tfin = 50;

%% Initialisation constantes
constantes_lineaire % call le fichier des constantes


%% Vecteurs de tensions simul�es
% VA = [t_des, (linspace(0, -Vmax, length(t_des)))'];
% VB = [t_des, (linspace(0, -Vmax, length(t_des)))'];
% VC = [t_des, (linspace(0, -Vmax, length(t_des)))'];

% Pour l'instant on va mettre des tensions fixes et regarder la sortie
% On pourra tester les modeles lineaire avec le banc d'essai du prof
% J'ai mis des valeurs arbiraires juste pour pouvoir tester sans avoir de 0
VA_eq = -2.2; %[V]
VB_eq = -2.1; %[V]
VC_eq = -2.3; %[V]

%% Calcul des compensateurs
%iniCTL_ver4    %Calculez vos compensateurs ici


%% Lin�arisation de phi_dot_dot (�quation de delta phi_dot_dot)
% Constantes � l'�quilibre 
ib_eq = VB_eq/RB;
ic_eq = VC_eq/RC;
z_eq = Pzeq;        %Pzeq est une variable globale declaree plus haut

% D�riv�es partielles
% 1. section derivee de phi double dot par rapport a ic
den = Jx*abs(ic_eq)*(ae0 + ae1*z_eq + ae2*z_eq^2 + ae3*z_eq^3);
del_phi2dot_del_ic = (YB*((2*ic_eq)^2 + be1*abs(ic_eq)))/den;

% 2. section derivee de phi double dot par rapport a ib
den = Jx*abs(ib_eq)*(ae0+ae1*z_eq+ae2*z_eq^2+ae3*z_eq^3);
del_phi2dot_del_ib = -(YB*((2*ib_eq)^2 + be1*abs(ib_eq)))/den;


% 3. section derivee de phi double dot par rapport a z
den = Jx*(ae0 + ae1*z_eq + ae2*z_eq^2 + ae3*z_eq^3)^2;
del_phi2dot_del_z = ((ae1 + 2*ae2*z_eq + 3*ae3*z_eq^2)*...
    (be1*(ib_eq-ic_eq) - ic_eq*abs(ic_eq) + ib_eq*abs(ib_eq))) / den;


% 4. section derivee de phi double dot par rapport a phi
num1 = (ae1 + 2*ae2*z_eq+ 3*ae3*z_eq^2)...
    *(YB*(ib_eq*abs(ib_eq)) - YC*(ic_eq*abs(ic_eq)+be1*ic_eq));
den1 = (ae0 + ae1*z_eq + ae2*z_eq^2 + ae3*z_eq^3)^2;
num2 = (ae1 + 2*ae2*z_eq+ 3*ae3*z_eq^2)*(YC-YB);
den2 = (as0 + as1*z_eq + as2*z_eq^2 + as3*z_eq^3)^2;

del_phi2dot_del_phi = (YB/Jx)*(num1/den1 + num2/den2);

% 5. section derivee de phi double dot par rapport a theta
num1 = (ae1 + 2*ae2*z_eq+ 3*ae3*z_eq^2)...
    *(-XB*(ib_eq*abs(ib_eq)) + XC*(ic_eq*abs(ic_eq)+be1*ic_eq));
den1 = (ae0 + ae1*z_eq + ae2*z_eq^2 + ae3*z_eq^3)^2;
num2 = (ae1 + 2*ae2*z_eq+ 3*ae3*z_eq^2)*(XB-XC);
den2 = (as0 + as1*z_eq + as2*z_eq^2 + as3*z_eq^3)^2;
del_phi2dot_del_theta = (XB/Jy)*(num1/den1 + num2/den2);

%% Lin�arisation de theta_dot_dot (�quation de delta theta_dot_dot)


%% Simulation
% open_system('modele_lineaire')
% set_param('modele_lineaire','AlgebraicLoopSolver','LineSearch')
% sim('modele_lineaire')

%affichage
%trajectoires


