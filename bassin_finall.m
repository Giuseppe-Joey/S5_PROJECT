%% Vitesse avec et sans frottement m/s
m=80;
g = 9.81;
b=47;
kf=0.95;
v0=0.9137;
v = 0.1:0.1:14;

%vitesse selon position en x avec frottement
hv = (g*(1-kf)./v)-(b.*v./m);
hv0 = (g*(1-kf)./v0)-(b.*v0./m)
hvl = (g*(1-kf)./v0)-(b.*v0./m)+((g*(kf-1)./(v0.^2))-(b./m)).*(v-v0);
hv4 = (g*(1-kf)./v0)-(b.*v0./m)+((g*(kf-1)./(v0.^2))-(b./m)).*(v-v0);
hv45 = (g*(1-kf)./v0)-(b.*v0./m)+((g*(kf-1)./(v0.^2))-(b./m)).*(v-v0);

figure('Name','Vitesse m/s');
plot(hv,v,'DisplayName','non lin')
hold on
plot(hv0,v0,'-o')
hold on
plot(hvl,v,'DisplayName','lin')
xlabel('t(s)')
ylabel('v(m/s)')
title('Vitesse du participant en fonction de sa position modification pour github')
legend

%% lignes de test vincent r github
