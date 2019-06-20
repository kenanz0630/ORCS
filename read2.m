% CE 471-1: Read travel demand data from .2            
%
% [no,orgid,startod,nod, dest, od_demand]  = read2(filename)
% no - number of origins
% orgid - the vector of origin IDs
% startod  - the index of the first O-D pair for the corresponding origin.
% nod - number of o-d pairs.
% dest - a vector of destination IDs
% od_demand - a vector of O-D demands (q)

%
% written by Marco Nie
% Northwestern University
function [no,orgid,startod,nod, dest, od_demand]  = read2(filename)
fid=fopen(filename,'r');
if fid == -1
    error(strcat('Cannot open file:',filename,'\nplease check if the specifed folder contain that file!'));
end
no=fscanf(fid,'%d',1);
A = zeros(2,no);
A = fscanf(fid,'%d %d',[2 no]);
nod=fscanf(fid,'%8d',1);
B = zeros(2,nod);
B = fscanf(fid,'%d %f',[2 nod]);
orgid    = A(1,:)';
startod  = A(2,:)';
dest     = B(1,:)';
od_demand= B(2,:)';
fclose(fid);
%return;
   