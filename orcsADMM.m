% -------------------------------------------------------------------------
% This function solves the upper level problem of ORCS
% i.e., determine the optimal demand shift from UE to SO users
% -------------------------------------------------------------------------
% Inputs:
%   net         - network structure
%   hyper       - parameter structure
%   gamma       - control coefficient
%   x0          - initial link flow pattern
%   qmin/qmax   - lower/upper bound of demand shift
% Outputs:
%   q           - demand shift 
%   x           - link flow pattern
%   elp         - elapsed time


% written by Kenan Zhang, 2017
% Northwestern University


function [q,elp] = orcsADMM(net, hyper, gamma, x0, qmin, qmax)
tic

% difference between UE-path and SO-path
path_diff = pathDiff(net, x0);

% initial solution
x = x0;
z = zeros(net.nod,1);
z0 = z;
u = zeros(net.nod,1);

% main loop
err1 = inf;
err2 = inf;
iter = 0;

while (err1 > hyper.tol3 || err2 > hyper.tol3) && iter < hyper.N3
    % update shift 
    q = z-u-path_diff*linkCost_so(x, net.tau0, net.sat)/hyper.rho;
    
    % update link flow
    x = updateFlow(net, q, x0);
    
    % update z
    z = softThreshold(gamma/hyper.rho, q+u, qmin, qmax);
    
    % update u
    u = u+q-z;
    
    % compute errors
    err1 = norm(q-z,1);
    err2 = norm(z-z0,1);
    
    z0 = z;
    iter = iter + 1;
end

% regularize demand shift
q = max(q,qmin);
q = min(q,qmax);

tt = totalCost_so(x, net.tau0, net.sat);
fprintf(...
    ' -- ADMM: iter %d, total travel time %0.4f, demand shift %0.4f, err1 %0.4f, err2 %0.4f \n',...
    iter,tt,norm(q,1),err1,err2)

elp = toc;
    
    
    



