clc
close all
clear;

% load avg_hagmann;
sc = SC1;
fc_raw = FC1;
sc(isnan(sc))=0;
n=size(fc_raw,1);
fc_raw=fc_raw.*(1-eye(n));

max_sc = max(max(sc));
sc = sc / max_sc;

% sc(sc~=0) = 1;

% a = 0;
% d = 0.1;
% co = zeros(15,1);
% 
% for i = 1:15
%     a = a + d;
%     co(i) = kuramoto_alpha(sc, fc_raw, a, 500);
% end

% c = 0; d = 50;
% co = zeros(30,1);
% for i = 1:30
%     c = c + d;
%     co(i) = kuramoto_alpha(sc, fc_raw, 1.5, c);
% end

% a1 = 0;
% co1 = zeros(15,1);
% sc(sc~=0) = 1;
% for i = 1:15
%     a1 = a1 + d;
%     co1(i) = kuramoto_alpha(sc, fc_raw, a1);
% end

[fc_sim, fit, fit_sc] = kuramoto_nTrials(sc, fc_raw, 1.2, 500, 5);
% m = matching_ind_und(sc);
% co1 = kuramoto_alpha(m, fc_raw, 1.5, 500);

% figure(2); imagesc(fc_raw); colorbar;

fc1_sim = fc_sim(1:n/2, 1:n/2);
fc2_sim = fc_sim(1:n/2, (n/2+1):end);
fc3_sim = fc_sim((n/2+1):end, 1:n/2);
fc4_sim = fc_sim((n/2+1):end, (n/2+1):end);

fc1_raw = fc_raw(1:n/2, 1:n/2);
fc2_raw = fc_raw(1:n/2, (n/2+1):end);
fc3_raw = fc_raw((n/2+1):end, 1:n/2);
fc4_raw = fc_raw((n/2+1):end, (n/2+1):end);

[co1,p_val1] = corrcoef(fc1_raw,fc1_sim);
[co2,p_val2] = corrcoef(fc2_raw,fc2_sim);
[co3,p_val3] = corrcoef(fc3_raw,fc3_sim);
[co4,p_val4] = corrcoef(fc4_raw,fc4_sim);

% co = zeros(15,1);
% a = 0;
% for i = 1:15
%     a = a + 0.1;
%     [fc_sim, fit, fit_sc] = kuramoto_nTrials(sc, fc_raw, a, 500, 5);
%     co(i) = fit;
% end