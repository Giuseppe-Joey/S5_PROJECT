%% Linéarisation
% Constantes à l'équilibre V_eq calculé dans le fichier des constantes
ia_eq = V_eq/RA;
ib_eq = V_eq/RB;
ic_eq = V_eq/RC;

VA = [t_des, (V_eq+0.01)*ones(length(t_des), 1)];
VB = [t_des, (V_eq+0.01)*ones(length(t_des), 1)];
VC = [t_des, (V_eq+0.01)*ones(length(t_des), 1)];

% Parties utilisées souvents dans les dérivées partielles (À L'ÉQUILIBRE)
den_fe = ae0 + ae1*Pzeq + ae2*Pzeq^2 + ae3*Pzeq^3;
diff_den_fe = ae1 + 2*ae2*Pzeq + 3*ae3*Pzeq^2;

den_fs = as0 + as1*Pzeq + as2*Pzeq^2 + as3*Pzeq^3;
diff_den_fs = as1 + 2*as2*Pzeq + 3*as3*Pzeq^2;

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
phi2dot_z = (YB/Jx)*diff_fc_zc + (YB/Jx)*diff_fb_zb;

% 4. Derivee de phi double dot par rapport a phi
phi2dot_phi = (YC^2/Jx)*diff_fc_zc + (YB^2/Jx)*diff_fb_zb;

% 5. Derivee de phi double dot par rapport a theta
phi2dot_theta = (-YB*XB/Jx)*diff_fb_zb -(YC*XC/Jx)*diff_fc_zc;


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
theta2dot_z = (-XA/Jy)*diff_fa_za + (-XB/Jy)*diff_fb_zb - (XC/Jy)*diff_fc_zc;

% 10. Derivee de theta double dot par rapport a phi
theta2dot_phi = (XA*YA/Jy)*diff_fa_za + (XB*YB/Jy)*diff_fb_zb ...
                +(XC*YC/Jy)*diff_fc_zc ;

% 11. Derivee de theta double dot par rapport a theta

theta2dot_theta =  (-XA^2/Jy)*diff_fa_za -(XB^2/Jy)*diff_fb_zb...
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
z2dot_ia = (1/mtot) * diff_fa_za;

% 15. Derivee de z double dot par rapport a ib
z2dot_ib = (1/mtot) * diff_fb_zb;

% 16. Derivee de z double dot par rapport a ic
z2dot_ic = (1/mtot) * diff_fc_zc;

% 17. Derivee de z double dot par rapport a z
z2dot_z = (1/mtot) * (diff_fa_za + diff_fb_zb + diff_fc_zc);

% 18. Derivee de z double dot par rapport a phi
z2dot_phi = (1/mtot) * (YA*diff_fa_za + YB*diff_fb_zb + YC*diff_fc_zc);
        
% 19. Derivee de z double dot par rapport a theta
z2dot_theta = (1/mtot) * (-XA*diff_fa_za  -XB*diff_fb_zb  -XC*diff_fc_zc);


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