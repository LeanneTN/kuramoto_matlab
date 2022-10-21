function [fc_sim, fit, fit_sc] = kuramoto_nTrials( sc, fc_raw, alpha, c, nTrials)
%KURAMOTO_ALPHA Summary of this function goes here
%   Detailed explanation goes here
% Load SC and FC data:
%---------------------
% A : anatomical connectivity.
% FC_emp : functiona l connectivity.
% load sc;
% load fc_raw;
% sc(isnan(sc))=0;
% n=size(fc_raw,1);
% fc_raw=fc_raw.*(1-eye(n));

% load ts;

% figure('name','--- synthetic SC --- ');
%     figure(1);
%     imagesc(sc);
%     colorbar;
     
% figure('name','--- emprical FC --- ');
%     figure(2);
%     imagesc(fc_raw);
%     colorbar;
%%
FC_emp = fc_raw;
A = sc;
% A(A~=0) = 1;
N = size(A,1);

%--------------
Isubdiag = find(tril(ones(N),-1)); % Values below the diagonal.
fc       = FC_emp(Isubdiag); % Vector of all FC values below the diagonal 

cb=zeros(length(Isubdiag),1);

% simulation length and binsize:
% dt=0.1;
% tmax=60000; % WARNING: tmax should be larger than 50000  !
% tspan=0:dt:tmax;

% transfert function:
%---------------------------------------
tspan = [0:0.1:100];

for tr=1:nTrials
    
    y0 = unifrnd(0, pi / 2, 1, N);

    [t,y] = ode45(@(t,y) odefcn(t,y,c,alpha,A), tspan, y0);

    V = sin(y);
    V0 = V(44:1000, :);
    
    Cb = zeros(N);
    for i = 1:N
        for j = 1:N
            V1 = V0(:,i);
            V2 = V0(:,j)
            M = V1 .* V2;
            Cb(i,j) = (mean(M) - mean(V1) * mean(V2)) / (std(V1) * std(V2));
        end
    end

    cb  = cb + atanh(Cb(Isubdiag))/nTrials;
    
end


fc_vec=zeros(N*N,1);
fc_vec(Isubdiag)=cb;
fc_sim=reshape(fc_vec,N,N);
fc_sim=fc_sim+fc_sim';


%------------------------------------------


% fc_sim=fc_sim.*(1-eye(N));

% imagesc(fc_sim);
% colorbar;
        
% [coef,p_val] = corrcoef(fc_raw,fc_sim);
% 
% co = coef(1,2);

[coef1,p1] = corrcoef(fc_raw,fc_sim);
fit = coef1(2);
% p1

[coef2,p2] = corrcoef(sc,fc_sim);
fit_sc = coef2(2);
% p2

end
