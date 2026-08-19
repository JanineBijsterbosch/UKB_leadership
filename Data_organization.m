clear all; close all; clc

Read_data

% Set negative values to nan
D = standardizeMissing(D,{-1 -3});

% Remove participants with no job information
D.jobinfo(~isnan(D.x20277_0_0)) = 1;
D.jobinfo(~isnan(D.x20277_2_0)) = 2;
D.jobinfo(~isnan(D.x22617_0_0)) = -1;
D.jobinfo(D.x20277_0_0==0) = 0;
D.jobinfo(D.x20277_2_0==0) = 0;
D.jobinfo(D.x22617_0_0==0) = 0;
D(D.jobinfo==0,:) = [];

% Calculate depression score
D.RDS_2 = D.x2050_2_0 + D.x2060_2_0 + D.x2070_2_0 + D.x2080_2_0;
%D(isnan(D.RDS_2),:) = [];

% load and clean managing demands reference table
Verify_managing_demands

% Add job information 
for s = 1:size(D,1)
    if ~isnan(D.x20277_0_0(s))
        i = find(jobs.coding==D.x20277_0_0(s));
        if i
            D.jobaccuracy_0(s) = jobs.match_confidence(i);
            D.managingdemands_0(s) = jobs.managing_demand_score(i);
            D.managingdemands_0_parent1(s) = jobs.managing_deman_score_parent1(i);
            D.managingdemands_0_parent2(s) = jobs.managing_deman_score_parent2(i);
            D.managingdemands_0_parent3(s) = jobs.managing_deman_score_parent3(i);
            D.leader_0(s) = jobs.leadership(i);
        end
    else 
        D.jobaccuracy_0(s) = NaN;
        D.managingdemands_0(s) = NaN;
        D.managingdemands_0_parent1(s) = NaN;
        D.managingdemands_0_parent2(s) = NaN;
        D.managingdemands_0_parent3(s) = NaN;
        D.leader_0(s) = categorical(cellstr('missing'));
    end
    if ~isnan(D.x20277_2_0(s))
        i = find(jobs.coding==D.x20277_2_0(s));
        if i
            D.jobaccuracy_2(s) = jobs.match_confidence(i);
            D.managingdemands_2(s) = jobs.managing_demand_score(i);
            D.managingdemands_2_parent1(s) = jobs.managing_deman_score_parent1(i);
            D.managingdemands_2_parent2(s) = jobs.managing_deman_score_parent2(i);
            D.managingdemands_2_parent3(s) = jobs.managing_deman_score_parent3(i);
            D.leader_2(s) = jobs.leadership(i);
        end
    else 
        D.jobaccuracy_2(s) = NaN;
        D.managingdemands_2(s) = NaN;
        D.managingdemands_2_parent1(s) = NaN;
        D.managingdemands_2_parent2(s) = NaN;
        D.managingdemands_2_parent3(s) = NaN;
        D.leader_2(s) = categorical(cellstr('missing'));
    end
    if ~isnan(D.x22617_0_0(s))
        i = find(jobs.coding==D.x22617_0_0(s));
        if i
            D.jobaccuracy_past(s) = jobs.match_confidence(i);
            D.managingdemands_past(s) = jobs.managing_demand_score(i);
            D.managingdemands_past_parent1(s) = jobs.managing_deman_score_parent1(i);
            D.managingdemands_past_parent2(s) = jobs.managing_deman_score_parent2(i);
            D.managingdemands_past_parent3(s) = jobs.managing_deman_score_parent3(i);
            D.leader_past(s) = jobs.leadership(i);
        end
    else 
        D.jobaccuracy_past(s) = NaN;
        D.managingdemands_past(s) = NaN;
        D.managingdemands_past_parent1(s) = NaN;
        D.managingdemands_past_parent2(s) = NaN;
        D.managingdemands_past_parent3(s) = NaN;
        D.leader_past(s) = categorical(cellstr('missing'));
    end
end

