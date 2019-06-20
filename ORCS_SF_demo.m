% -------------------------------------------------------------------------
% This demo implements ORCS on Sioux Falls network
% main results are reported in
% Zhang, K., & Nie, Y. M. (2018). 
% -------------------------------------------------------------------------


% written by Kenan Zhang, 2017
% Northwestern University



% read network
net = Network('sf.1','sf.2');

% parameters
% max iteration number 
hyper.N1 = 5000; % multi-class TAP
hyper.N2 = 50; % line search
hyper.N3 = 100; % ADMM
hyper.N4 = 50; % main loop

% max gap
hyper.tol1 = 0.005; % multi-class TAP
hyper.tol2 = 0.01; % line search
hyper.tol3 = 0.005; % ADMM
hyper.tol4 = 0.01; % main loop
hyper.rho = 30; % penalty parameter

% control coefficient
% trade-off between system efficiency and control intensity
gamma = 0.1;

% max control ratio
cmax = 1;


% main
init = zeros(net.nod,1); % init with all UE users
[orcs, gap, elp] = ORCS(net, hyper, init, gamma, cmax);
n = size(gap,2);


% benchmark
% UE
split = ones(net.nod,2).*[1,0];
x_ue = multiclassTAP(net, hyper, split, 0);
tt_ue = totalCost_so(x_ue, net.tau0, net.sat);
% SO
split = ones(net.nod,2).*[0,1];
hyper.N1 = 10000;
x_so = multiclassTAP(net, hyper, split, 0);
tt_so = totalCost_so(x_so, net.tau0, net.sat);


% plot results
% total travel time
figure
plot(1:n,orcs.tt, 1:n,tt_ue*ones(1,n), 1:n,tt_so*ones(1,n))
legend('orcs','ue','so')
xlabel('Number of iteration')
ylabel('Total travel time')


% % controlled demand
% figure
% so = sum(orcs.so.*net.od_demand)/sum(net.od_demand)*100;
% plot(1:n, so)
% xlabel('Number of iteration')
% ylabel('Percentage of controlled demand')
% 
% % distribution of controled ratio
% figure
% hist(orcs.so(:,end))
% xlabel('Control ratio')
% ylabel('Number of OD pairs')
% 
% 
% 
% % elapsed time
% figure
% plot(1:n,elp(:,1), 1:n,elp(:,2))
% legend('ADMM','multiTAP')
% xlabel('Number of iteration')
% ylabel('Elapsed time')

