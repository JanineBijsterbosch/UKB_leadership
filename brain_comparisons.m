clear all; close all; clc

addpath('/Users/janinebijsterbosch/Dropbox/Matlab/');
load('../Data/Dcleaned_740199.mat')
%D(D.leader_2=="missing",:) = [];
%D(D.match==0,:) = [];

% area:
% Brain_variables = {'x27143_2_0','x27144_2_0','x27145_2_0','x27146_2_0','x27147_2_0','x27148_2_0','x27149_2_0',...
%     'x27150_2_0','x27151_2_0','x27152_2_0','x27153_2_0','x27154_2_0','x27155_2_0','x27156_2_0','x27157_2_0',...
%     'x27158_2_0','x27159_2_0','x27160_2_0','x27161_2_0','x27162_2_0','x27163_2_0','x27164_2_0','x27165_2_0',...
%     'x27166_2_0','x27167_2_0','x27168_2_0','x27169_2_0','x27170_2_0','x27171_2_0','x27172_2_0','x27173_2_0',...
%     'x27236_2_0','x27237_2_0','x27238_2_0','x27239_2_0','x27240_2_0','x27241_2_0','x27242_2_0','x27243_2_0',...
%     'x27244_2_0','x27245_2_0','x27246_2_0','x27247_2_0','x27248_2_0','x27249_2_0','x27250_2_0','x27251_2_0',...
%     'x27252_2_0','x27253_2_0','x27254_2_0','x27255_2_0','x27256_2_0','x27257_2_0','x27258_2_0','x27259_2_0',...
%     'x27260_2_0','x27261_2_0','x27262_2_0','x27263_2_0','x27264_2_0','x27265_2_0','x27266_2_0'};
% Brain_variables_names = {'Lcaudalanteriorcingulate','Lcaudalmiddlefrontal','Lcuneus','Lentorhinal','Lfusiform','Linferiorparietal',...
%     'Linferiortemporal','Listhmuscingulate','Llateraloccipital','Llateralorbitofrontal','Llingual',...
%     'Lmedialorbitofrontal','Lmiddletemporal','Lparahippocampal','Lparacentral','Lparsopercularis',...
%     'Lparsorbitalis','Lparstriangularis','Lpericalcarine','Lpostcentral','Lposteriorcingulate',...
%     'Lprecentral','Lprecuneus','Lrostralanteriorcingulate','Lrostralmiddlefrontal','Lsuperiorfrontal',...
%     'Lsuperiorparietal','Lsuperiortemporal','Lsupramarginal','Ltransversetemporal','Linsula',...
%     'Rcaudalanteriorcingulate','Rcaudalmiddlefrontal','Rcuneus','Rentorhinal','Rfusiform','Rinferiorparietal',...
%     'Rinferiortemporal','Risthmuscingulate','Rlateraloccipital','Rlateralorbitofrontal','Rlingual',...
%     'Rmedialorbitofrontal','Rmiddletemporal','Rparahippocampal','Rparacentral','Rparsopercularis',...
%     'Rparsorbitalis','Rparstriangularis','Rpericalcarine','Rpostcentral','Rposteriorcingulate',...
%     'Rprecentral','Rprecuneus','Rrostralanteriorcingulate','Rrostralmiddlefrontal','Rsuperiorfrontal',...
%     'Rsuperiorparietal','Rsuperiortemporal','Rsupramarginal','Rtransversetemporal','Rinsula',};

