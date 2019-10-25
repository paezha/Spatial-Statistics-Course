%WD=distmat([X,Y],[X,Y],0,'distance');

% Plot data points and change view
stem3(X,Y,H,'filled','^');xlabel('WEST');ylabel('NORTH');zlabel('HEAD');axis square
view(0,90)
% Surface trend analysis: Linear trend
[bl,El]=olsrep(H,[ones(85,1),X,Y]);
% Calculate values to plot a linear surface
x=[min(get(gca,'xlim')):1:max(get(gca,'xlim'))]';y=[min(get(gca,'ylim')):1:max(get(gca,'ylim'))]';
for i=1:size(x,1)
    for j=1:size(y,1)
        zl(j,i)=bl(1)+bl(2)*x(i)+bl(3)*y(j);
    end;
end
hold
surf(x,y,zl);shading interp
% Plotting the errors
figure;stem3(X.*(El>0),Y.*(El>0),El.*(El>0),'filled','^');xlabel('WEST');ylabel('NORTH');zlabel('E');axis square
hold
stem3(X.*(El<=0),Y.*(El<=0),El.*(El<=0),'filled','r^');xlabel('WEST');ylabel('NORTH');zlabel('E');axis square


% Plot data points and change view
figure;stem3(X,Y,H,'filled','^');xlabel('WEST');ylabel('NORTH');zlabel('HEAD');axis square
view(0,90)
% Surface trend analysis: quadratic trend
[bq,Eq]=olsrep(H,[ones(85,1),X.^2,X,X.*Y,Y,Y.^2]);
% Calculate values to plot a linear surface
x=[min(get(gca,'xlim')):1:max(get(gca,'xlim'))]';y=[min(get(gca,'ylim')):1:max(get(gca,'ylim'))]';
for i=1:size(x,1)
    for j=1:size(y,1)
        zq(j,i)=bq(1)+bq(2)*x(i)^2+bq(3)*x(i)+bq(4)*x(i)*y(j)+bq(5)*y(j)+bq(6)*y(j)^2;
    end;
end
hold
surf(x,y,zq);shading interp;
clear x y zq
% Plotting the errors
figure;stem3(X.*(Eq>0),Y.*(Eq>0),Eq.*(Eq>0),'filled','^');xlabel('WEST');ylabel('NORTH');zlabel('E');axis square
hold
stem3(X.*(Eq<=0),Y.*(Eq<=0),Eq.*(Eq<=0),'filled','r^');xlabel('WEST');ylabel('NORTH');zlabel('E');axis square

% Plot data points and change view
figure;stem3(X,Y,H,'filled','^');xlabel('WEST');ylabel('NORTH');zlabel('HEAD');axis square
view(0,90)
% Surface trend analysis: quadratic trend
[bc,Ec]=olsrep(H,[ones(85,1),X.^3,X.^2.*Y,X.^2,X,X.*Y,Y,Y.^2,X.*Y.^2,Y.^3]);
% Calculate values to plot a linear surface
x=[min(get(gca,'xlim')):1:max(get(gca,'xlim'))]';y=[min(get(gca,'ylim')):1:max(get(gca,'ylim'))]';
for i=1:size(x,1)
    for j=1:size(y,1)
        zc(j,i)=bc(1)+bc(2)*x(i)^3+bc(3)*x(i)^2*y(j)+bc(4)*x(i)^2+bc(5)*x(i)+bc(6)*x(i)*y(j)+bc(7)*y(j)+bc(8)*y(j)^2+bc(9)*x(i)*y(j)^2+bc(10)*y(j)^3;
    end;
end
hold
surf(x,y,zc);shading interp;
clear x y zc
% Plotting the errors
figure
stem3(X.*(Ec>0),Y.*(Ec>0),Ec.*(Ec>0),'filled','^');xlabel('WEST');ylabel('NORTH');zlabel('E');axis square
hold
stem3(X.*(Ec<=0),Y.*(Ec<=0),Ec.*(Ec<=0),'filled','r^');xlabel('WEST');ylabel('NORTH');zlabel('E');axis square

% Variogram
variogram([X,Y],H,'plotit',true)
variogram([X,Y],Ec,'plotit',true)