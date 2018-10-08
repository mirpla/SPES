% define channels where peaks will be searched in
switch subjID
    case 'P05'
        elec = [2:61, 66:125];
        Neigh = [2:33, 66:97];
        for j = 1:length(elec)
            [pkstimchan{j}, locationspeakstimchan{j}] = findpeaks(IC.trial{1,1}(elec(j),:), 'minPeakHeight', 7000,'MinPeakDistance', 256);
        end
    case 'P07'
        elec = [1:62, 65:116];
        Neigh = [23:62, 65:80, 101:108];
        for j = 1:length(elec)
            [pkstimchan{j}, locationspeakstimchan{j}] = findpeaks(IC.trial{1,1}(elec(j),:), 'minPeakHeight', 7000,'MinPeakDistance', 256);
        end
        
    case 'P072'
        elec = [1:62, 65:116];
        Neigh = [23:62, 65:80, 101:108];
        for j = 1:length(elec)
            [pkstimchan{j}, locationspeakstimchan{j}] = findpeaks(IC.trial{1,1}(elec(j),:), 'minPeakHeight', 7000,'MinPeakDistance', 256);
        end
        
    case 'P08'
        
        elec = [2:107 ];
        Neigh = [2:49];
        for j = 1:length(elec)
            [pkstimchan{j}, locationspeakstimchan{j}] = findpeaks(IC.trial{1,1}(elec(j),:), 'minPeakHeight', 7000,'MinPeakDistance', 256);
        end
        
        case 'P082'
        
        elec = [2:107 ];
        Neigh = [2:49];
        for j = 1:length(elec)
            [pkstimchan{j}, locationspeakstimchan{j}] = findpeaks(IC.trial{1,1}(elec(j),:), 'minPeakHeight', 7000,'MinPeakDistance', 256);
        end
        
    case 'P09'
        Neigh = [2:25, 66:89];
        elec = [2:53, 66:117];
        for j = 1:length(elec)
            [pkstimchan{j}, locationspeakstimchan{j}] = findpeaks(IC.trial{1,1}(elec(j),:), 'minPeakHeight', 5000,'MinPeakDistance', 256);
        end
end



 %% separate peaks from eachother depending on timing
 
 for chanidx = 1:length(locationspeakstimchan) % go through peaks for each channel
     if isempty(locationspeakstimchan{1,chanidx})
         stim{1,chanidx} = [];
     else
         trlidx = 1; % first trial always saved to stim variable
         peakidx = 1;
         stim{1,chanidx}(1,trlidx) = locationspeakstimchan{1,chanidx}(1,peakidx);
         trlidx = trlidx +1;
         for peakidx = 2:length(locationspeakstimchan{1,chanidx}) % cycle throught the different peaks
             
             if locationspeakstimchan{1,chanidx}(1,peakidx) > (locationspeakstimchan{1,chanidx}(1,peakidx-1) + (1*IC.hdr.Fs)) %make sure that peaks belong to different event by being at least 1 second in distance from the previous peak
                 stim{1,chanidx}(1,trlidx) = locationspeakstimchan{1,chanidx}(1,peakidx);
                 trlidx = trlidx+1;
             else
                 
             end
         end
     end
 end
 
 for chanidx = 1:length(IC.label)
    stim{2, chanidx} = IC.label(chanidx, 1); 
 end
 %% remove irrelevant/ empty (has to be changed per Patient)
 
 for i= 1:2
     k=1;
     for j = elec;
         abrstim{i,k} = stim{i,j};
         k=k+1;
     end
 end


%% make a trialmatrix 
i=1;
for j = 1:length(abrstim);
    for k = 1:length(abrstim{1,j})
        stimartfdef(i,1) = abrstim{1,j}(1,k) - 15;
        stimartfdef(i,2) = stimartfdef(i,1) + 60;
        i= i+1;
    end
end
 
stimartfdef = sortrows(stimartfdef);

  
%% remove elements that are not stimulation artefacts
if exist('cfg_ICART11', 'var')
    cfg             =	[];
    cfg.artfctdef.visual.artifact   =  cfg_ICART11.artfctdef.visual.artifact;
    cfg.viewmode	=	'vertical';
    cfg.channel     =   elec;
    cfg_ICART11       =	ft_databrowser(cfg,	IC);
    
    filnam = sprintf('%s_ICART11', subjID);
    save(filnam, 'cfg_ICART11');
    
else
    
    cfg             =	[];
    cfg.artfctdef.visual.artifact   = stimartfdef;
    cfg.viewmode	=	'vertical';
    cfg.channel     =   elec;
    cfg_ICART11       =	ft_databrowser(cfg,	IC);
    
    
    filnam = sprintf('%s_ICART11', subjID);
    save(filnam, 'cfg_ICART11');
end

