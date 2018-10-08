FieldSelection(1) = 1; %timestamps
FieldSelection(2) = 0; %Channel Numbers
FieldSelection(3) = 0; %Sample Frequency
FieldSelection(4) = 0; %Number of Valid Samples
FieldSelection(5) = 1; %Samples
ExtractHeader = 1;
ExtractMode = 1; % 1 = extract all samples
ModeArray = [];


[CSCfiles] = dir([p2d,'*.ncs']);


[dum1] = cell(1,length(CSCfiles));

for it = 1:length(CSCfiles)
    chanLab = CSCfiles(it).name;
    chanLab(regexp(chanLab,'_')) = [];
    chanLab(regexp(chanLab,'CSC'):regexp(chanLab,'CSC')+2) = [];
    chanLab(regexp(chanLab,'.ncs'):end) = [];
    
    [timestampsCSC, dataSamplesCSC, hdrCSC] = Nlx2MatCSC_v3([p2d, CSCfiles(it).name], FieldSelection, ExtractHeader, ExtractMode, []);
    
    chck = regexp(hdrCSC, 'ADBitVolts');
    selIdx = [];
    for jt = 1:length(chck);
        selIdx(jt) = ~isempty(chck{jt});
    end
    selIdx = find(selIdx~=0);
    scalef = str2double(hdrCSC{selIdx} (min(regexp(hdrCSC{selIdx},'\d')):end));
    
    chck = regexp(hdrCSC, 'SamplingFrequency');
    selIdx = [];
    for jt = 1:length(chck);
        selIdx(jt) = ~isempty(chck{jt});
    end
    selIdx = find(selIdx~=0);
    Fs = str2double(hdrCSC{selIdx}(min(regexp(hdrCSC{selIdx},'\d')):end));
    
    par = set_parameters_Bham(Fs); %can be a sctript of own design if special requests for specific parameters
    [TimeStampPerSample] = 1/Fs*1e6;
    
    dataSamplesCSC = double(dataSamplesCSC(:))'; %flattening by applying scaling factor
    dataSamplesCSC = dataSamplesCSC.*scalef.*1e6;
    
    [CSCTime] = 0:1/Fs:(length(dataSamplesCSC)-1)/Fs;
    
    %timevector of CSCtime
    [SPKTime] = uint64(timestampsCSC(1):TimeStampPerSample:timestampsCSC(1)+(length(dataSamplesCSC)-1)*TimeStampPerSample);
    
    %% Spikedetection without Sorting
    [~,spikeWaveforms1,thr1,spikeTimestamps1,noise_std_detect,noise_std_sorted] = amp_detect(dataSamplesCSC, par);

    n = size(spikeWaveforms1,2);
    wft = linspace(0,(n-1)/Fs,n);
    
    dum3{it} = [];
    dum3{it}.hdr = hdrCSC;
    dum3{it}.label = {['sig_',chanLab,'_all_wvf']};
    dum3{it}.waveform{1}(1,:,:) = spikeWaveforms1';
    dum3{it}.timestamp{1} = SPKTime(spikeTimestamps1);
    dum3{it}.unit{1} = zeros(1, length(spikeTimestamps1));
    dum3{it}.waveformdimord = '{chan}_lead_time_spike';
    dum3{it}.waveformtime = wft;
    

    dum1{it} = [];
    dum1{it}.trial{1} = dataSamplesCSC;
    dum1{it}.time{1}  = CSCTime;
    dum1{it}.label    = {chanLab};
    dum1{it}.cfg.hdr  = hdrCSC;
    dum1{it}.fsample  = Fs;
    
    [dataSamplesCSC] = interpLFP(dataSamplesCSC, spikeTimestamps1, [0.002 0.006], Fs, 'linear');
    
    %LFP data structure
    dum2{it} = [];
    dum2{it}.trial{1} = dataSamplesCSC;
    dum2{it}.time{1}  = CSCTime;
    dum2{it}.label    = {chanLab};
    dum2{it}.cfg.hdr  = hdrCSC;
    dum2{it}.fsample  = Fs;
end
[CSCdatNF] = ft_appenddata ( [], dum1{:} );
clear dum1
[CSCdatSPKint] = ft_appenddata( [], dum2{:} );
clear dum2
[SPKdat] = ft_appendspike( [], dum3{:} );
clear dum3

clear CSCfiles dataSamplesCSC timestampsCSC spikeWaveforms spikeTimestamps1 CSCTime ExtractHeader ExtractMode FieldSelection hdrCSC it jt ModeArray n par spikeWaveforms1 wft

save([subjID, '_Base.mat'], 'CSCdatNF', 'CSCdatSPKint', 'SPKdat', '-v7.3')