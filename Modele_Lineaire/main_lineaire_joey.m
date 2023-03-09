%% Projet S5 - Asservissement d'un système dynamique
% Auteurs: [insert cips]
close all
clear all
clc

% Position à l'équilibre de la sphère (pour tests statiques)
sig = 1.0;         % Présence (1) ou non (0) de la sphère
xSeq = 0.000;      % Position x de la sphère à l'équilibre en metres
ySeq = 0.000;      % Position y de la sphère à l'équilibre en metres

% Point d'opération choisi pour la plaque
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




% Vecteurs de tensions simulées
VA = [t_des, (linspace(0, -Vmax, length(t_des)))'];
VB = [t_des, (linspace(0, -Vmax, length(t_des)))'];
VC = [t_des, (linspace(0, -Vmax, length(t_des)))'];


% Calcul des compensateurs
%iniCTL_ver4    %Calculez vos compensateurs ici

%% Simulation
%open_system('modele_lineaire')
%set_param('modele_lineaire','AlgebraicLoopSolver','LineSearch')
%sim('modele_lineaire')

%affichage
%trajectoires



%% Constantes lineaires a lequilibre devant les deltas

ib_eq = VB/RB;
ic_eq = VC/RC;
z_eq = Pzeq;        %Pzeq est une variable globale declaree plus haut

% section derivee de phi double dot par rapport a ic
den = Jx*abs(ic_eq)*(ae0 + ae1*z_eq + ae2*z_eq^2 + ae3*z_eq^3);
del_phi2dot_del_ic = (YB*((2*ic_eq).^2 + be1*abs(ic_eq)))/den;


% section derivee de phi double dot par rapport a ib
den = Jx*abs(ib_eq)*(ae0 + ae1*z_eq + ae2*z_eq^2 + ae3*z_eq^3);
del_phi2dot_del_ib = -(YB*((2*ib_eq).^2 + be1*abs(ib_eq)))/den;


% section derivee de phi double dot par rapport a z
fct_ic = ic_eq.*(abs(ic_eq)+be1);
fct_ib = ib_eq.*(abs(ib_eq)+be1);

fct_E_zc = (ae0 + ae1*z_eq + ae2*z_eq^2 + ae3*z_eq^3);
fct_S_zc = (as0 + as1*z_eq + as2*z_eq^2 + as3*z_eq^3);

fct_E_zc_prime = (ae1 + 2*ae2*z_eq + 3*ae3*z_eq^2);
fct_S_zc_prime = (as1 + 2*as2*z_eq + 3*as3*z_eq^2);

del_Fc_del_zc = -(fct_ic*fct_E_zc_prime/(fct_E_zc)^2) + fct_S_zc_prime/((fct_S_zc)^2);
del_Fb_del_zc = -(fct_ib*fct_E_zc_prime/(fct_E_zc)^2) + fct_S_zc_prime/((fct_S_zc)^2);
del_phi2dot_del_z = (YB/Jx)*(del_Fc_del_zc - del_Fb_del_zc)


% section derivee de phi double dot par rapport a phi
phi_eq = 0;
del_phi2dot_del_phi = 0;


% section derivee de phi double dot par rapport a teta
teta_eq = 0;
del_phi2dot_del_teta = 0;








%Coefficient de Frank
be = 13.029359254409743;
% i1 = -1;
% i2 = -2;
aE0 = 1.339300773473042;
aE1 = 3.570527671215823e+02;
aE2 = 50.139588333666325;
aE3 = 7.694247721681595e+05;
aS0 = 0.058705851628389;
aS1 = 22.606122743582090;
aS2 = 7.446649680957198e+02;
aS3 = 2.458002097972035e+05;


syms ik
zk = 0.015;      %metres
g = 9.81;        % m/s^2
mtot = 0.4250;
Fk = 0.015;

Fk = (((ik*abs(ik)) + (be*ik)) / (aE0 + aE1*zk + aE2*(zk^2) + aE3*(zk^3))) - 1/(aS0 + aS1*zk + aS2*(zk^2) + aS3*(zk^3))


S = solve( Fk , ik )

%Fk = -g*mtot/3;


















%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Calcul pour Fk, ik, Vk                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Coefficient de Lucas_dot
be = 13.029359254409743;
% i1 = -1;
% i2 = -2;
aE0 = 1.339300773473042;
aE1 = 3.570527671215823e+02;
aE2 = 50.139588333666325;
aE3 = 7.694247721681595e+05;
aS0 = 0.058705851628389;
aS1 = 22.606122743582090;
aS2 = 7.446649680957198e+02;
aS3 = 2.458002097972035e+05;






syms ik
zk = 0.015;      %metres
g = 9.81;        % m/s^2
mtot = 0.4250;

% ***************
% FzABC = -FA-FB-FC
% FzABC = -3Fk
%
% z_dbl_dot = FzABC/mtot + g
% 0 = FzABC/mtot + g
% FzABC = -g*mtot;
% 
% Fk = g*mtot/3;
% Fk = ((((ik*abs(ik)) + (be*ik)) / (aE0 + aE1*zk + aE2*(zk^2) + aE3*(zk^3))) - 1/(aS0 + aS1*zk + aS2*(zk^2) + aS3*(zk^3))) 
% ***************

equation = g*mtot/3 == ((((ik*abs(ik)) + (be*ik)) / (aE0 + aE1*zk + aE2*(zk^2) + aE3*(zk^3))) - 1/(aS0 + aS1*zk + aS2*(zk^2) + aS3*(zk^3))) 
ik = double(solve(equation, ik))





















