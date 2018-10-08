%% %%%% known parameters %%%% %%
subjID = 'P07';

switch subjID 
    case 'P04'
    case 'P05' 
        DataLocation = '/media/mxv796/rds-share/Archive/MICRO/P05/STIM/2016-12-06_10-29-05/';  
    case 'P06'
        DataLocation = '/media/mxv796/rds-share/Archive/MICRO/P06/SPES/2017-03-31_10-56-36/'; 
    case 'P07'
        DataLocation  = '/media/mxv796/rds-share/Archive/MICRO/P07/SPES/2017-05-03_13-22-25/';
    case 'P072'
        DataLocation = '/media/mxv796/rds-share/Archive/MICRO/P07/SPES/2017-05-04_13-53-58/';
    case 'P08'
        DataLocation  = '/media/mxv796/rds-share/Archive/MICRO/P08/SPES/2017-06-06_10-12-13/';
    case 'P082'
        DataLocation = '/media/mxv796/rds-share/Archive/MICRO/P08/SPES/2017-06-07_10-17-19/';        
    case 'P09'
        DataLocation  = '/media/mxv796/rds-share/Archive/MICRO/P09/SPES/2017-08-31_13-10-20/';
end 


% trial-parameters
pre = 3;
post = 3;

%% %%%% Preprocessing %%% %%
%% Read in the Data

[p2d] = DataLocation;
%ReadData        % Reads data: LFP data as CSCdat; Unsorted Spike data as SPKdat; SpikeSorted Data as SortedSPKdat, data always already lowpassfiltered at 300;
readinlfpnofilter % Output: CSCdatNF | Read in data with no filtering

%% 
 %Output: CSCdatintNaNres and CSCdatintLinres | mark trials with databrowser, also resampling to 1000
IEEGfirstround

%% find trials in IEEG and use Macrodefinition on Microdata 
%%
IEEGpreProcessing

%% Reject Artefacts
Data = CSCdatPreProc;
LFPRejectartefactsNoZ % Output: CSCdatIED | Reject infestation of IED

%% Average trials
LFPAvgCond

%% Sort data according to conditions
SingleVariable

LFPSelectChans
LFPSelectedConditions
MUASelectChans
%% no selection goingon
LFPConditionsSplitAllP

%% ChannelOverviewForSelection
ITCplotNew

%% MUAe 
MUAe

%% MUAs
MUAs_Raster
MUAs_ERPChanged

SPKRasterAll

%% Spike Sorting
SUAread

%% Figures
LFPLocalDistalERP
ERPCumSum
FQLocalDistal

%% GA figures
freqanalysisnoCorr
LFPFQCumSumperChanGA
TFRGA

%% Frequency Analysis

FQPrePost

%%
LFPITC

%% 
LFPConditionsLabels

%% Spike Trials
%RemoveSPKart
MUATrialsBulk % Output: SPKTrialsTS | Make trials using LFP specified Trialdefinition

%% Plots
COI = 1;
Data = SPKTrials;
SPKRaster
SPKWav
SPKCC
SPKISI
