function WD=DISTMAT(C1,C2,cutoff,OPTION,PHI)

%DISTMAT(Cs,Ct) creates a distance matrix given two vectors of coordinates.
%               Cs (nx2) and Ct (mx2) correspond to the source points and
%               the target points. The function returns a matrix (nxm) with
%               the distance between each of the points in C2 to each of the points
%               in C1.
%
%DISTMAT(Cs,Ct,d) d is a cuttoff distance. All entries beyond this distance
%               are set to zero. This is useful when creating spatial
%               interactions matrices (see below), and can be used to
%               set a distance beyond which interaction is null. If d=0 the
%               resulting matrix will contain a distance value in every
%               entry. The diagonal elements are zero by definition.
%
%DISTMAT(Cs,Ct,d,OPTION) assigns different values to the entries of the matrix for which
%              distance is less than d. If d=0 then all the entries are valued (except the diagonal which
%              has 0s by definition). The options are:
%
%              BINARY        Binary Weight Matrix ( 1 ) 
%              DISTANCE      Distance Matrix ( DIST )  >> ( Default )
%              INVERSE       Inverse distance Decay ( 1/DIST^PHI )In this case, and additional parameter PHI
%                            is introduced as an argument after the option.
%              EXPONENTIAL   Exponential Decay ( exp(-PHI*DIST^2) ). In this case, and additional parameter PHI
%                            is introduced as an argument after the option.
%
%              For example, to create a distance matrix between points C, use
%              distmat(C,C,0,'DISTANCE')

N=size(C2,1);
I=eye(N);
if nargin<3
   cutoff=0;
   OPTION='distance';
end
if nargin<4
   OPTION='distance';
end
if nargin<5
    PHI=1;
end

for i=1:N
    Wx(:,i)=(C2(i,1)-C1(:,1));
    Wy(:,i)=(C2(i,2)-C1(:,2));
end
WD=(Wx.^2+Wy.^2).^0.5;
if cutoff==0
    cutoff=max(max(WD))+1;
end
cutoff=WD<cutoff;
switch lower(OPTION)
    case 'distance'
        WD=WD.*cutoff;
    case 'binary'
        WD=cutoff-I;
    case 'inverse'
        WD=((WD+I).^(-PHI)-I).*cutoff;
    case 'exponential'
        WD=(exp(-PHI*(WD).^2)-I).*cutoff;
    otherwise
        errordlg('Not a valid option');
end