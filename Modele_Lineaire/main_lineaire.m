%% Projet S5 - Asservissement d'un système dynamique
% Auteurs: [insert cips]
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

%% Initialisation constantes
constantes_lineaire % call le fichier des constantes


%% Vecteurs de tensions simulées
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


%% Linéarisation
% Constantes à l'équilibre 
ib_eq = VB_eq/RB;
ic_eq = VC_eq/RC;
z_eq = Pzeq;        %Pzeq est une variable globale declaree plus haut

% Parties utilisées souvents dans les dérivées partielles
den_fe = ae0 + ae1*z_eq + ae2*z_eq^2 + ae3*z_eq^3;
diff_den_fe = ae1 + 2*ae2*z_eq + 3*ae3*z_eq^2;

den_fs = as0 + as1*z_eq + as2*z_eq^2 + as3*z_eq^3;
diff_den_fs = as1 + 2*as2*z_eq + 3*as3*z_eq^2;

num_fe_b = ib_eq*abs(ib_eq) + be1*ib_eq;
diff_num_fe_b = (2*ib_eq^2 + be1*abs(ib_eq)) / abs(ib_eq);

num_fe_c = ic_eq*abs(ic_eq) + be1*ic_eq;
diff_num_fe_c = (2*ic_eq^2 + be1*abs(ic_eq)) / abs(ic_eq);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  Dérivées partielles delta z_dot_dot                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 13. Derivee de z double dot par rapport a ic
z2dot_ic = 0;

% 14. Derivee de z double dot par rapport a ib
z2dot_ib = 0;

% 15. Derivee de z double dot par rapport a z
z2dot_z = 0;

% 16. Derivee de z double dot par rapport a phi
z2dot_phi = 0;
        
% 17. Derivee de z double dot par rapport a theta
z2dot_theta = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  Dérivées partielles delta phi_dot_dot                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Derivee de phi double dot par rapport a ic
phi2dot_ic = (YB/Jx) * (diff_num_fe_c) * (1/diff_den_fe);

% 2. Derivee de phi double dot par rapport a ib
phi2dot_ib = (-YB/Jx) * (diff_num_fe_b) * (1/diff_den_fe);

% 3. Derivee de phi double dot par rapport a z
phi2dot_z = (YB/Jx) * ((diff_den_fe * (num_fe_b - num_fe_c))/ (den_fe^2));

% 4. Derivee de phi double dot par rapport a phi
phi2dot_phi = (YB/Jx)*( ...
              ((diff_den_fe*(YB*num_fe_b - YC*num_fe_c))/(den_fe^2)) + ...
               ((diff_den_fs*(YC-YB)) / (den_fs^2))    );
        
% 5. Derivee de phi double dot par rapport a theta
phi2dot_theta = (YB/Jx)*( ...
              ((diff_den_fe*(XC*num_fe_b - XB*num_fe_c))/(den_fe^2)) + ...
               ((diff_den_fs*(XB-XC)) / (den_fs^2))    );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Dérivées partielles delta theta_dot_dot                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 6. Derivee de theta double dot par rapport a ic
theta2dot_ic = (XB/Jy) * (diff_num_fe_c) * (1/diff_den_fe);

% 7. Derivee de theta double dot par rapport a ib
theta2dot_ib = (XB/Jy) * (diff_num_fe_b) * (1/diff_den_fe);

% 8. Derivee de theta double dot par rapport a z
theta2dot_z = (XB/Jy) * ( ...
              ((diff_den_fe *(-num_fe_b - num_fe_c))/(den_fe^2)) + ...
              ( (2*diff_den_fs)/(den_fs^2) ) );

% 9. Derivee de theta double dot par rapport a phi
theta2dot_phi = (XB/Jy)*(...
               ((diff_den_fe*(XB*num_fe_b + XC*num_fe_c)) /(den_fe^2) + ...
               (diff_den_fs*(-XB-XC))/ (den_fs^2) ) );
        
% 10. Derivee de theta double dot par rapport a theta
theta2dot_theta = (XB/Jy)*(...
               ((diff_den_fe*(-YB*num_fe_b - XC*num_fe_c)) /(den_fe^2)+ ...
               (diff_den_fs*(YB+YC))/ (den_fs^2) ) );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            MATRICES D'ÉTATS                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%















%% Simulation
% open_system('modele_lineaire')
% set_param('modele_lineaire','AlgebraicLoopSolver','LineSearch')
% sim('modele_lineaire')

%affichage
%trajectoires


