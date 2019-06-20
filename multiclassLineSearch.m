% -------------------------------------------------------------------------
% This function applies line-search to determine the moving step
% -------------------------------------------------------------------------
% Inputs:
%   net         - network structure
%   hyper       - parameter structure
%   x           - current link flow pattern
%   x_ue/x_so   - all-or-nothing flow assignment
% Outputs:
%   a           - moving step


% written by Kenan Zhang, 2017
% Northwestern University

function step = multiclassLineSearch(net, hyper, x, x_ue, x_so)
% initialization
a = 0;
b = 1;
x1 = x(:,1);
x2 = x(:,2);
y1 = x_ue;
y2 = x_so;


% midpoint
step = 0.5*(a+b);
x(:,1) = x1+step*(y1-x1);
x(:,2) = x2+step*(y2-x2);
% link travel time
tau_ue = linkCost_ue(x, net.tau0, net.sat);
tau_so = linkCost_so(x, net.tau0, net.sat);
% change in total travel time
d = tau_ue'*(y1-x1)+tau_so'*(y2-x2);

% main loop
iter = 0;

while (b-a > hyper.tol2 && iter < hyper.N2) || d > 0
    if d < 0
        a = step;
    else
        b = step;
    end
    step = 0.5*(a+b);
    
    % midpoint
    x(:,1) = x1+step*(y1-x1);
    x(:,2) = x2+step*(y2-x2);
    
    % link travel time
    tau_ue = linkCost_ue(x, net.tau0, net.sat);
    tau_so = linkCost_so(x, net.tau0, net.sat);
    
    % change in total travel time
    d = tau_ue'*(y1-x1)+tau_so'*(y2-x2);
    
    iter = iter+1;
end

    
