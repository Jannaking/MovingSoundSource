function [C,idx] = findnearestneighbour(b,number_of_neighbours)
%FINDNEARESTNEIGHBOUR finds the n nearest neighbours
%
%   Usage: [C,idx] = findnearestneighbour(A,b,[number_of_neighbours]);
%
%   Input parameters:
%       A                     - matrix
%       b                     - colum to search for in A
%       number_of_neighbours  - number of nearest neighbours to find
%
%   output parameters:
%       C                     - found neighbour columns
%       idx                   - indices of found columns in matrix
%
%   FINDNEARESTNEIGHBOUR(A,b,number_of_neighbours) returns a number_of_neighbours
%   column vectors with the nearest neighbour points from the matrix A to the
%   point b. In addition to the values, the indices are also returned.
%

%% ===== Checking and Declaring  of input parameters ====================================
nargmin = 1;
nargmax = 2;
narginchk(nargmin,nargmax);
if nargin==nargmax-1
    number_of_neighbours = 1;
end
% Ensure column vector
if size(b,2)>1
    b=b';
end
az=[-80 -65 -55 -45:5:45 55 65 80];
el=-45:5.625:230.625;
count=0;
for i=1:25
    for j=1:50
        count=count+1;   
        A(1,count)=az(i);
        A(2,count)=el(j);
    end
end
if number_of_neighbours>size(A,2)
    error(['%s: your number of neighbours is larger than the available ', ...
        'points.'],upper(mfilename));
end


% Calculate distance between points
y=bsxfun(@minus,A,b);
distance = sum(abs(y).^2,1).^(1/2);

[~,idx] = sort(distance);
idx = idx(1:number_of_neighbours);
C = A(:,idx);
end