stimartfdefTemp = [cfg_ICART11.artfctdef.visual.artifact(:,1), cfg_ICART11.artfctdef.visual.artifact(:,2)+200, zeros(length(cfg_ICART11.artfctdef.visual.artifact),1)]; %trialmatrix


%% remove trials from labelling variable

for j = length(abrstim):-1:1
    for k = length(abrstim{1,j}):-1:1
        if any(abrstim{1,j}(1,k) > stimartfdefTemp(:,1)) && any(abrstim{1,j}(1,k) < stimartfdefTemp(:,2))
        else
            abrstim{1,j}(:,k) = [];
            if isempty(abrstim{1,j})
                abrstim{1,j} = [];
            end
        end
    end
end


%% labelling
%create labels for stimulation site

for trlidx = 1:length(stimartfdefTemp)
    i= 1;
    for chanidx = 1:length(abrstim) % go through peaks for each channel
               
        index = isequal(find([abrstim{1,chanidx}] == stimartfdefTemp(trlidx,1)), 1);
        index2 = intersect((find([abrstim{1,chanidx}] < (stimartfdefTemp(trlidx,2)) == 1)),...
                    (find([abrstim{1,chanidx}] > (stimartfdefTemp(trlidx,1)) == 1)) ...
                     );
    
        if index == 1 || isempty(index2) == 0;
            stimartlabel(i,trlidx) = abrstim{2,chanidx};
            i = i +1 ;
        end 
    end
end

%remove empty labels and make it strings
for i=1:size(stimartlabel,2)
    for j = 1:size(stimartlabel, 1)
        stimfirstlabels{j,i} = char(stimartlabel{j,i});
    end
end

% Remove The noisy Channel
if strcmp(subjID,'P05')
    for i=1:size(stimartlabel,2)
        for j = 1:size(stimartlabel, 1)
            if strcmp(char(stimfirstlabels{j,i}), char(stimartlabel{3,17})); % second element changes on participant
                stimfirstlabels{j,i} = stimfirstlabels{j+1,i};
            end
        end
    end
end
if strcmp(subjID,'P09')
    for i=1:size(stimartlabel,2)
        for j = 1:size(stimartlabel, 1)
            if strcmp(char(stimfirstlabels{j,i}), char(stimartlabel{1,2})); % second element changes on participant
                stimfirstlabels{j,i} = stimfirstlabels{j+1,i};
            end
        end
    end
end
%%

cfg = [];
cfg.continuous = 'yes';
cfg.trl = stimartfdefTemp;
[dumCSC] = ft_redefinetrial( cfg, IC); % creation of dummy variable defined according to above trl

cfg = [];
cfg.channel = [Neigh];
dumCSC = ft_selectdata(cfg, dumCSC);

pkrun1 = zeros(length(dumCSC.label), length(cfg_ICART11.artfctdef.visual.artifact));
locationsrun1 = zeros(length(dumCSC.label), length(cfg_ICART11.artfctdef.visual.artifact));
for i=1:length(stimartfdefTemp)
    dumCSC.trial{1,i} = abs(cell2mat(dumCSC.trial(1,i)));
    for j = 1:length(dumCSC.label) % find peak individually for each channel
        [pk, location] = findpeaks(dumCSC.trial{1,i}(j,:), 'SortStr', 'descend');       
        if isempty(pk)
            pkrun1(j,i) = 0 ;
            locationsrun1(j,i) = 0;
        else 
            pkrun1(j,i) = pk(1,1);
            locationsrun1(j,i) = location(1,1);
        end       
    end
end



Fs = round(IC.fsample);
pknum = 8;
pre = Fs*3;
post = Fs*3;
artfdefnewtrl = [];
dumlabels(1:length(dumCSC.label),1) = strings();
prevchan.stim.idx   = zeros(size(stimartfdefTemp,1),pknum);
prevchan.stim.label = strings(size(stimartfdefTemp,1),pknum);
 