% leader integrating all timepoints
D.leader_all = categorical(nan(size(D,1),1));
D.leader_all(D.leader_2 == 'Leadership' & D.leader_0 ~= 'Leadership' & D.leader_past ~= 'Leadership') = 'new_leader';
D.leader_all(D.leader_2 == 'Non-leadership' & D.leader_0 ~= 'Non-leadership' & D.leader_past ~= 'Non-leadership') = 'new_nonleader';
D.leader_all(D.leader_2 == 'Leadership' & D.leader_0 == 'Leadership' & D.leader_past == 'Leadership') = 'always_leader';
D.leader_all(D.leader_2 == 'Leadership' & D.leader_0 == 'missing' & D.leader_past == 'Leadership') = 'always_leader';
D.leader_all(D.leader_2 == 'Leadership' & D.leader_0 == 'Leadership' & D.leader_past == 'missing') = 'always_leader';
D.leader_all(D.leader_2 == 'Non-leadership' & D.leader_0 == 'Non-leadership' & D.leader_past == 'Non-leadership') = 'always_nonleader';
D.leader_all(D.leader_2 == 'Non-leadership' & D.leader_0 == 'missing' & D.leader_past == 'Non-leadership') = 'always_nonleader';
D.leader_all(D.leader_2 == 'Non-leadership' & D.leader_0 == 'Non-leadership' & D.leader_past == 'missing') = 'always_nonleader';
D.leader_all(D.leader_2 == 'missing' & D.leader_0 == 'Leadership') = 'retired_leader';
D.leader_all(D.leader_2 == 'missing' & D.leader_past == 'Leadership') = 'retired_leader';
D.leader_all(D.leader_2 == 'missing' & D.leader_0 == 'Non-leadership') = 'retired_nonleader';
D.leader_all(D.leader_2 == 'missing' & D.leader_past == 'Non-leadership') = 'retired_nonleader';
summary(D.leader_all)

% leader ever/never
D.leader_ever = categorical(nan(size(D,1),1));
D.leader_ever(D.leader_past == "Non-leadership") = 'never';
D.leader_ever(D.leader_0 == "Non-leadership") = 'never';
D.leader_ever(D.leader_2 == "Non-leadership") = 'never';
D.leader_ever(D.leader_past == "Leadership") = 'leader';
D.leader_ever(D.leader_0 == "Leadership") = 'leader';
D.leader_ever(D.leader_2 == "Leadership") = 'leader';

% Currently working or not
D.working_2 = categorical(nan(size(D,1),1));
D.working_2(D.x4537_2_0==7) = 'no';
D.working_2(D.x4537_2_0~=7) = 'yes';

% encode bipolar status
ever = zeros(size(D,1),1); duration = zeros(size(D,1),1); symptoms = zeros(size(D,1),1);
ever(D.x4642_2_0 == 1) = 1;
ever(D.x4653_2_0 == 1) = 1;
symptoms(D.x6156_2_0==15) = 1;
duration(D.x5663_2_0>=1) = 1;
B = ever+symptoms+duration;
D.bipolar(B==3) = 1;
D.bipolar(isnan(D.x4642_2_0)) = nan;
D.bipolar(isnan(D.x4653_2_0)) = nan;
clear ever symptoms duration B

% encode depression status
ever = zeros(size(D,1),1); duration = zeros(size(D,1),1); severity = zeros(size(D,1),1);  episodes = zeros(size(D,1),1);
ever(D.x4598_2_0 == 1) = 1;
duration(D.x4609_2_0>=2) = 1;
episodes(D.x4620_2_0>=1) = 1;
severity(D.x2090_2_0==1) = 1;
severity(D.x2100_2_0==1) = 1;
B = ever+severity+duration+episodes;
D.MDD(B==4) = 1;
ever = zeros(size(D,1),1); duration = zeros(size(D,1),1); severity = zeros(size(D,1),1);  episodes = zeros(size(D,1),1);
ever(D.x4631_2_0 == 1) = 1;
duration(D.x5375_2_0>=2) = 1;
episodes(D.x5386_2_0>=1) = 1;
severity(D.x2090_2_0==1) = 1;
severity(D.x2100_2_0==1) = 1;
B = ever+severity+duration+episodes;
D.MDD(B==4) = 1;
D.MDD(isnan(D.x4598_2_0)) = nan;
D.MDD(isnan(D.x4631_2_0)) = nan;
clear ever duration severity B