% GMV:
Brain_variables = {'x25011_2_0','x25012_2_0','x25013_2_0','x25014_2_0','x25015_2_0','x25016_2_0',...
    'x25017_2_0','x25018_2_0','x25019_2_0','x25020_2_0','x25021_2_0','x25022_2_0','x25023_2_0','x25024_2_0',...
    'x27205_2_0','x27206_2_0','x27207_2_0','x27208_2_0','x27209_2_0','x27210_2_0','x27211_2_0','x27212_2_0',...
    'x27213_2_0','x27214_2_0','x27215_2_0','x27216_2_0','x27217_2_0','x27218_2_0','x27219_2_0','x27220_2_0',...
    'x27221_2_0','x27222_2_0','x27223_2_0','x27224_2_0','x27225_2_0','x27226_2_0','x27227_2_0','x27228_2_0',...
    'x27229_2_0','x27230_2_0','x27231_2_0','x27232_2_0','x27233_2_0','x27234_2_0','x27235_2_0','x27298_2_0',...
    'x27299_2_0','x27300_2_0','x27301_2_0','x27302_2_0','x27303_2_0','x27304_2_0','x27305_2_0','x27306_2_0',...
    'x27307_2_0','x27308_2_0','x27309_2_0','x27310_2_0','x27311_2_0','x27312_2_0','x27313_2_0','x27314_2_0',...
    'x27315_2_0','x27316_2_0','x27317_2_0','x27318_2_0','x27319_2_0','x27320_2_0','x27321_2_0','x27322_2_0',...
    'x27323_2_0','x27324_2_0','x27325_2_0','x27326_2_0','x27327_2_0','x27328_2_0'};
Brain_variables_names = {'Lthalamus','Rthalamus','Lcaudate','Rcaudate','Lputamen','Rputamen','Lpallidum',...
    'Rpallidum','Lhippocampus','Rhippocampus','Lamygdala','Ramygdala','Laccumbens','Raccumbens',...
    'Lcaudalanteriorcingulate','Lcaudalmiddlefrontal','Lcuneus','Lentorhinal','Lfusiform','Linferiorparietal',...
    'Linferiortemporal','Listhmuscingulate','Llateraloccipital','Llateralorbitofrontal','Llingual',...
    'Lmedialorbitofrontal','Lmiddletemporal','Lparahippocampal','Lparacentral','Lparsopercularis',...
    'Lparsorbitalis','Lparstriangularis','Lpericalcarine','Lpostcentral','Lposteriorcingulate',...
    'Lprecentral','Lprecuneus','Lrostralanteriorcingulate','Lrostralmiddlefrontal','Lsuperiorfrontal',...
    'Lsuperiorparietal','Lsuperiortemporal','Lsupramarginal','Ltransversetemporal','Linsula',...
    'Rcaudalanteriorcingulate','Rcaudalmiddlefrontal','Rcuneus','Rentorhinal','Rfusiform','Rinferiorparietal',...
    'Rinferiortemporal','Risthmuscingulate','Rlateraloccipital','Rlateralorbitofrontal','Rlingual',...
    'Rmedialorbitofrontal','Rmiddletemporal','Rparahippocampal','Rparacentral','Rparsopercularis',...
    'Rparsorbitalis','Rparstriangularis','Rpericalcarine','Rpostcentral','Rposteriorcingulate',...
    'Rprecentral','Rprecuneus','Rrostralanteriorcingulate','Rrostralmiddlefrontal','Rsuperiorfrontal',...
    'Rsuperiorparietal','Rsuperiortemporal','Rsupramarginal','Rtransversetemporal','Rinsula',};

for n = 1:length(Brain_variables)
    i = strcmp(D.Properties.VariableNames,Brain_variables{n});
    D.Properties.VariableNames(i==1) = Brain_variables_names(n);
end

Brain_variables_new = {};
for n = 1:length(Brain_variables)
    i = contains(Brain_variables_names,Brain_variables_names{n}(2:end));
    i = find(i==1);
    D.(Brain_variables_names{n}(2:end)) = mean([D.(Brain_variables_names{i(1)}) D.(Brain_variables_names{i(2)})],2);
    i = strcmp(Brain_variables_new,Brain_variables_names{n}(2:end));
    if sum(i)==0
        Brain_variables_new = [Brain_variables_new; Brain_variables_names{n}(2:end)];
    end
end

