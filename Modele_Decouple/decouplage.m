%% Découplage 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          DÉCOUPLAGE PLAQUE                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Changement de variables entrées
% V_phi = [t_des, YC*(VB(:, 2)-V_eq) + YB*(VC(:, 2)-V_eq)];
% V_teta = [t_des, XA*(VA(:, 2)-V_eq) + XB*(VB(:, 2)-V_eq) + XC*(VC(:, 2)-V_eq)];
% V_z = [t_des,-(VA(:, 2)-V_eq)-(VB(:, 2)-V_eq)-(VC(:, 2)-V_eq)];

% Matrice de transformation U
U = [  0,   YB,     YC;
     -XA,  -XB,    -XB;
       1,    1,      1];   

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