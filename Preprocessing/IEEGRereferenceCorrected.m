%%
cfg = [];
cfg.channel = [1:8];
Rent = ft_selectdata(cfg, ICdataClean);

cfg = [];
cfg.channel = [9:16];
RAH = ft_selectdata(cfg, ICdataClean);

cfg = [];
cfg.channel = [17:24];
RMH = ft_selectdata(cfg, ICdataClean);

cfg = [];
cfg.channel = [25:32];
RPH = ft_selectdata(cfg, ICdataClean);

cfg = [];
cfg.channel = [33:40];
RMTG = ft_selectdata(cfg, ICdataClean);

cfg = [];
cfg.channel = [41:48];
RAG = ft_selectdata(cfg, ICdataClean);

cfg = [];
cfg.channel = [61:68];
Lent = ft_selectdata(cfg, ICdataClean);

cfg = [];
cfg.channel = [69:76];
LAH = ft_selectdata(cfg, ICdataClean);

cfg = [];
cfg.channel = [77:84];
LMH = ft_selectdata(cfg, ICdataClean);

cfg = [];
cfg.channel = [85:92];
LPH = ft_selectdata(cfg, ICdataClean);

cfg = [];
cfg.channel = [93:100];
LMTG = ft_selectdata(cfg, ICdataClean);

cfg = [];
cfg.channel = [101:108];
LAG = ft_selectdata(cfg, ICdataClean);

%%


for chanidx = 1:length(Rent.label)
    for t = 1 : numel(Rent.trial)
        Rent.trial{t}(chanidx,:) = Rent.trial{t}(chanidx,:) - Rent.trial{t}(5,:);
    end
end

for chanidx = 1:length(RAH.label)
    for t = 1 : numel(RAH.trial)
        RAH.trial{t}(chanidx,:) = RAH.trial{t}(chanidx,:) - RAH.trial{t}(4,:);
    end
end

for chanidx = 1:length(RMH.label)
    for t = 1 : numel(RMH.trial)
        RMH.trial{t}(chanidx,:) = RMH.trial{t}(chanidx,:) - RMH.trial{t}(3,:);
    end
end

for chanidx = 1:length(RPH.label)
    for t = 1 : numel(RPH.trial)
        RPH.trial{t}(chanidx,:) = RPH.trial{t}(chanidx,:) - RPH.trial{t}(3,:);
    end
end

for chanidx = 1:length(RMTG.label)
    for t = 1 : numel(RMTG.trial)
        RMTG.trial{t}(chanidx,:) = RMTG.trial{t}(chanidx,:) - RMTG.trial{t}(1,:);
    end
end

for chanidx = 1:length(RAG.label)
    for t = 1 : numel(RAG.trial)
        RAG.trial{t}(chanidx,:) = RAG.trial{t}(chanidx,:) - RAG.trial{t}(1,:);
    end
end

for chanidx = 1:length(Lent.label)
    for t = 1 : numel(Lent.trial)
        Lent.trial{t}(chanidx,:) = Lent.trial{t}(chanidx,:) - Lent.trial{t}(5,:);
    end
end

for chanidx = 1:length(LAH.label)
    for t = 1 : numel(LAH.trial)
        LAH.trial{t}(chanidx,:) = LAH.trial{t}(chanidx,:) - LAH.trial{t}(4,:);
    end
end

for chanidx = 1:length(LMH.label)
    for t = 1 : numel(LMH.trial)
        LMH.trial{t}(chanidx,:) = LMH.trial{t}(chanidx,:) - LMH.trial{t}(3,:);
    end
end

for chanidx = 1:length(LPH.label)
    for t = 1 : numel(LPH.trial)
        LPH.trial{t}(chanidx,:) = LPH.trial{t}(chanidx,:) - LPH.trial{t}(3,:);
    end
end

for chanidx = 1:length(LMTG.label)
    for t = 1 : numel(LMTG.trial)
        LMTG.trial{t}(chanidx,:) = LMTG.trial{t}(chanidx,:) - LMTG.trial{t}(1,:);
    end
end

for chanidx = 1:length(LAG.label)
    for t = 1 : numel(LAG.trial)
        LAG.trial{t}(chanidx,:) = LAG.trial{t}(chanidx,:) - LAG.trial{t}(1,:);
    end
end


%%

cfg = [];
ICReref = ft_appenddata(cfg,Rent,RAH,RMH,RPH,RMTG,RAG,Lent,LAH,LMH,LPH,LMTG,LAG);


%%
switch subjID 
    case 'P04'
    case 'P05' 
        LocalStimHipp   = [9,10,11,17,18,25,57,58,59,65,66,73];
        DistalStimHipp  = [1:8, 15, 16,20:24, 28:32, 49:56, 63, 64, 68:72, 77:80];    
    case 'P06'
    case 'P07'
    case 'P08'
    case 'P09'
end


%% create the different conditions

ILH = [];
for i = 1:length( LocalStimHipp)
    ILH = [ILH; find(ICReref.trialinfo ==  LocalStimHipp(i))]; 
end

IDH = [];
for i = 1:length(DistalStimHipp)
    IDH = [IDH; find(ICReref.trialinfo == DistalStimHipp(i))]; 
end

%% select the data


cfg = [];
cfg.trials = [ILH'];
cfg.avgoverrpt = 'yes';
ICdatLHipp = ft_selectdata(cfg, ICReref);

cfg = [];
cfg.trials = [IDH'];
cfg.avgoverrpt = 'yes';
ICdatDHipp = ft_selectdata(cfg, ICReref);

%% Cortex

switch subjID 
    case 'P04'
    case 'P05' 
        LocalStimCtx   = [1:8, 15, 16,20:24, 28:32, 49:56, 63, 64, 68:72, 77:80];
        DistalStimCtx= [9,10,11,17,18,25,57,58,59,65,66,73];    
    case 'P06'
    case 'P07'
    case 'P08'
    case 'P09'
end


%% create the different conditions


ILC = [];
for i = 1:length( LocalStimCtx)
    ILC = [ILC; find(ICReref.trialinfo ==  LocalStimCtx(i))]; 
end

IDC = [];
for i = 1:length(DistalStimCtx)
    IDC = [IDC; find(ICReref.trialinfo == DistalStimCtx(i))]; 
end

%% select the data


cfg = [];
cfg.trials = [ILC'];
cfg.avgoverrpt = 'yes';
ICdatLCtx = ft_selectdata(cfg, ICReref);

cfg = [];
cfg.trials = [IDC'];
cfg.avgoverrpt = 'yes';
ICdatDCtx = ft_selectdata(cfg, ICReref);

