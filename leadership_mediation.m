clear all; close all; clc

addpath(genpath('/Users/janinebijsterbosch/Dropbox/Matlab/canlab-MediationToolbox/'));
addpath('/Users/janinebijsterbosch/Dropbox/Matlab');
load('../Data/Dcleaned_740199.mat')

% Prep confounds
Z = table2array(D(:,["x31_0_0" "x738_2_0" "x21003_2_0"]));
Z = [Z double(table2array(D(:,"working_2")))];

% Prep leadership inputs
X = double(table2array(D(:,"leader_ever")));
%leaders=2 non-leaders=1

% Prep mental health inputs
Y = table2array(D(:,"RDS_2"));

% Prep mediators
mediator_vars = {'x1558_2_0','x1160_2_0','x1031_2_0','x2178_2_0',...
    'x4537_2_0','x4548_2_0','x4581_2_0'};
mediator_names = {'Alcohol','sleep','Social_Support','Health_Rating',...
    'jobSatisfaction','healthSatisfaction','financialSatisfaction'};
%Note alcohol answers are reversed coded 1=daily, 6=never
%Note satisfaction answers are reversed coded 1=happy, 6=unhappy

for n = 1:length(mediator_vars)
    i = strcmp(D.Properties.VariableNames,mediator_vars{n});
    D.Properties.VariableNames(i==1) = mediator_names(n);
end

% Remove missing subjects
mis = zeros(size(D,1),1);
mis(isnan(sum(Z,2))) = 1;
mis(isnan(sum(X,2))) = 1;
mis(isnan(sum(Y,2))) = 1;
for n = 1:length(mediator_names)
    M = table2array(D(:,mediator_names{n}));
    mis(isnan(sum(M,2))) = 1;
end
Z(mis==1,:) = []; X(mis==1,:) = []; Y(mis==1,:) = []; D(mis==1,:) = [];

%Run mediation
p_mediation = zeros(size(mediator_names,1),1);
figure('units','centimeter','position',[0,0,18,22]); sig = 1;
T = {'A','B','C'};
for n = 1:length(mediator_names)
    M = table2array(D(:,mediator_names{n}));
    %[paths, stats] = mediation(X, Y, M, 'covs', Z, 'verbose', 'plots', 'robust', 'boot', 'bootsamples', 1000, 'names',{'leadership','depression',mediator_names{n}});
    [paths, stats] = mediation(X, Y, M, 'covs', Z, 'verbose', 'names',{'Leadership','Depression', mediator_names{n}});
    if stats.p(5)<0.05/length(mediator_names)
        subplot(3,1,sig)
        title(sprintf('%s. Mediation effect of %s',T{sig},mediator_names{n}),'interpreter','none')
        mediation_path_diagram(stats)
        sig = sig+1;
        fprintf('%s was significant coefficient = %1.5f, pcorrected = %1.10f\n',mediator_names{n},stats.paths(5),stats.p(5)*length(mediator_names))
    else
        fprintf('%s was non-significant coefficient = %1.5f, pcorrected = %1.10f\n',mediator_names{n},stats.paths(5),stats.p(5)*length(mediator_names))
    end
end
print(gcf,'../results/mediation','-dpng','-r300')

fprintf('Mediation sample: N=%d, age %2.2f (SD %2.2f), percent male %2.2f\n',size(D,1),mean(D.x21003_2_0),std(D.x21003_2_0),sum(D.x31_0_0)/size(D,1)*100);

% % Run mediation with alcohol and social support
% M = table2array(D(:,mediator_names{1}));
% M2 = table2array(D(:,mediator_names{3}));
% [paths, stats] = mediation(X, Y, M, 'M', M2, 'covs', Z, 'verbose', 'names',{'Leadership','Depression', mediator_names{1}, mediator_names{3}});

% % Test association between alcohol and depression separately in leaders and non-leaders
% T = D(D.leader_ever=='leader',["Alcohol" "working_2" "RDS_2" "x31_0_0" "x738_2_0" "x21003_2_0"]);
% aov = anova(T,'RDS_2 ~ 1 + Alcohol + working_2 + x31_0_0 + x738_2_0 + x21003_2_0','CategoricalFactors',["Alcohol" "x31_0_0" "x738_2_0" "working_2"])
% 
% T = D(D.leader_ever=='never',["Alcohol" "working_2" "RDS_2" "x31_0_0" "x738_2_0" "x21003_2_0"]);
% aov = anova(T,'RDS_2 ~ 1 + Alcohol + working_2 + x31_0_0 + x738_2_0 + x21003_2_0','CategoricalFactors',["Alcohol" "x31_0_0" "x738_2_0" "working_2"])
