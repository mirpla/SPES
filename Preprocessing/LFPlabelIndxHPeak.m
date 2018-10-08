 %% crosscorrlelate stim times
Res = 10;
if InfoSI == 1;
    numer(:,1) = (stimartfdefRej(:,1)+IC.sampleinfoOld(1,1));
elseif InfoSI == 0; 
    numer(:,1) = stimartfdefRej(:,1);
end 

ccstimdefMacro = (numer/IC.fsample)';
ccstimdefMicro = ((newtrl(:,1) - newtrl(:,3))/Fs)';


ccstimdefMacroZeros = zeros(1, round(max(ccstimdefMacro)*Res));
ccstimdefMicroZeros = zeros(1, round(max(ccstimdefMicro)*Res));


j = 1;
for i= 1:length(ccstimdefMacroZeros)
    if i == round(ccstimdefMacro(1,j)*Res);
        ccstimdefMacroZeros(1,i) =  1;
        j = j+1;
    end
end 

j = 1;
for i= 1:length(ccstimdefMicroZeros)
    if i == round(ccstimdefMicro(1,j)*Res);
        ccstimdefMicroZeros(1,i) =  1;
        j = j+1;
    end
end

%% pad with zeros so that alignment works better
if length(ccstimdefMicroZeros) > length(ccstimdefMacroZeros)
    
    lengdiff = length(ccstimdefMicroZeros)-length(ccstimdefMacroZeros);
    ccstimdefMacroZeros = [zeros(1, lengdiff), ccstimdefMacroZeros];

elseif length(ccstimdefMicroZeros) < length(ccstimdefMacroZeros)

    lengdiff = length(ccstimdefMacroZeros)-length(ccstimdefMicroZeros);
    ccstimdefMicroZeros = [zeros(1, lengdiff), ccstimdefMicroZeros];

else 
end



%% Crosscorrelation

[acor, lag] = xcorr(ccstimdefMacroZeros, ccstimdefMicroZeros);

[~, I] = max(abs(acor));
lagdiff = lag(I);

figure
plot(lag, acor)
a1 = gca;
a1.XTick = sort([lagdiff]);


%% align
% figure
% plot(ccstimdefMacroZeros)
% figure
% plot(ccstimdefMicroZeros)

if lagdiff < 0 
    alMacro = [zeros(1, -lagdiff), ccstimdefMacroZeros];
    alMicro = [ccstimdefMicroZeros, zeros(1, -lagdiff)];
    
elseif lagdiff > 0 
    alMacro = [ccstimdefMacroZeros, zeros(1, lagdiff)];
    alMicro = [zeros(1, lagdiff), ccstimdefMicroZeros];
elseif lagdiff == 0
    alMicro = ccstimdefMicroZeros;
    alMacro = ccstimdefMacroZeros;
else 
    disp('ERROR lag is not a real value above below or equal to 0');
end

%% turn macro definition into new micro definition moved by alignment
temptrl = [];
newMicroRTrl = [((numer/IC.fsample) - lengdiff/Res - lagdiff/Res) * Fs];
temptrl = [round(newMicroRTrl(:,1)-(Fs/Res)*3), round(newMicroRTrl(:,1)+(Fs/Res)*2), zeros(length(newMicroRTrl),1)]; %trialmatrix

removeRows = temptrl(:,1)<0;
temptrl(removeRows,:) = [];


cfg = [];
cfg.continuous = 'yes';
cfg.trl = temptrl;
[dumCSC] = ft_redefinetrial(cfg, CSCdatNF); % creation of dummy variable defined according to above trl

pk = zeros(length(dumCSC.label), length(temptrl));
locations = zeros(length(dumCSC.label), length(temptrl));
for i=1:length(temptrl);
    dumCSC.trial{1,i} = abs(cell2mat(dumCSC.trial(1,i)));
    for j = 1:length(dumCSC.label) % find peak individually for each channel
        
        [pk, locations] = findpeaks(dumCSC.trial{1,i}(j,:), 'SortStr', 'descend');
        if isempty(pk)
            pkM(j,i) = 0 ;
            locationsM(j,i) = 0;
        else
            pkM(j,i) = pk(1,1);
            locationsM(j,i) = locations(1,1);
            
        end
    end
end

%% determine what electrodes are at stimulation ? still think about it


%%
Fs = 32e3;
pre = Fs*3;
post = Fs*3;
newMicroTrl = [];
for it = 1:size(temptrl,1);
    locationsNozero = locationsM(locationsM(:,it)>100,it);
    if isempty(locationsNozero)
        locationsNozero = 0; 
    end 
    
   
    
    LocMed = mode(locationsNozero)-1;
    
    newMicroTrl(it,:) = [temptrl(it,1)+LocMed-(pre) temptrl(it,1)+LocMed+(post) (-pre)];
