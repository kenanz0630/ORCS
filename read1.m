% CE 471-1: Read network data from .1            
% [nn, frstout, lstout, na, anode, bnode, sat, lngth, vmax] =
  
%
% written by Marco Nie
% Northwestern University

function [nn,frstout,lstout,na,anode,bnode,sat,...
         lngth,vmax] = read1(filename)
fid=fopen(filename,'r');
if fid == -1
  error(strcat('Cannot open file:',filename,'  please check if the specifed folder contain that file!'));
end

nn=fscanf(fid,'%d',1);
A = zeros(2,nn);
A = fscanf(fid,'%d %d',[2 nn]);
na=fscanf(fid,'%d',1);
B = zeros(5,na);
B = fscanf(fid,'%d %d %f %f %f',[5 na]);
frstout = A(1,:)';
lstout  = A(2,:)';
anode = B(1,:)';
bnode = B(2,:)';
sat   = B(3,:)';
lngth = B(4,:)';
vmax  = B(5,:)';
fclose(fid);
%return;