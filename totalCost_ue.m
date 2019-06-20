% -------------------------------------------------------------------------
% Object function of UE TAP based on BPR function
% -------------------------------------------------------------------------

function tt = totalCost_ue(x, tau0, sat)
tt = sum(tau0.*(sum(x,2)+0.03.*sat.*(sum(x,2)./sat).^5));

