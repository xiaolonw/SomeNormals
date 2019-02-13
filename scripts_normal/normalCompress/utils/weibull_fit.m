function wparams = weibull_fit(X, p_tail, alpha)
% WEIBULL_FIT - Computes the weibull fitting parameters
%
% Usage: wparams = weibull_fit(X, p_tail, alpha)
%
% Input:
%   X - scores Nx1
%   p_tail - percentage of tail to use (less than 0.5)
%   alpha - confidence level of parameters
%
%
% Output:
%   wparams
%       .bias - bias of X to make them all positive (X + bias is > 0)
%       .a, .b - weibull parameters
%
% Edward Hsiao
% ehsiao@cs.cmu.edu

% initialize parameters
wparams = [];
wparams.bias = 0;
wparams.a = 0;
wparams.b = 0;

% sort the scores and normalize so above 0
X = sort(X, 'descend');
minX = X(end);
if minX < 0, 
    wparams.bias = -minX + 0.001; 
    X = X + wparams.bias;
end

% select the tail
N = length(X);
Xtail = X(1:floor(N*p_tail));

% compute the weibull fit
%Use Matlab's stat toolbox code
[weibull_parms, parms_confidence_interval] = wblfit(Xtail,alpha)
wparams.a = weibull_parms(1);
wparams.b = weibull_parms(2);