end

%%

for  i= 1:length(StimSiteInfo.TrialLabels)
    codelabels(i,1) = find(strcmp(StimSiteInfo.TrialLabels(1,i), char(StimSiteInfo.Labels)));
end

if any(removeRows)==1  %make sure that the removal of negative elements occurs for the labels too
    removeLabels = length(codelabels) - length(temptrl);
    codelabelsZ = codelabels;
    codelabelsZ(1:removeLabels,:) = []; 
end

pre = Fs*3;
post = Fs*3;
newMTrl = [];
j = 1;
for it = 1:size(newMicroTrl,1);
    newMTrl(it,:) = [round(newMicroTrl(it,1)) round(newMicroTrl(it,2)) (-pre) codelabels(it+sum(removeRows(:,1)),1)];       
end;

%%

cfg = [];
cfg.continuous = 'yes';
cfg.trl = newMTrl;

[newdumCSC] = ft_redefinetrial( cfg, CSCdatNF); % creation of dummy variable defined according to above trl


%% reverse changes so that labels  and trials can translate back to originals


cfg = [];
cfg.viewmode = 'vertical';
cfg = ft_databrowser(cfg, newdumCSC);

cfg.artfctdef.reject = 'complete';
redCSCdat = ft_rejectartifact(cfg,newdumCSC);
deftrial = redCSCdat.cfg.trl;

%%
clear CSCdatNF

if exist('CSCdatSPKint', 'var')
else
    SpkIntFil = sprintf(['/media/mxv796/rds-share/Mircea/Datasaves/Micro/%s/%s_Base.mat'], subjID,subjID);
    load(SpkIntFil, 'CSCdatSPKint')
end 
%% Quick repeated
% 
% cfg          = [];
% cfg.method   = 'summary';
% redCSCdat       = ft_rejectvisual(cfg,newdumCSC); 


%% 

cfg = [];
cfg.continuous = 'yes';
cfg.trl = newMTrl;

[CSCdatIntNaN] = ft_redefinetrial( cfg, CSCdatSPKint); % creation of dummy variable defined according to above trl
clear  CSCdatSPKint

filnam = sprintf('%s_trlMatrixes', subjID);
save(filnam, 'newMTrl', 'newMicroTrl', 'newMicroRTrl','deftrial');

%% Lowpass filter
cfg = [];
cfg.lpfilter = 'yes';
cfg.lpfreq = 300;
cfg.lpfilttype = 'fir';
cfg.demean = 'yes';
cfg.dftfilter = 'yes';
CSCdatintLinpre = ft_preprocessing(cfg, CSCdatIntNaN);
% CSCdatintLinpre.trialLinNoise = CSCdatintLinpre.trial;
% 
% for trls = 1:length(CSCdatintLinpre.trial)
%     for chans = 1:length(CSCdatintLinpre.label)
%         CSCdatintLinpre.trial{1,trls}(chans,:) = ft_preproc_dftfilter(CSCdatintLinpre.trialLinNoise{1,trls}(chans,:), 32000, [50, 100, 150], 'Flreplace', 'zero');
%     end
% end

clear CSCdatIntNaN

%% Resampling of data

cfg = [];
cfg.resamplefs = 1e3;
%cfg.detrend = 'yes';
cfg.demean = 'yes';
[CSCdatintLinres] = ft_resampledata( cfg, CSCdatintLinpre);
clear CSCdatintLinpre

%% Cut the artifact out

precut = 0.02 *CSCdatintLinres.fsample; % how many ms cut before stimulus onset
postcut = 0.024 * CSCdatintLinres.fsample;

for i = 0:length(CSCdatintLinres.trial)-1
    ArtArray(i+1,:) = [((3.001*CSCdatintLinres.fsample)- precut)+(i*6.001*CSCdatintLinres.fsample),  ((3.001*CSCdatintLinres.fsample)+ postcut) + (i*6.001*CSCdatintLinres.fsample)];
end 

cfg = [];
cfg.artfctdef.visual.artifact =  ArtArray;
cfg.artfctdef.reject = 'nan';
CSCdatPreProc = ft_rejectartifact(cfg, CSCdatintLinres);


clear CSCdatintLinres


%%

filnam = sprintf('LFP_IntL10T_%s', subjID);
save(filnam, 'CSCdatPreProc');



%% free up space
clear redCSCdat
clear dumCSC
clear newdumCSC
clear CSCdatIntNaN
clear CSCdatintLinpre
clear CSCdatintLin
clear CSCdatNF
clear CSCdatSPKint