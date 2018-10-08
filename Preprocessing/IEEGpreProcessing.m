%% preprocessing with filtering for noise etc (probably remove padding and baseline window)

cfg = [];
cfg.demean			=	'yes';
%cfg.baselinewindow	=	'all';
cfg.lpfilter		=	'yes';
cfg.lpfreq			=	300;
%cfg.padding        =	2;
%cfg.padtype		=	'data';
cfg.dftfilter       = 'yes';

ICpreproc	=	ft_preprocessing(cfg, ICtrials);



%% Remove uninteresting channels
cfg = [];
switch subjID
    case 'P07' 
        cfg.channel = [1:62,65:116];
    case 'P072'
        cfg.channel = [1:62,65:116];
    case 'P08'
        cfg.channel = [2:77,86:107];
    case 'P082'
        
    case 'P09'
        
end 
ICdata = ft_selectdata(cfg, ICpreproc);

%%
save([subjID, '_ICdata.mat'],	'ICdata', '-v7.3');

%% Artifact rejection

cfg             =	[];
cfg.viewmode	=	'vertical';
cfg_ICART       =	ft_databrowser(cfg,	ICdata);
 

cfg_ICART.artfctdef.reject = 'complete';
[ICdataArt] = ft_rejectartifact(cfg_ICART,ICdata);

cfg             = [];
cfg.method      = 'channel';
ICdataCleana     = ft_rejectvisual(cfg, ICdataArt);

%% remove artefact of stimulation
%% P07 0505 interpolation doesnt WORK>.....
fsample =  round(ICdataCleana.fsample);

precut = 0.02 *fsample; % how many ms cut before stimulus onset
postcut = 0.024 * fsample;

for i = 1:length(ICdataCleana.trial)
    ArtArray(i,:) = [round((3.0*fsample)- precut)+(ICdataCleana.sampleinfo(i,1)),  round((3*fsample)+ postcut) + (ICdataCleana.sampleinfo(i,1))];
end 

cfg = [];
cfg.artfctdef.visual.artifact =  ArtArray;
cfg.artfctdef.reject = 'nan';
ICdataClean = ft_rejectartifact(cfg, ICdataCleana);

cfg             =	[];
cfg.viewmode	=	'vertical';
ft_databrowser(cfg,	ICdataClean);

%%
clear ICTrials
save(['ICdataClean_' subjID '.mat'],	'ICdataClean', '-v7.3');

%% Rereference Electrodes Individually and split for conditions

IEEGRereference

%%  TimeCoursePlots
IEEGLocalDistal

% 
% 
% %% TFR (adapt parameters)
% cfg             =	[];
% cfg.method      =	'mtmfft';
% cfg.foi         =	5:5:200;
% cfg.toi         =	-.3:0.01:.8;
% cfg.t_ftimwin   =	ones(length(cfg.foi),1).*0.2;
% cfg.taper		=	'hanning';
% cfg.output		=	'pow';
% freq            =	ft_freqanalysis(cfg, ICReref);
% 
% 
% %% Plots (adapt)
% 
% cfg				=	[];
% cfg.headshape	= pial_lh;
% cfg.projection	=	'orthographic';
% cfg.channel		=	{'LPG*',	'LTG*'};
% cfg.viewpoint	=	'left';
% cfg.mask        =	'convex';
% cfg.boxchannel	=	{'LTG30',	'LTG31'};
% lay             =	ft_prepare_layout(cfg,	freq);
% 
% 
% cfg				 =	[];
% cfg.baseline	 =	[-.3	-.1];
% cfg.baselinetype =	'relchange';
% freq_blc         =	ft_freqbaseline(cfg,	freq);
% 
% cfg				=	[];
% cfg.layout		=	lay;
% cfg.showoutline	=	'yes';
% ft_multiplotTFR(cfg,	freq_blc);
% 
% %% Ecog representation on surface (probably not relevant)
% 
% cfg				=	[];
% cfg.frequency	=	[70	150];
% cfg.avgoverfreq	=	'yes';
% cfg.latency		=	[0	0.8];
% cfg.avgovertime =	'yes';
% freq_sel =	ft_selectdata(cfg,	freq_blc);
% 
% cfg				 =	[];
% cfg.funparameter =	'powspctrm';
% cfg.funcolorlim	 =	[-.5	.5];
% cfg.method		 =	'surface';
% cfg.interpmethod =	'sphere_weighteddistance';
% cfg.sphereradius =	8;
% cfg.camlight	 =	'no';
% ft_sourceplot(cfg,	freq_sel, pial_lh);
% view([-90	20]);	
% material	dull;	
% lighting	gouraud;	
% camlight;
% 
% ft_plot_sens(elec_acpc_fr);
% 
% %% Depth electrode SEEG data representation
% 
% %first creation of mask on segmentation by freesurfer
% atlas	=	ft_read_atlas('freesurfer/mri/aparc+aseg.mgz');
% atlas.coordsys	=	'acpc';
% cfg				=	[];
% cfg.inputcoord	=	'acpc';
% cfg.atlas		=	atlas;
% cfg.roi			=	{'Right-Hippocampus',	'Right-Amygdala'};
% mask_rha =	ft_volumelookup(cfg,	atlas);
% 
% % create surface mesh based on mask (smoothed)
% seg	=	keepfields(atlas,	{'dim',	'unit','coordsys','transform'});
% seg.brain	=	mask_rha;
% cfg				=	[];
% cfg.method		=	'iso2mesh';
% cfg.radbound	=	2;
% cfg.maxsurf		=	0;
% cfg.tissue		=	'brain';
% cfg.numvertices	=	1000;
% cfg.smooth		=	3;
% mesh_rha        =	ft_prepare_mesh(cfg,	seg)
% 
% % identify electrodes of interest
% cfg			 =	[];
% cfg.channel	 =	{'RAM*',	'RTH*',	'RHH*'};	
% freq_sel2	 =	ft_selectdata(cfg,	freq_sel);
% 
% % Interpolate	the	high-frequency-band	activity	in	the	bipolar	channels	on	a	
% %spherical	cloud	around	the	channel	positions,	while	overlaying	the	neural	activity	
% %with	the	above	mesh???????????????
% cfg                 =	[];
% cfg.funparameter	=	'powspctrm';
% cfg.funcolorlim		=	[-.5	.5];
% cfg.method			=	'cloud';
% cfg.slice			=	'3d';
% cfg.nslices			=	2;
% cfg.facealpha		=	.25;
% ft_sourceplot(cfg,	freq_sel2,	mesh_rha);
% view([120	40]);
% lighting	gouraud;	
% camlight;
% 
% %
% 
% cfg.slice			=	'2d';
% ft_sourceplot(cfg,	freq_sel2,	mesh_rha);
% 
% 
% 
% 
