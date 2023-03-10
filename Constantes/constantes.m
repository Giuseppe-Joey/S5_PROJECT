g   = 9.81;

z_range  = 22.2e-03;            % m
zr_comb = [0 0 0; 0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 0 1; 1 1 0; 1 1 1]'*z_range;


%% Distance 2D du centre des aimants de sustentation au centre de la plaque
rABC = 95.20e-03;     % m

%% Course maximale en angle
A_range = (z_range/rABC)/(2*sqrt(2));

%% Coordonn?es des aimants
XA = +rABC;
YA =  0.0;
ZA =  0.0;
XB = -rABC*sind(30);
YB = +rABC*cosd(30);
ZB =  0.0;
XC = -rABC*sind(30);
YC = -rABC*cosd(30);
ZC =  0.0;

xvec_ABC = [XA, XB, XC]';
yvec_ABC = [YA, YB, YC]';

TABC = [yvec_ABC'; -xvec_ABC'; ones(1,3)];
TABC_inv = inv(TABC);

ptz_comb = TABC_inv' * zr_comb;
ptz_range = max(ptz_comb,[],2);

%% Distance 2D du centre des aimants effet Hall au centre de la plaque
rDEF = 80.00e-03;     % m

%% Coordonn?es des capteurs ? effet Hall
% Donn?es mises ? jour le 10 mai 2015
XD = +rDEF*sind(30);
YD = +rDEF*cosd(30);
ZD =  0.0;
XE = -rDEF;
YE =  0.0;
ZE =  0.0;
XF = +rDEF*sind(30);
YF = -rDEF*cosd(30);
ZF =  0.0;

xvec_DEF = [XD, XE, XF]';
yvec_DEF = [YD, YE, YF]';

TDEF = [yvec_DEF'; -xvec_DEF'; ones(1,3)];
TDEF_inv = inv(TDEF);

%% Param?tres inertiels
% --------------------

% Donn?es mises ? jour le 10 juillet 2015
% Sph?re
mS = 0.0080;           % kg
rS = 0.0039;           % m
JS = 2*mS*rS^2/5;     % solid kg m^2
% JS = 2*mS*rS^2/3;     % hollow

%% Param?tres d?riv?s de la sph?re
mSeff = mS+JS/rS^2;   % kg - masse effective de la sph?re
mSg   = mS*g;         % N - poids de la sph?re

%% Plaque
mP = 425e-03;     % kg
Jx =  1169e-06;  % kg m^2
Jy =  Jx;             % kg m^2
Jz = 2329e-06;  % kg m^2

mtot = mP + sig*mS;   % kg - mase totale plaque + sph?re

%% Simulation
Vmax = 16.0;

%% Param?tres ?lectriques des actionneurs
% Donn?es mises ? jour le 10 juillet 2015
RR = 3.6;
LL = .115;
RA =  RR;
LA =  LL;
RB =  RR;
LB =  LL;
RC =  RR;
LC =  LL;

%% Constantes des Fk
% LUCAS AJOUTE TES CALCULS ICI (ou dans un .m pis ajoute le path des
% constantes)

be1 = 13.029359254409743;

ae0 = 1.339300773473042;
ae1 = 3.570527671215823e+02;
ae2 = 50.139588333666325;
ae3 = 7.694247721681595e+05;

as0 = 0.058705851628389;
as1 = 22.606122743582090;
as2 = 7.446649680957198e+02;
as3 = 2.458002097972035e+05;

%% Calculs ? l'?quilibre 
% ***********************
% FzABC = FA+FB+FC
% FzABC = 3Fk
% ***********************
% z_dbl_dot = FzABC/mtot + g
% 0 = FzABC/mtot + g            % on sait que z_dbl_dot = 0 a lequilibre
% FzABC = -g * mtot;
% ***********************
% 3Fk = -g * mtot;
% Fk = -g*mtot / 3;
% Fk = ((((ik*abs(ik)) + (be*ik)) / (aE0 + aE1*zk + aE2*(zk^2) + 
%       aE3*(zk^3))) - 1/(aS0 + aS1*zk + aS2*(zk^2) + aS3*(zk^3))) 
% ***********************

syms ieq
zk = Pzeq;      % metres
eq = -g*mtot/3 == (ieq*abs(ieq) + be1*ieq)/(ae0 + ae1*Pzeq + ae2*(Pzeq^2) + ae3*(Pzeq^3)) - 1/(as0 + as1*Pzeq + as2*(Pzeq^2) + as3*(Pzeq^3)); 
ieq = double(solve(eq, ieq));
V_eq =  RR*ieq;
