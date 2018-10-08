%% Databrowser Mark trials with databrowser

switch subjID 
    case 'P05' 
        DataLocationIC = '/media/mxv796/rds-share/Mircea/Datasaves/Macro/P05/P05_macroIC.mat';  
    case 'P06'
        DataLocationIC = ''; 
    case 'P07'
        DataLocationIC  = '/media/mxv796/rds-share/Mircea/Datasaves/Macro/P07/P07_03_05.mat';
    case 'P072'
        DataLocationIC = '/media/mxv796/rds-share/Mircea/Datasaves/Macro/P07/P07_05_05.mat';
    case 'P08'
        DataLocationIC  = '/media/mxv796/rds-share/Mircea/Datasaves/Macro/P08/0606/P08_06_06.mat';
    case 'P082'
        DataLocationIC = '/media/mxv796/rds-share/Mircea/Datasaves/Macro/P08/0706/P08_07_06.mat';       
    case 'P09'
        DataLocationIC  = '/media/mxv796/rds-share/Mircea/Datasaves/Macro/P09/P9_SPES_Macro.mat';
end 

%% Load the data
load(DataLocationIC)

%% Check whether samples start at 0 or not
if IC.sampleinfo <=2 
    InfoSI = 1;
else 
    InfoSI = 0;
end 

%% For the datasets of participant 7 the channel labels have to be changed
RewriteP07Labels

%% Macro Stimulation sites and Label creation for conditions
findstimsiteNeighMax

%% Crosscorrelate Macro and Micro stimulation trials
LFPlabelIndxHPeak
