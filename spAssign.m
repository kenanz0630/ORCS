% -------------------------------------------------------------------------
% This function implements all-or-nothing assignment
% -------------------------------------------------------------------------
% Inputs:
%   net         - network structure
%   tau         - link travel time
%   Q           - demand 
% Outputs:
%   x           - link flow pattern


% written by Kenan Zhang, 2017
% Northwestern University

function x = spAssign(net, tau, Q)
% initialize output
x = zeros(net.na,1);

for i = 1:net.no
    % generate shortest path tree
    org = net.orgid(i);
    [path,~] = bellman(net, tau, org);
    
    % index of last destination
    if i == net.no
        lstdest = net.nod;
    else
        lstdest = net.startod(i+1)-1;
    end
    
    for j = net.startod(i):lstdest
        d = net.dest(j);
        ix = d;
        ox = net.anode(path(ix));
        
        while ox ~= org
            x(path(ix)) = x(path(ix))+Q(j);
            ix = ox;
            ox = net.anode(path(ix));
        end
        x(path(ix)) = x(path(ix))+Q(j);
    end
end

        
    
    