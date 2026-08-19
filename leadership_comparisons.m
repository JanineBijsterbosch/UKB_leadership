clear all; close all; clc

load('../Data/Dcleaned_740199.mat')
%D(D.match==0,:) = [];


% Analysis for RDS-4 against leader/non-leader
T = D(:,["leader_ever" "working_2" "RDS_2" "x31_0_0" "x738_2_0" "x21003_2_0"]);
T(T.leader_ever=='missing',:) = [];
T(isnan(T.RDS_2),:) = [];
aov = anova(T,'RDS_2 ~ 1 + leader_ever + working_2 + x31_0_0 + x738_2_0 + x21003_2_0','CategoricalFactors',["leader_ever" "x31_0_0" "x738_2_0" "working_2"])
%figure; set(gcf,'position',[1     1   606   458])
fig = figure('units','centimeter','position',[0,0,9,6]);
plotComparisons(aov,["leader_ever"])
title('Link between leadership and depression'); xlabel('Depression score (RDS)'); set(gca,'yticklabel',{'leader','not a leader'})
print(gcf,'../results/leadership_rds','-dpng','-r300')
means = groupmeans(aov,["leader_ever"])
multcompare(aov,["leader_ever"])

% % Analysis for probable depression against leader/non-leader
% T = D(:,["leader_ever" "working_2" "MDD" "x31_0_0" "x738_2_0" "x21003_2_0"]);
% T(T.leader_ever=='missing',:) = [];
% T(isnan(T.MDD),:) = [];
% aov = anova(T,'MDD ~ 1 + leader_ever + working_2 + leader_ever*working_2 + x31_0_0 + x738_2_0 + x21003_2_0','CategoricalFactors',["leader_ever" "x31_0_0" "x738_2_0" "working_2"])
% 
% % Analysis for bipolar against leader/non-leader
% T = D(:,["leader_ever" "working_2" "bipolar" "x31_0_0" "x738_2_0" "x21003_2_0"]);
% T(T.leader_ever=='missing',:) = [];
% aov = anova(T,'bipolar ~ 1 + leader_ever + working_2 + leader_ever*working_2 + x31_0_0 + x738_2_0 + x21003_2_0','CategoricalFactors',["leader_ever" "x31_0_0" "x738_2_0" "working_2"])
% 
% % Analysis for manic symptoms against leader/non-leader
% T = D(:,["leader_ever" "working_2" "x5674_2_0" "x31_0_0" "x738_2_0" "x21003_2_0"]);
% T(T.leader_ever=='missing',:) = [];
% aov = anova(T,'x5674_2_0 ~ 1 + leader_ever + working_2 + leader_ever*working_2 + x31_0_0 + x738_2_0 + x21003_2_0', 'CategoricalFactors',["leader_ever" "x31_0_0" "x738_2_0" "working_2"])
% 
% means = groupmeans(aov,["leader_ever" "x31_0_0"])
% m = multcompare(aov,["leader_ever" "x31_0_0",])
% plotComparisons(aov,["leader_ever" "x31_0_0"])

