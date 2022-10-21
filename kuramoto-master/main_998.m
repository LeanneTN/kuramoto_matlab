clc
close all
clear;

% load fMRI1_G.mat;
% G1(isnan(G1))=0;
% G2(isnan(G2))=0;
% G3(isnan(G3))=0;
% G4(isnan(G4))=0;
% G5(isnan(G5))=0;
% 
% FC=(G1+G2+G3+G4+G5)/5;
% 
% % load SC_resamp;
% % SC = SC_resamp;
% load CIJ_fbden_indv.mat;
% G2 = CIJ_fbden_indv(:,:,1);
% CIJ2 = CIJ_fbden_indv(:,:,2);
% CIJ3 = CIJ_fbden_indv(:,:,3);
% CIJ4 = CIJ_fbden_indv(:,:,4);
% CIJ5 = CIJ_fbden_indv(:,:,5);
% 
% G2(isnan(G2))=0;
% CIJ2(isnan(CIJ2))=0;
% CIJ3(isnan(CIJ3))=0;
% CIJ4(isnan(CIJ4))=0;
% CIJ5(isnan(CIJ5))=0;
% 
% SC=(G2+CIJ2+CIJ3+CIJ4+CIJ5)/5;

sc = SC;
fc_raw = FC;
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

[fc_sim, fit, fit_sc] = kuramoto_nTrials(sc, fc_raw, 0.9, 500, 5);