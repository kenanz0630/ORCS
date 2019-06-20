% -------------------------------------------------------------------------
% This function updates link flow pattern assuming paths are unchanged
% -------------------------------------------------------------------------
% Inputs:
%   net         - network structure
%   q           - demand shift
%   x0          - current link flow pattern
% Outputs:
%   x           - updated link flow pattern


% written by Kenan Zhang, 2017
% Northwestern University

function x = updateFlow(net, q, x0)
% compute link cost
tau_ue = linkCost_ue(x0, net.tau0, net.sat);
tau_so = linkCost_so(x0, net.tau0, net.sat);

% reassign shifted demand flow
y1 = spAssign(net, tau_ue, q);
y2 = spAssign(net, tau_so, q);

% update link flows
x = [x0(:,1)-y1, x0(:,2)+y2];