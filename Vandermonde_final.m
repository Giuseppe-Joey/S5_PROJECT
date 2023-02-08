%% trouver coefs avec Vandermon
X = [0,8,15,20,25]; % Input the values
y = [30,19,20,16,12.5]; % Input the values
N = 5; % Input the order

% Initialize the matrix to store the results
A = zeros(N,N);

% Calculate the sum of X, X^2, X^3, and X^o for N values
for i = 1:N
    for j = 1:N
        A(i,j) = (X(i))^(j-1);
    end
end


B = y.';

R = inv(A)* B;

% Display the results in a matrix
disp(R);

%% plot graph
x = 0:0.1:25;

h = R(1)+R(2)*x+R(3)*x.^2+R(4)*x.^3+R(5)*x.^4;

%% Vitesse avec et sans frottement m/s
uf = 0.63;
g = 9.81;
hi = 30;

%vitesse selon position en x avec frottement
Vf = sqrt(2*g*((hi-h)-uf*x));

%vitesse au point E avec frottement
he = R(1)+R(2)*25+R(3)*25.^2+R(4)*25.^3+R(5)*25.^4;
Vfe = sqrt(2*g*((hi-he)-uf*25))*3.6

%vitesse selon position en x sans frottement
Vfs = sqrt(2*g*(hi-h));

figure('Name','Glissade');
plot(x,h)
hold on
plot(0,30,'r*')
hold on
plot(8,19,'r*')
hold on
plot(15,20,'r*')
hold on
plot(20,16,'r*')
xlabel('x(m)')
ylabel('y(m)')
title('Vitesse du participant en fonction de sa position')

figure('Name','Vitesse m/s');
plot(x,Vf,'DisplayName','avec frottement')
hold
plot(x,Vfs,'DisplayName','sans frottement')
xlabel('x(m)')
ylabel('V(m/s)')
title('Vitesse du participant en fonction de sa position')
legend
%% Vitesse avec et sans frottement km/h
figure('Name','Vitesse km/h');
plot(x,(Vf*3.6),'DisplayName','avec frottement')
hold
plot(x,(Vfs*3.6),'DisplayName','sans frottement')
xlabel('x(m)')
ylabel('V0(km/h)')
title('Vitesse du participant en fonction de sa position')

legend
