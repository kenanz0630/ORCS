% -------------------------------------------------------------------------
% This function update the demand split
% -------------------------------------------------------------------------
% Inputs:
%   net         - network structure
%   split       - current split
%   q           - demand shift
%   r_max       - maximum control ratio
% Outputs:
%   split       - updated split

% written by Kenan Zhang, 2017
% Northwestern University


function split = updateSplit(net, split, q, cmax)
split = split + q./net.od_demand*[-1,1];
split(:,2) = min(split(:,2),cmax);
split(:,1) = 1-split(:,2);