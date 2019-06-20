% -------------------------------------------------------------------------
% This function generate shortest path tree using Bellman method
% -------------------------------------------------------------------------
% Inputs:
%   net         - network structure
%   c           - line cost
%   org         - origin index
% Outputs:
%   p           - shortest path 
%   u           - cost of shortest path


% written by Kenan Zhang, 2017
% Northwestern University

function [p,u] = bellman(net, c, org)
% initilization
u = inf*ones(net.nn,1);
p = -1*ones(net.nn,1);
u(org) = 0; %init origin 
q = zeros(net.nn,1);
begP = org;
endP = org;
q(org) = inf;


while begP < inf %check if queue is empty
    ox = begP; %take front node in q
    frst = net.frstout(ox);
    lst = net.lstout(ox);
    for j = frst:lst
        ix = net.bnode(j);
        if u(ix) > u(ox)+c(j)
            u(ix) = u(ox)+c(j);
            p(ix) = j;
            if q(ix) == 0
                q(endP) = ix;
                endP = ix;
                q(ix) = inf;
            end
        end
    end
    temp = begP;
    begP = q(begP);
    q(temp) = 0;
end

