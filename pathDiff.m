% -------------------------------------------------------------------------
% This function derives the aggregate difference in the shortest paths
% between UE-users and SO-users
% -------------------------------------------------------------------------
% Inputs:
%   net         - network structure
%   x           - link flow pattern
% Outputs:
%   path_diff   - index matrix (nod, na)


% written by Kenan Zhang, 2017
% Northwestern University


function path_diff = pathDiff(net, x)
% initialize output
path_diff = zeros(net.nod,net.na);

for i = 1:net.no
    org = net.orgid(i);
    tau_ue = linkCost_ue(x, net.tau0, net.sat);
    tau_so = linkCost_so(x, net.tau0, net.sat);
    [path_ue,~] = bellman(net, tau_ue, org); % UE-path
    [path_so,~] = bellman(net, tau_so, org); % SO-path
    
    % index of last destination
    if i == net.no
        lstdest = net.nod;
    else
        lstdest = net.startod(i+1)-1;
    end
    
    for j = net.startod(i):lstdest
        d = net.dest(j);
        
        % go through UE-path, each link -1
        ix = d;
        ox = net.anode(path_ue(ix));
        while ox ~= org
            path_diff(j,path_ue(ix)) = path_diff(j,path_ue(ix))-1;
            ix = ox;
            ox = net.anode(path_ue(ix));
        end
        path_diff(j,path_ue(ix)) = path_diff(j,path_ue(ix))-1;
        
        % go through SO-path, each link +1
        ix = d;
        ox = net.anode(path_so(ix));
        while ox ~= org
            path_diff(j,path_so(ix)) = path_diff(j,path_so(ix))+1;
            ix = ox;
            ox = net.anode(path_so(ix));
        end
        path_diff(j,path_so(ix)) = path_diff(j,path_so(ix))+1;
    end
end
        
        
        
        
        
    