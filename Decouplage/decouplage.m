%% Projet S5 - Asservissement d'un système dynamique
% Auteurs: [insert cips]
close all
clear all
clc

%% Position à l'équilibre de la sphère (pour tests statiques)
sig = 0.0;         % Présence (1) ou non (0) de la sphère
xSeq = 0.000;      % Position x de la sphère à l'équilibre en metres
ySeq = 0.000;      % Position y de la sphère à l'équilibre en metres

%% Point d'opération choisi pour la plaque
Axeq = 0;               %en degres
Ayeq = 0;               %en degres
Pzeq = .015;            %en metres
z_eq = Pzeq;
%% Exemple de trajectoire
t_des     = [0:1:8]';
x_des     = [t_des, [0 0 0.5 1  0 -1 0 1 0]'*0.0];
y_des     = [t_des, [0 0 0 0 -1  0 1 0 0]'*0.0];
z_des     = [t_des, [1 1 1 1  1  1 1 1 1]'*.015];
tfin = 50;

%% Initialisation constantes
constantes_lineaire % call le fichier des constantes

%% Vecteurs de tensions simulées
VA = [t_des, -1.66*ones(length(t_des), 1)];
VB = [t_des, -1.66*ones(length(t_des), 1)];
VC = [t_des, -1.66*ones(length(t_des), 1)];

%% Calcul des compensateurs
%iniCTL_ver4    %Calculez vos compensateurs ici

%% Linéarisation
% Constantes à l'équilibre 
z_eq = Pzeq;       %Pzeq est une variable globale declaree plus haut

V_eq = -1.6701; % Chiffre arbitraire c'est À CALCULER PAR JOEY
ia_eq = V_eq/RA;
ib_eq = V_eq/RB;
ic_eq = V_eq/RC;

% Parties utilisées souvents dans les dérivées partielles (À L'ÉQUILIBRE)
den_fe = ae0 + ae1*z_eq + ae2*z_eq^2 + ae3*z_eq^3;
diff_den_fe = ae1 + 2*ae2*z_eq + 3*ae3*z_eq^2;

den_fs = as0 + as1*z_eq + as2*z_eq^2 + as3*z_eq^3;
diff_den_fs = as1 + 2*as2*z_eq + 3*as3*z_eq^2;

num_fe_a = ia_eq*abs(ia_eq) + be1*ia_eq;
% diff_num_fe_a= (2*ia_eq^2 + be1*abs(ia_eq)) / abs(ia_eq);
diff_num_fe_a= (2*abs(ia_eq) + be1);

num_fe_b = ib_eq*abs(ib_eq) + be1*ib_eq;
% diff_num_fe_b = (2*ib_eq^2 + be1*abs(ib_eq)) / abs(ib_eq);
diff_num_fe_b= (2*abs(ib_eq) + be1);

num_fe_c = ic_eq*abs(ic_eq) + be1*ic_eq;
% diff_num_fe_c = (2*ic_eq^2 + be1*abs(ic_eq)) / abs(ic_eq);
diff_num_fe_c= (2*abs(ic_eq) + be1);

diff_fa_za = (-num_fe_a*diff_den_fe)/(den_fe^2) + diff_den_fs/(den_fs^2);
diff_fb_zb = (-num_fe_b*diff_den_fe)/(den_fe^2) + diff_den_fs/(den_fs^2);
diff_fc_zc = (-num_fe_c*diff_den_fe)/(den_fe^2) + diff_den_fs/(den_fs^2);

diff_fa_ia = diff_num_fe_a / den_fe;
diff_fb_ib = diff_num_fe_b / den_fe;
diff_fc_ic = diff_num_fe_c / den_fe;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  Dérivées partielles delta phi_dot_dot                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Derivee de phi double dot par rapport a ic
phi2dot_ic = (YB/Jx) * diff_fc_ic;

% 2. Derivee de phi double dot par rapport a ib
phi2dot_ib = (-YB/Jx) * diff_fb_ib;

% 3. Derivee de phi double dot par rapport a z
phi2dot_z = (YB/Jx)*(diff_fc_zc - diff_fb_zb);

% 4. Derivee de phi double dot par rapport a phi
phi2dot_phi = (YB/Jx)*(diff_fc_zc*YC - diff_fb_zb*YB);

% 5. Derivee de phi double dot par rapport a theta
phi2dot_theta = (YB/Jx)*(diff_fb_zb*XB - diff_fc_zc*XC);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Dérivées partielles delta theta_dot_dot                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 6. Derivee de theta double dot par rapport a ia
theta2dot_ia = (XA/Jy) * diff_fa_ia;

% 7. Derivee de theta double dot par rapport a ic
theta2dot_ic = (XB/Jy) * diff_fc_ic;

% 8. Derivee de theta double dot par rapport a ib
theta2dot_ib = (XB/Jy) * diff_fb_ib;

% 9. Derivee de theta double dot par rapport a z
theta2dot_z = (XA/Jy)*diff_fa_za + (XB/Jy)*diff_fb_zb + (XB/Jy)*diff_fc_zc;

% 10. Derivee de theta double dot par rapport a phi
theta2dot_phi = (XA*YA/Jy)*diff_fa_za + (XB*YB/Jy)*diff_fb_zb ...
                +(XC*YC/Jy)*diff_fc_zc ;

% 11. Derivee de theta double dot par rapport a theta

theta2dot_theta =  -(XA^2/Jy)*diff_fa_za -(XB^2/Jy)*diff_fb_zb...
                  -(XC^2/Jy)*diff_fc_zc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          Dérivées partielles delta xs_dot_dot et ys_dot_dot             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 12. Constante devant delta theta pour delta xs_dot_dot
xs2dot_theta = -mSg/mSeff;

% 13. Constante devant delta phi pour delta ys_dot_dot
ys2dot_phi = mSg/mSeff;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  Dérivées partielles delta z_dot_dot                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 14. Derivee de z double dot par rapport a ib
z2dot_ia = (-1/mtot) * diff_fa_za;

% 15. Derivee de z double dot par rapport a ib
z2dot_ib = (-1/mtot) * diff_fb_zb;

% 16. Derivee de z double dot par rapport a ic
z2dot_ic = (-1/mtot) * diff_fc_zc;

% 17. Derivee de z double dot par rapport a z
z2dot_z = (-1/mtot) * (diff_fa_za + diff_fb_zb + diff_fc_zc);

% 18. Derivee de z double dot par rapport a phi
z2dot_phi = (-1/mtot) * (-XA*diff_fa_za - XB*diff_fb_zb - XC*diff_fc_zc);
        
% 19. Derivee de z double dot par rapport a theta
z2dot_theta = (-1/mtot) * (YA*diff_fa_za + YB*diff_fb_zb + YC*diff_fc_zc);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Constantes delta i_dot                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 20. Constante devant delta ia pour i_dot_a
idot_ia = -RA/LA;

% 21. Constante devant delta ib pour i_dot_b
idot_ib = -RB/LB;

% 22. Constante devant delta ic pour i_dot_c
idot_ic = -RC/LC;

% 23. Constante devant delta Va pour i_dot_a
idot_Va = 1/LA;

% 24. Constante devant delta Vb pour i_dot_b
idot_Vb = 1/LB;

% 25. Constante devant delta Vc pour i_dot_c
idot_Vc = 1/LC;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            MATRICES D'ÉTATS                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sous-matrices dans la grosse matrice
PP = [  phi2dot_phi,    phi2dot_theta,    phi2dot_z;
      theta2dot_phi,  theta2dot_theta,  theta2dot_z;
          z2dot_phi,      z2dot_theta,      z2dot_z];

PS = zeros(3,2);

PC = [            0,   phi2dot_ib,    phi2dot_ic;
       theta2dot_ia, theta2dot_ib,  theta2dot_ic;
           z2dot_ia,     z2dot_ib,      z2dot_ic ];
       
SP = [         0,   xs2dot_theta,   0;
      ys2dot_phi,              0,   0];
  
CC = [idot_ia,       0,        0;
            0, idot_ib,        0;
            0,       0,  idot_ic];

CV = [idot_Va,       0,        0;
            0, idot_Vb,        0;
            0,       0,  idot_Vc];
        
Tdef_T = [YD, -XD, 1;
          YE, -XE, 1;
          YF, -XF, 1];
      
% Matrice d'état complète
A = [zeros(3,3),       eye(3),   zeros(3,2),   zeros(3,2),   zeros(3,3);
             PP,   zeros(3,3),           PS,   zeros(3,2),           PC;
     zeros(2,3),   zeros(2,3),   zeros(2,2),       eye(2),   zeros(2,3);
             SP,   zeros(2,3),   zeros(2,2),   zeros(2,2),   zeros(2,3);
     zeros(3,3),   zeros(3,3),   zeros(3,2),   zeros(3,2),           CC];

B = [zeros(3,3);
     zeros(3,3);
     zeros(2,3);
     zeros(2,3);
            CV];
        
C = [    TDEF', zeros(3,3),  zeros(3,4), zeros(3,3);
     zeros(4,3), zeros(4,3),      eye(4), zeros(4,3)];
 
D = zeros(7,3);

%% Découplage 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          DÉCOUPLAGE PLAQUE                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Changement de variables entrées
V_phi = [t_des, YC*(VB(:, 2)-V_eq) + YB*(VC(:, 2)-V_eq)];
V_teta = [t_des, XA*(VA(:, 2)-V_eq) + XB*(VB(:, 2)-V_eq) + XC*(VC(:, 2)-V_eq)];
V_z = [t_des,-(VA(:, 2)-V_eq)-(VB(:, 2)-V_eq)-(VC(:, 2)-V_eq)];

% Matrice de transformation U
U = [   0,  YC,     YB;
       XA,  XB,     XB;
       -1,  -1,     -1];   

% Matrice découplée de la plaque avec les changements de coordonnées
% A_plaque = [zeros(3,3),       eye(3),   zeros(3,3);
%                     PP,   zeros(3,3),    PC*inv(U);
%             zeros(3,3),   zeros(3,3),          CC];

A_plaque = [zeros(3,3),       eye(3),   zeros(3,3);
                    PP,   zeros(3,3),    PC*U;
            zeros(3,3),   zeros(3,3),          CC];
        
B_plaque = [zeros(3,3);
            zeros(3,3);
                   CV]
        
C_plaque = [Tdef_T*Tdef_T, zeros(3,3), zeros(3,3)]

 
D_plaque = zeros(3,3);    

% Matrices des sous-système de la plaque

% Axe Phi
A_phi =  [A_plaque(1,1),    A_plaque(1,4),  A_plaque(1,7);
          A_plaque(4,1),    A_plaque(4,4),  A_plaque(4,7);
          A_plaque(7,1),    A_plaque(7,4),  A_plaque(7,7)];
      
B_phi = [            0;
                     0;
         B_plaque(7,1)];

C_phi = [C_plaque(1,1), 0,  0];

D_phi = [0];

% Axe téta
A_teta = [A_plaque(2,2),    A_plaque(2,5),  A_plaque(2,8);
          A_plaque(5,2),    A_plaque(5,5),  A_plaque(5,8);
          A_plaque(8,2),    A_plaque(8,5),  A_plaque(8,8)];
      
B_teta = [             0;
                       0;      
          B_plaque(8,2)];

C_teta = [C_plaque(1,1), 0,  0];

D_teta = [0];

% Axe z
A_z = [A_plaque(3,3),    A_plaque(3,6),  A_plaque(3,9);
       A_plaque(6,3),    A_plaque(6,6),  A_plaque(6,9);
       A_plaque(9,3),    A_plaque(9,6),  A_plaque(9,9)];
      
B_z = [             0;
                    0;
       B_plaque(9,3)];

C_z = [C_plaque(1,1), 0,  0];

D_z = [0];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          DÉCOUPLAGE SPHÈRE                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Matrice découplée de la sphère
A_sphere = [zeros(2,2),       eye(2);
            zeros(2,2),   zeros(2,2)];
        
B_sphere = [zeros(2,3);
                   SP]    

C_sphere = [eye(4)];

D_sphere = zeros(4,3);

% Matrices des sous-système de la sphère

% Axe x (teta)
A_x = [A_sphere(1,1), A_sphere(1,3);
       A_sphere(3,1), A_sphere(3,3)];
   
B_x = [            0; 
       B_sphere(3,2)] ;
   
C_x = [C_sphere(1,1), C_sphere(1,3);
       C_sphere(3,1), C_sphere(3,3)];
   
D_x = [ 0;  0];

% Axe y (phi)
A_y = [A_sphere(2,2), A_sphere(2,4);
       A_sphere(4,2), A_sphere(4,4)];
   
B_y = [             0; 
        B_sphere(4,1)];
   
C_y = [C_sphere(2,2), C_sphere(2,4);
       C_sphere(4,2), C_sphere(4,4)];
   
D_y = [ 0;  0];

%% Simulation
open_system('modele_lineaire_dec')
set_param('modele_lineaire_dec','AlgebraicLoopSolver','LineSearch')
sim('modele_lineaire_dec')

% open_system('banc_essai_lineaire')
% set_param('banc_essai_lineaire','AlgebraicLoopSolver','LineSearch')
% sim('banc_essai_lineaire')
%affichage
%trajectoires


