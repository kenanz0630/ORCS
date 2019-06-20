% -------------------------------------------------------------------------
% Total travel time based on BPR function
% -------------------------------------------------------------------------

function tt = totalCost_so(x, tau0, sat)
tt = sum(tau0.*(sum(x,2)+0.15.*sat.*(sum(x,2)./sat).^5));

