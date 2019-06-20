% Optimal-ratio control scheme (ORCS)
% -------------------------------------------------------------------------
% This function solves the optimal control ratio 
% based on the formulation proposed in
% Zhang, K., & Nie, Y. M. (2018). 
% -------------------------------------------------------------------------
% Inputs:
%   net         - network structure
%   hyper       - parameter structure
%   cmax       - maximum control ratio (market penetration)
% Outputs:
%   orcs        - ORCS structure
%   gap         - gap over iterations
%   elp         - elapsed time over iterations


% written by Kenan Zhang, 2017
% Northwestern University


function [orcs, gap, elp] = ORCS(net, hyper, init, gamma, cmax)
% initial solutions
split = [1-init, init];
x = multiclassTAP(net, hyper, split, 0);

% main loop
iter = 0;
gap = inf;
split0 = split;

while gap(end) > hyper.tol4 && iter < hyper.N4
    % lower/upper bound of demand shift
    qmin = -split(:,2).*net.od_demand;
    qmax = min(split(:,1),cmax-split(:,2)).*net.od_demand;
    
    % upper-level: solve optimal control ratio by ADMM
    [q,elp_up] = orcsADMM(net, hyper, gamma, x, qmin, qmax);
    
    % update demand split
    split = updateSplit(net, split, q, cmax);
    
    % lower-level: solve multi-class TAP
    [x,elp_lo] = multiclassTAP(net, hyper, split, 0);
    
    % compute gap as l1 norm between consecutive control ratios
    iter = iter + 1;
    gap(iter) = norm(split(:,2)-split0(:,2),1);
    split0 = split;
    
    
    % record outputs
    elp(iter,:) = [elp_up, elp_lo]; % elapsed time
    orcs.so(:,iter) = split(:,2); % ratio of SO users
    orcs.tt(iter) = totalCost_so(x, net.tau0, net.sat); % total travel cost
    
    fprintf('iter %d: total travel time %0.4f, gap %0.4f \n\n',iter,orcs.tt(iter),gap(iter))
end


    
    
    

    