% Set up all combinations of 6 confound parameters
Covariate_variables = {"x26521_2_0" "x25741_2_0" "x31_0_0" "x21003_2_0" "x738_2_0" "working_2"};
Covariate_newnames = {"brain_volume","head_motion","sex","age","income","employment"};
for n = 1:length(Covariate_variables)
    i = strcmp(D.Properties.VariableNames,Covariate_variables{n});
    D.Properties.VariableNames(i==1) = Covariate_newnames{n};
end
Cicv = [1 0];
Chm = [1 0];
Csex = [1 0];
Cage = [1 0];
Cses = [1 0];
Cret = [1 0];
Cset = combinations(Cicv, Chm, Csex, Cage, Cses, Cret);


ps_leader = nan(length(Brain_variables_new),size(Cset,1));
for n = 1:length(Brain_variables_new)
    fprintf('Running brain variable %d out of %d (%s)\n',n, length(Brain_variables_new), Brain_variables_new{n})
    T = D(:,[Brain_variables_new{n} "leader_ever" "brain_volume" "head_motion" "sex" "age" "income" "employment"]);
    for c = 1:size(Cset,1)
        covs = find(table2array(Cset(c,:))==1);
        
        % Create correct list of categorical variables
        catfact = ["leader_ever"];
        if sum(ismember(covs,3))
            catfact = [catfact "sex"];
        end
        if sum(ismember(covs,5))
            catfact = [catfact "income"];
        end
        if sum(ismember(covs,6))
            catfact = [catfact "employment"];
        end

        % Create correct anova equation
        eq = sprintf('%s ~ 1 + leader_ever', Brain_variables_new{n});
        for i = 1:length(covs)
            eq = sprintf('%s + %s', eq, Covariate_newnames{covs(i)});
        end

        % Run anova and save Bonferroni corrected p-value
        aov = anova(T,eq,'CategoricalFactors',catfact);
        ps_leader(n,c) = aov.stats.pValue(1);%*length(Brain_variables_new);
    end
end
   
% FDR correction across brain measures
for c = 1:size(Cset,1)
    [pthr,pcor,padj] = fdr(ps_leader(:,c));
    ps_leader(:,c) = pcor;
end

ps_thresh = zeros(size(ps_leader)); ps_thresh(ps_leader<0.05) = 1;
figure('units','centimeter','position',[0,0,23,22]);
subplot(5,1,1:4); imagesc(ps_thresh); title('Brain correlates of leadership as a function of covariate control')
set(gca,'ytick',1:length(Brain_variables_new),'yticklabel',Brain_variables_new,'xtick',1:size(Cset,1),'xticklabel',[],'FontSize',8); grid on
subplot(5,1,5); imagesc(table2array(Cset)'); title('Covariates included for each analysis')
set(gca,'ytick',1:length(Covariate_newnames),'yticklabel',Covariate_newnames,'xtick',1:size(Cset,1),'xticklabel',[],'TickLabelInterpreter','None','FontSize',8); grid on        
%colorbar('Location','southoutside')
print(gcf,'../results/brain','-dpng','-r300')

S = sum(ps_thresh,2);
[S,i] = sort(S,'descend');

figure('units','centimeter','position',[0,0,13,11]);
for n = 1:2
    fprintf('%s was significant %d out of %d\n',Brain_variables_new{i(n)},S(n),size(Cset,1))
    T = D(:,[Brain_variables_new{i(n)} "leader_ever" "brain_volume" "head_motion" "sex" "age" "income" "employment"]);
    aov = anova(T,sprintf('%s ~ 1 + leader_ever + brain_volume + head_motion + sex + age + employment', Brain_variables_new{i(n)}),'CategoricalFactors',["leader_ever" "sex" "employment"]);
    subplot(2,1,n); plotComparisons(aov,["leader_ever"]); title(sprintf('%s',Brain_variables_new{i(n)}));
    set(gca,'yticklabel',{'leader','not a leader'}); xlabel('gray matter volume'); 
end
print(gcf,'../results/leadership_gmv','-dpng','-r300')