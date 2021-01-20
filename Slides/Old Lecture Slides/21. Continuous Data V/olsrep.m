function [bo,E]=ols(Y,X,W)

% OLSREP(Y,X) Produces a report of the estimated parameters for an Ordinary
%             Least Squares ( OLS ) regression, given observations vector Y and
%             observations matrix X. The report is saved is saved in a file
%             named 'report.txt'.
% OLSREP(Y,X,W) will produce a set of diagnostics for spatial dependency. W is the
%               spatial weights matrix.

% Uses lagmul to calculate the lagrange multipliers, and moran, emoran, vmoran
% to calculate Moran's I, lhols to calculate the log-likelihood, cdet to
% calculate the coefficients of determination

   N=size(X,1); % Size of sample
   K=size(X,2); % Number of parameters for estimation
   bo=inv(X'*X)*X'*Y; % Parameter estimates
   Ybar=mean(Y); % Mean Y
   R2=(bo'*X'*Y-N*Ybar^2)/(Y'*Y-N*Ybar^2); % Coefficient of determination
   R2adj=(1-K/N)*R2; % Adjusted Coefficient of determination
   E=Y-X*bo; % Error terms
   SIG2=(Y'*Y-bo'*X'*Y)/(N-K); % Variance
   SIGMA=sqrt(SIG2);
   SIG2ML=SIG2*(N-K)/N; % Variance (Maximum Likelihood estimator)
   VarCov=SIG2*inv(X'*X); % Variance-Covariance Matrix
   LogLH=-1/2*N*log(SIG2ML); % Log-likelihood; This needs to be adjusted by -N/2*log(2*PI)-N/2
   if nargin<3
       W=[]; % If empty, spatial diagnostics will not be calculated
   end

   % Display output

   ResultsStr=[{['<< O U T P U T >>']}];
   ResultsStr=[ResultsStr;{['                                                                ']}];
   ResultsStr=[ResultsStr;{['<< LINEAR MODEL NO SPATIAL EFFECTS (OLS) >>                     ']}];
   ResultsStr=[ResultsStr;{['                                                                ']}];
   ResultsStr=[ResultsStr;{['   Variable ,   PARAMETER     ,     ST. ERR.    ,     t-value   ']}];
   for i=1:K
       ResultsStr=[ResultsStr;{['   b',sprintf('%3d',i-1),'     ,',...
                       sprintf('%12.5f',bo(i,1)),'     ,'...
                       sprintf('%12.4f',sqrt(VarCov(i,i))),'     ,',...
                       sprintf('%12.4f',bo(i,1)/sqrt(VarCov(i,i))),'   ']}];
   end
   ResultsStr=[ResultsStr;{['                                                                ']}];
   ResultsStr=[ResultsStr;{['   R^2=,         ',sprintf('%13.3f',R2),'                                  ']}];
   ResultsStr=[ResultsStr;{['   R^2(adj)=,    ',sprintf('%13.3f',R2adj),'                                  ']}];
   ResultsStr=[ResultsStr;{['   Likelihood=,  ',sprintf('%13.3f',LogLH),'                                  ']}];
   ResultsStr=[ResultsStr;{['   SIGMA^2=,     ',sprintf('%13.3f',SIG2),'                                  ']}];
   ResultsStr=[ResultsStr;{['   SIGMA^2 (ML)=,',sprintf('%13.3f',SIG2ML),'                                  ']}];
   ResultsStr=[ResultsStr;{['   SIGMA       =,',sprintf('%13.3f',SIGMA),'                                  ']}];
   ResultsStr=[ResultsStr;{['   n=,           ',sprintf('%13d',N),'                                  ']}];
   ResultsStr=[ResultsStr;{['                                                                ']}];
   
   if ~(isempty(W))
     
       % Normalized Moran's I
       ZI=(moran(Y-X*bo,W)-emoran(Y-X*bo,W))/sqrt(vmoran(Y-X*bo,W));
              
       % Lagrange Multipliers for spatial diagnostics
       LM=lagmul(Y,X,W);
       
       % Display statistics
       ResultsStr=[ResultsStr;{['']};{['<<< Diagnostics >>>']}];
       ResultsStr=[ResultsStr;{['                                                                ']}];
       ResultsStr=[ResultsStr;{['<< Normalized Moran''s I >>']}];
       ResultsStr=[ResultsStr;{['   Z ( I )   =,   ',sprintf('%7.3f',ZI),'                                       ']}];
       ResultsStr=[ResultsStr;{['                                                                ']}];
       ResultsStr=[ResultsStr;{['<< Lagrange Multipliers >>']}];       
       ResultsStr=[ResultsStr;{['   Spatial Error Autocorrelation=,   ',sprintf('%10.3f',LM(1,1)),...
                       ', --> Chi2 1 D.F.']}];
       ResultsStr=[ResultsStr;{['   Omitted Spatial Lag          =,   ',sprintf('%10.3f',LM(2,1)),...
                       ', --> Chi2 1 D.F.']}];
       ResultsStr=[ResultsStr;{['   Spatial Dependence           =,   ',sprintf('%10.3f',LM(3,1)),...
                       ', --> Chi2 2 D.F.']}];
       ResultsStr=[ResultsStr;{['                                                                ']}];
   end
       
   ResultsStr