% Create neuroticism
D.N = D.x1920_2_0 + D.x1930_2_0 + D.x1940_2_0 + D.x1950_2_0 + D.x1960_2_0 + D.x1970_2_0...
    + D.x1980_2_0 + D.x1990_2_0 + D.x2000_2_0 + D.x2010_2_0 + D.x2020_2_0 + D.x2030_2_0;

% Remove subjects with missing data for key variables
D(isnan(D.x27328_2_0),:) = []; % Brain data 
%D(isnan(D.x5674_2_0),:) = []; % Manic symptoms
D(isnan(D.RDS_2),:) = [];

fprintf('N=%d, age %2.2f (SD %2.2f), percent male %2.2f\n',size(D,1),mean(D.x21003_2_0),std(D.x21003_2_0),sum(D.x31_0_0)/size(D,1)*100);
i = find(D.leader_ever=='leader' & D.working_2=='yes');
fprintf('leaders employed: N=%d, age %2.2f (SD %2.2f), percent male %2.2f\n',length(i),mean(D.x21003_2_0(i)),std(D.x21003_2_0(i)),sum(D.x31_0_0(i))/length(i)*100);
i = find(D.leader_ever=='leader' & D.working_2=='no');
fprintf('leaders not employed: N=%d, age %2.2f (SD %2.2f), percent male %2.2f\n',length(i),mean(D.x21003_2_0(i)),std(D.x21003_2_0(i)),sum(D.x31_0_0(i))/length(i)*100);
i = find(D.leader_ever=='never' & D.working_2=='yes');
fprintf('non-leaders employed: N=%d, age %2.2f (SD %2.2f), percent male %2.2f\n',length(i),mean(D.x21003_2_0(i)),std(D.x21003_2_0(i)),sum(D.x31_0_0(i))/length(i)*100);
i = find(D.leader_ever=='never' & D.working_2=='no');
fprintf('non-leaders not employed: N=%d, age %2.2f (SD %2.2f), percent male %2.2f\n',length(i),mean(D.x21003_2_0(i)),std(D.x21003_2_0(i)),sum(D.x31_0_0(i))/length(i)*100);

% Match leaders to leaders on age, sex, and income
Dlead = D(D.leader_2=="Leadership",["eid" "x21003_2_0" "x31_0_0" "x738_2_0"]);
Dnolead = D(D.leader_2=="Non-leadership",["eid" "x21003_2_0" "x31_0_0" "x738_2_0"]);
% Permute both matrices to avoid order effects
p = randperm(size(Dlead,1),size(Dlead,1)); Dlead = Dlead(p,:);
p = randperm(size(Dnolead,1),size(Dnolead,1)); Dnolead = Dnolead(p,:);
for s = 1:size(Dlead,1)
    i1 = find(Dnolead.x31_0_0==Dlead.x31_0_0(s));
    i2 = find(Dnolead.x738_2_0==Dlead.x738_2_0(s));
    i3 = find(Dnolead.x21003_2_0==Dlead.x21003_2_0(s));
    %i3 = find(abs(Dnolead.x21003_2_0-Dlead.x21003_2_0(s))<=5);
    if i1
        if i2
            if i3
                i = intersect(i1,i2); i = intersect(i,i3);
                if i
                    Dlead.match(s) = Dnolead.eid(i(1));
                    Dlead.agematch(s) = Dnolead.x21003_2_0(i(1));
                    Dlead.sexmatch(s) = Dnolead.x31_0_0(i(1));
                    Dlead.incomematch(s) = Dnolead.x738_2_0(i(1));
                    D.match(D.eid==Dlead.eid(s)) = 1;
                    D.match(D.eid==Dnolead.eid(i(1))) = 1;
                    Dnolead(i(1),:) = [];
                end
            end
        end
    end
end

% Save output
save(sprintf('../Data/Dcleaned_%d.mat',today),'D')
fprintf('NOTE: make sure to update scrpts for the new data file: ../Data/Dcleaned_%d.mat\n',today);