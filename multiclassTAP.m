% -------------------------------------------------------------------------
% This function solves multi-class TAP using Frank-Wolfe algorithm
% -------------------------------------------------------------------------
% Inputs:
%   net         - network structure
%   hyper       - parameter structure
%   split       - demand split
% Outputs:
%   x           - link flow pattern
%   elp         - elapsed time


% written by Kenan Zhang, 2017
% Northwestern University

function [x,elp] = multiclassTAP(net, hyper, split, x0)
tic
% split demand
Q = split.*net.od_demand;

% initial solution
if x0 == 0
    x = zeros(net.na,2);
else
    x = x0;
end

tau_ue = linkCost_ue(x, net.tau0, net.sat);
tau_so = linkCost_so(x, net.tau0, net.sat);
x(:,1) = spAssign(net, tau_ue, Q(:,1));
x(:,2) = spAssign(net, tau_so, Q(:,2));
    
% main loop
gap_ue = inf;
gap_so = inf;
iter = 0;

while (gap_ue > hyper.tol1 || gap_so > hyper.tol1) && iter < hyper.N1
    % update link travel time
    tau_ue = linkCost_ue(x, net.tau0, net.sat);
    tau_so = linkCost_so(x, net.tau0, net.sat);
    
    % all-or-nothing flow assignment
    x_ue = spAssign(net, tau_ue, Q(:,1));
    x_so = spAssign(net, tau_so, Q(:,2));
    
    % line search
    a = multiclassLineSearch(net,hyper,x,x_ue,x_so);
    
    % compute gap between upper and lower bounds
    ub_ue = totalCost_ue(x, net.tau0, net.sat);
    lb_ue = ub_ue+linkCost_ue(x, net.tau0, net.sat)'*(x_ue-x(:,1));
    gap_ue = ub_ue-lb_ue;
    
    ub_so = totalCost_so(x, net.tau0, net.sat);
    lb_so = ub_so+linkCost_so(x, net.tau0, net.sat)'*(x_so-x(:,2));
    gap_so = ub_so-lb_so;
    
    
    % update link flow
    x(:,1) = x(:,1)+a*(x_ue-x(:,1));
    x(:,2) = x(:,2)+a*(x_so-x(:,2));
    
    iter = iter+1;
    
end

fprintf(' -- multiclass TAP: iter %d, gap_ue %0.4f, gap_so %0.4f \n',...
         iter, gap_ue, gap_so)
     
elp = toc;
    
    
    
    


