% -------------------------------------------------------------------------
% Soft-thresholding operation
% -------------------------------------------------------------------------


function x = softThreshold(mu, a, lb, ub)
x = max(0,(abs(a)-mu)).*sign(a);
x = max(x,lb);
x = min(x,ub);