for it = 1:size(stimartfdefTemp,1)
    %locationsNozero = locationsrun1(locationsrun1(:,it)>100,it);
    if isempty(locationsrun1(:,it))
        locationsrun1(:,it) = 0; 
    end 
    for i = 1:length(dumCSC.label)
        dumlabels(i,1) = [dumCSC.label{i,1}];
    end 
    
    % find channel with highest peak after the stimulation channels 
    [highestpeakchan]       = maxk(pkrun1(:,it),pknum); %find the 5 highest peaks 
    highestpeakIDX          = min(find(highestpeakchan<8500)); % pick nonsaturated peak
    prevchan.idx(it,1)      = find(pkrun1(:,it) == highestpeakchan(highestpeakIDX)); %save channel index of aforementioned peak
    prevchan.label(it,1)    = dumlabels(prevchan.idx(it,1), 1); % save label of aforementioned channel
    tempk = find(pkrun1(:,it) >= 8500)';        % find labels saturated channels / where stimulation took place
    pknumdiff = pknum - length(tempk);          % look for how many zeroes have to be fileld in
    prevchan.stim.idx(it,:) = [tempk, zeros(1,pknumdiff)]; % save indices of saturated channels
    prevchan.stim.label(it,:)= [dumlabels(tempk)' strings(1,pknumdiff)]; % save labels saturated channels
    
    %prevchanidx = find(strcmp(dumlabels(highestpeakloc), dumlabels(:)));
    
    
    if isempty(prevchan.idx)
        LocMed = mode(locationsrun1(:,it))-1;
    else 
        LocMed = mode(locationsrun1(:,it))-1; %locationsrun1(prevchan.idx(it,1), it)-1;
    end 
    
    artfdefnewtrl(it,:) = [stimartfdefTemp(it,1)+LocMed-(pre), stimartfdefTemp(it,1)+LocMed+(post), (-pre)];
end
prevchan.OriLabel = dumlabels;

clear dumCSC

%%
cfg = [];
cfg.continuous = 'yes';
cfg.trl = artfdefnewtrl;
[dumCSC] = ft_redefinetrial( cfg, IC); % creation of dummy variable defined according to above trl


%% Ensure sample info starts at 1
%if exist('stimartfdefRej','var')==0
if exist('rejMet','var')
    cfg             = [];
    cfg.method      = 'summary';
    ICtrials    = ft_rejectvisual(cfg, dumCSC);
else
    
    cfg             =	[];
    %cfg.artfctdef.visual.artifact   =   stimartfdef;
    cfg.viewmode	=	'vertical';
    cfg.channel     =  elec;
    cfg_ICART2       = ft_databrowser(cfg,	dumCSC);
    
    cfg_ICART2.artfctdef.reject = 'complete';
    [ICtrials] = ft_rejectartifact(cfg_ICART2,dumCSC);
    
end



%% Remove the unaligned trials from the trl matrix
finaltrials = zeros(length(artfdefnewtrl)-size(cfg_ICART2.artfctdef.visual.artifact,1), 3);
if isempty(cfg_ICART2.artfctdef.visual.artifact)
    stimartfdefRej = artfdefnewtrl;
else
    dumdef =  cfg_ICART2.artfctdef.visual.artifact;
    j = 1;
    k = 1;
    for i = 1:length(artfdefnewtrl)
        if j > size(cfg_ICART2.artfctdef.visual.artifact,1)
            finaltrials(k:end,:) = artfdefnewtrl(i:end,:);
            break
        elseif (dumdef(j,1) > artfdefnewtrl(i,1)) &&  (dumdef(j,2) < artfdefnewtrl(i,2))
            j = j+1;
                        
        else
            finaltrials(k,:) = artfdefnewtrl(i,:);
            k = k+1;
        end
    end
    
    
    
    stimartfdefRej = finaltrials ;
end
save(['FirstRejectedMacro_' subjID '.mat'],	'stimartfdefRej', '-v7.3');
%end 

%% Indices for Rejected trials
rej = input('array of rejected trials');

%% find indices for new definition

%stimartRejIdxs =  find(ismember(stimartfdef(:,1), stimartfdefRej(:,1))); % indices of trials left after rejection



%% add channel names logical

%P07

% select only present

%stimfirstlabels(:, rej)=[]; 
% AH6idx = find(cellfun(@(x) strcmp(x,stimfirstlabels{1,2}), stimfirstlabels));
% strrep(stimfirstlabels,stimfirstlabels{1,2},'sly')
% stimfirstlabels(AH6idx) = 'PL';
% 
% table(stimfirstlabels, 7, 364);


%% preallocate list of possible conditions (list of possible labels

ListLabels

%% remove labels of conditions that were removed 
if any(subjID ~= 'P07' )
    stimfirstlabels(:,rej) = [];
end 

conditionlist = unique(stimfirstlabels(1,:));

%% make trial matrices 
for i= 1:length(conditionlist)
   conditionidxs{1,i} = find(strcmp(stimfirstlabels(1,:), char(conditionlist(1,i))));
end

%% Make variable that contains all information of label and indexes 

StimSiteInfo.TrialLabels = stimfirstlabels;
StimSiteInfo.Indices = conditionidxs;
StimSiteInfo.Labels = conditionlist;


filnam = sprintf('%s_StimInfo', subjID);
save(filnam, 'StimSiteInfo');

%%


filnam = sprintf('%s_ICtrials', subjID);
save(filnam, 'ICtrials','-v7.3');

%%
filnam = sprintf('%s_MacroStimRej', subjID);
save(filnam, 'stimartfdefRej','rej','artfdefnewtrl');


%%

clear IC 
clear dumCSC
