% figure
% plot( ICdatLLHipp.time{1,1}, ICdatLLHipp.trial{1,1}(1:21,:))
% saveas(gcf , ['/media/mxv796/rds-share/Mircea/Datasaves/Micro/',subjID,'/picks/MicroLocal/ERPTrialAveragedLeftLocalStim.png']);
%  
% figure
% plot( ICdatLDHipp.time{1,1}, ICdatLDHipp.trial{1,1}(1:21,:))
% saveas(gcf , ['/media/mxv796/rds-share/Mircea/Datasaves/Micro/',subjID,'/picks/MicroLocal/ERPTrialAveragedLeftDistalStim.png']);
%  
% figure
% plot( ICdatRLHipp.time{1,1}, ICdatRLHipp.trial{1,1}(21:end,:))
% saveas(gcf , ['/media/mxv796/rds-share/Mircea/Datasaves/Micro/',subjID,'/picks/MicroLocal/ERPTrialAveragedRightLocalStim.png']);
%  
% figure
% plot( ICdatRDHipp.time{1,1}, ICdatRDHipp.trial{1,1}(21:end,:))
% saveas(gcf , ['/media/mxv796/rds-share/Mircea/Datasaves/Micro/',subjID,'/picks/MicroLocal/ERPTrialAveragedRightDistalStim.png']);
%  
HippChannels = [9,10,11,17,18,25,57,58,59,65,66,73];

figure('units','normalized','outerposition',[0 0 1 1]);
plot( ICdatLHipp.time{1,1}, ICdatLHipp.trial{1,1}(HippChannels,:))
axis('tight')
legend(ICdatLHipp.label(HippChannels))
saveas(gcf , ['/media/mxv796/rds-share/Mircea/Datasaves/Macro/',subjID,'/picks/MacroLocal/ERPTrialAveragedLocalHippStim.png']);
 
figure('units','normalized','outerposition',[0 0 1 1]);
plot( ICdatDHipp.time{1,1}, ICdatDHipp.trial{1,1}(HippChannels,:))
legend(ICdatDHipp.label(HippChannels))
axis('tight')
saveas(gcf , ['/media/mxv796/rds-share/Mircea/Datasaves/Macro/',subjID,'/picks/MacroDistal/ERPTrialAveragedDistalHippStim.png']);
 
%% Cortex
CtxChannels = [1:8, 15, 16,20:24, 28:32, 49:56, 63, 64, 68:72, 77:80 ];

figure('units','normalized','outerposition',[0 0 1 1]);
plot( ICdatLCtx.time{1,1}, ICdatLCtx.trial{1,1}(CtxChannels,:))
axis('tight')
legend(ICdatLCtx.label(CtxChannels))
saveas(gcf , ['/media/mxv796/rds-share/Mircea/Datasaves/Macro/',subjID,'/picks/MacroLocal/ERPTrialAveragedLocalCtxStim.png']);
 
figure('units','normalized','outerposition',[0 0 1 1]);
plot( ICdatDCtx.time{1,1}, ICdatDCtx.trial{1,1}(CtxChannels,:))
legend(ICdatDCtx.label(CtxChannels))
axis('tight')
saveas(gcf , ['/media/mxv796/rds-share/Mircea/Datasaves/Macro/',subjID,'/picks/MacroDistal/ERPTrialAveragedDistalCtxStim.png']);
 

%% Adusted y-lim
%  HippChannels = [9,10,11,17,18,25,57,58,59,65,66,73];
% 
% figure('units','normalized','outerposition',[0 0 1 1]);
% plot( ICdatLHipp.time{1,1}, ICdatLHipp.trial{1,1}(HippChannels,:))
% axis('tight')
% ylim([-500 500])
% legend(ICdatLHipp.label(LocalHippChannels))
% saveas(gcf , ['/media/mxv796/rds-share/Mircea/Datasaves/Macro/',subjID,'/picks/MacroLocal/ERPTrialAveragedYlimLocalHippStim.png']);
%  
% figure('units','normalized','outerposition',[0 0 1 1]);
% plot( ICdatDHipp.time{1,1}, ICdatDHipp.trial{1,1}(HippChannels,:))
% legend(ICdatDHipp.label(HippChannels))
% ylim([-500 500])
% axis('tight')
% saveas(gcf , ['/media/mxv796/rds-share/Mircea/Datasaves/Macro/',subjID,'/picks/MacroDistal/ERPTrialAveragedYlimDistalHippStim.png']);
%  
% %% Cortex
% CtxChannels = [1:8, 15, 16,20:24, 28:32, 49:56, 63, 64, 68:72, 77:80 ];
% 
% figure('units','normalized','outerposition',[0 0 1 1]);
% plot( ICdatLCtx.time{1,1}, ICdatLCtx.trial{1,1}(CtxChannels,:))
% axis('tight')
% ylim([-500 500])
% legend(ICdatLCtx.label(LocalCtxChannels))
% saveas(gcf , ['/media/mxv796/rds-share/Mircea/Datasaves/Macro/',subjID,'/picks/MacroLocal/ERPTrialAveragedYlimLocalCtxStim.png']);
%  
% figure('units','normalized','outerposition',[0 0 1 1]);
% plot( ICdatDCtx.time{1,1}, ICdatDCtx.trial{1,1}(CtxChannels,:))
% legend(ICdatDCtx.label(CtxChannels))
% axis('tight')
% ylim([-500 500])
% saveas(gcf , ['/media/mxv796/rds-share/Mircea/Datasaves/Macro/',subjID,'/picks/MacroDistal/ERPTrialAveragedYlimDistalCtxStim.png']);
%  
