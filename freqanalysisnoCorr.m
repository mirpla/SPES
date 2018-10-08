%%

for condidx = 1:3
    condidxctx = 7;
    
    switch condidx
        
        case 1
            condName = ' Local vs. Distal Stimulation at channel AH';
        case 2
            condName = ' Local vs. Distal Stimulation at channel MH';
        case 3
            condName = ' Local vs. Distal Stimulation at channel PH';
    end
    
    for subjidx = [1,3,4]
        
        %%
        ID = AllMicro.SubjID{1,subjidx};
        Datal{1,subjidx} = eval(sprintf('CSCHippCond.%s.Conditions{1,condidx}', ID));
        Datad{1,subjidx} = eval(sprintf('CSCHippCond.%s.Conditions{1,condidxctx}', ID));
        
%         cfg = [];
%         cfg.prewindow = 1;
%         cfg.postwindow = 1;
%         Datal{1,subjidx} = ft_interpolatenan(cfg,  Datal{1,subjidx});
%         Datad{1,subjidx} = ft_interpolatenan(cfg,  Datad{1,subjidx});
% 
%         for i = 1:length(Datal{1,subjidx}.trial)
% 
%             Datal{1,subjidx}.trial{1,i} = ft_preproc_dftfilter(Datal{1,subjidx}.trial{1,i}, 1000, [50, 100, 150], 'Flreplace', 'zero');
%         end 
%         for i = 1:length(Datad{subjidx}.trial)
%             Datad{1,subjidx}.trial{1,i}  = ft_preproc_dftfilter(Datad{1,subjidx}.trial{1,i}, 1000, [50, 100, 150], 'Flreplace', 'zero');
%         end
%         
        chanlist =  eval(sprintf('CSCHippCond.%s.AllChan{1,condidx}',ID));
        cfg = [];
        cfg.channel = chanlist;
        %cfg.avgoverrpt = 'yes';
        cfg.avgoverchan = 'yes';
        Datale{1,subjidx} = ft_selectdata(cfg, Datal{1,subjidx});
        Datade{1,subjidx} = ft_selectdata(cfg, Datad{1,subjidx});
        cfg = [];
        cfg.channel = chanlist;
        %cfg.avgoverrpt = 'yes';
        Datals{1,subjidx} = ft_selectdata(cfg, Datal{1,subjidx});
        Datads{1,subjidx}  = ft_selectdata(cfg, Datad{1,subjidx});
          
        
       
        
        
        if ~isempty(chanlist)
            %% FreqAnalysis low F
            cfg = [];
            cfg.latency = [-1.2 -0.022];
            Datalpre = ft_selectdata(cfg, Datals{1,subjidx} );
            Datadpre = ft_selectdata(cfg, Datads{1,subjidx} );
            
            cfg = [];
            cfg.latency = [0.028 1.2];
            Datalpost = ft_selectdata(cfg, Datals{1,subjidx});
            Datadpost = ft_selectdata(cfg, Datads{1,subjidx} );
            
            Datalpre.hdr.nTrials    =length(Datalpre.trial);
            Datalpost.hdr.nTrials   =length(Datalpost.trial);
            Datadpre.hdr.nTrials    =length(Datadpre.trial);
            Datadpost.hdr.nTrials   =length(Datadpost.trial);
            
            
            cfg = [];
            cfg.output = 'pow';
            %cfg.channel = Datal.label(chanlist);
            cfg.method = 'mtmfft';
            cfg.foi = 1:1:30;
            cfg.tapsmofrq = 1;
            cfg.keeptrials = 'yes';
            FFTlpreC{1,subjidx} = ft_freqanalysis(cfg, Datalpre);
            FFTdpreC{1,subjidx} = ft_freqanalysis(cfg, Datadpre);
            
            FFTlpostC{1,subjidx} = ft_freqanalysis(cfg, Datalpost);
            FFTdpostC{1,subjidx} = ft_freqanalysis(cfg, Datadpost);
            
            %% 1/F transformation
%             cfg = [];
%             [FFTlpreC{1,subjidx}, tSlopellpre] = sh_subtr1of(cfg,FFTlpre);
%             [FFTdpreC{1,subjidx}, tSlopeldpre] = sh_subtr1of(cfg,FFTdpre);
%             
%             [FFTlpostC{1,subjidx}, tSlopellpost] = sh_subtr1of(cfg,FFTlpost);
%             [FFTdpostC{1,subjidx}, tSlopeldpost] = sh_subtr1of(cfg,FFTdpost);
            %             cfg = [];
            %             [FFTdiffC, tSlopediff] = sh_subtr1of(cfg,FFTldiff);
            %%
            
            FFTldiffC{1,subjidx} = FFTlpostC{1,subjidx};
            FFTldiffC{1,subjidx}.powspctrm = FFTlpostC{1,subjidx}.powspctrm - FFTlpreC{1,subjidx}.powspctrm;
            
            FFTddiffC{1,subjidx} = FFTdpostC{1,subjidx};
            FFTddiffC{1,subjidx}.powspctrm = FFTdpostC{1,subjidx}.powspctrm - FFTdpreC{1,subjidx}.powspctrm;
            
            %% High Frequency
            cfg = [];
            cfg.output = 'pow';
            cfg.method = 'mtmfft';
            cfg.foi = 30:4:150;
            cfg.keeptrials = 'yes';
            cfg.tapsmofrq = 15;
           [FFTlpreCHF{1,subjidx}] = ft_freqanalysis(cfg, Datalpre);
           [FFTlpreCHF{1,subjidx}] = ft_freqanalysis(cfg, Datadpre);
            
            [FFTlpostCHF{1,subjidx}] = ft_freqanalysis(cfg, Datalpost);
            [FFTlpostCHF{1,subjidx}] = ft_freqanalysis(cfg, Datadpost);
            
            %% 1/F transformation
%             cfg = [];
%             [FFTlpreCHF{1,subjidx}, tSlopellpre] = sh_subtr1of([],FFTlpreHF);
%             [FFTdpreCHF{1,subjidx}, tSlopeldpre] = sh_subtr1of(cfg,FFTdpreHF);
%             
%             [FFTlpostCHF{1,subjidx}, tSlopellpost] = sh_subtr1of(cfg,FFTlpostHF);
%            [FFTlpostCHF{1,subjidx}, tSlopeldpost] = sh_subtr1of(cfg,FFTdpostHF);
            %             cfg = [];
            %             [FFTdiffC, tSlopediff] = sh_subtr1of(cfg,FFTldiff);
            %%
            
            FFTldiffCHF{1,subjidx} = FFTlpostCHF{1,subjidx};
            FFTldiffCHF{1,subjidx}.powspctrm = FFTlpostCHF{1,subjidx}.powspctrm - FFTlpreCHF{1,subjidx}.powspctrm;
            
            FFTddiffCHF{1,subjidx} = FFTdpostCHF{1,subjidx};
            FFTddiffCHF{1,subjidx}.powspctrm = FFTdpostCHF{1,subjidx}.powspctrm - FFTdpreCHF{1,subjidx}.powspctrm;
            
            
            %% compute ERP per subject with std error
            
%             chanidx = 1;
%             for a = 1:length(Datale.trial)
%                 ERPlocal(a,:)  = [Datale.trial{a}(chanidx,1:2980), NaN(1, 3026 - 2981),  Datale.trial{a}(chanidx,3026:end)];
%                 ERPbaselin(a,:) = Datale.trial{a}(chanidx,1900:2900);
%             end
%             
%             
%             
%             for a = 1:length(Datade.trial)
%                 ERPdistal(a,:)  = [Datade.trial{a}(chanidx,1:2980), NaN(1, 3026 - 2981),  Datade.trial{a}(chanidx,3026:end)];
%                 ERPbasedin(a,:) = Datade.trial{a}(chanidx,1900:2900);
%             end
%             
%             ERPl(subjidx,:)    = mean(ERPlocal,1)-mean(mean(ERPbaselin));
%             stdERPl(subjidx,:) = std(ERPlocal)/sqrt(length(Datale.trial));
%             
%             ERPd(subjidx,:)    = mean(ERPdistal,1)-mean(mean(ERPbasedin));
%             stdERPd(subjidx,:) = std(ERPdistal)/sqrt(length(Datade.trial));
%             
%             
            
           
        end
    end
    %% ERP per SUbjects
    cfg = [];
     %cfg.normalizevar   = 'N';
     if condidx == 1
         ERPlsubj{1,1} = ft_timelockanalysis(cfg, Datale{1,1});
         ERPlsubj{1,3} = ft_timelockanalysis(cfg, Datale{1,4});
         ERPlsubj{1,1}.label = {'1'};
         ERPlsubj{1,3}.label = {'1'};
         
         ERPdsubj{1,1} = ft_timelockanalysis(cfg, Datade{1,1});
         ERPdsubj{1,3} = ft_timelockanalysis(cfg, Datade{1,4});
         ERPdsubj{1,1}.label = {'1'};
         ERPdsubj{1,3}.label = {'1'};
         
        
         
         [ERPlGA] = ft_timelockgrandaverage(cfg, ERPlsubj{1,1}, ERPlsubj{1,3});
         [ERPdGA] = ft_timelockgrandaverage(cfg, ERPdsubj{1,1}, ERPdsubj{1,3});       
     else
         ERPlsubj{1,1} = ft_timelockanalysis(cfg, Datale{1,1});
         ERPlsubj{1,2} = ft_timelockanalysis(cfg, Datale{1,3});
         ERPlsubj{1,3} = ft_timelockanalysis(cfg, Datale{1,4});
         ERPlsubj{1,1}.label = {'1'};
         ERPlsubj{1,2}.label = {'1'};
         ERPlsubj{1,3}.label = {'1'};
         
         ERPdsubj{1,1} = ft_timelockanalysis(cfg, Datade{1,1});
         ERPdsubj{1,2} = ft_timelockanalysis(cfg, Datade{1,3});
         ERPdsubj{1,3} = ft_timelockanalysis(cfg, Datade{1,4});
         ERPdsubj{1,1}.label = {'1'};
         ERPdsubj{1,2}.label = {'1'};
         ERPdsubj{1,3}.label = {'1'};

        
         
         [ERPlGA] = ft_timelockgrandaverage(cfg, ERPlsubj{1,1}, ERPlsubj{1,2}, ERPlsubj{1,3});
         [ERPdGA] = ft_timelockgrandaverage(cfg, ERPdsubj{1,1}, ERPdsubj{1,2}, ERPdsubj{1,3});        
     end
    
 
     
    %% Compute CumSum per subject
     
%      postLat = [0.026 1];
%      
%      cfg = [];
%      cfg.latency = postLat;
%      %cfg.channel = chanidx;
%      cfg.avgoverchan = 'yes';
%      CSCdatLHippPost{1} = ft_selectdata(cfg, Datals{1,1});
%      CSCdatLHippPost{2} = ft_selectdata(cfg, Datals{1,3});
%      CSCdatLHippPost{3} = ft_selectdata(cfg, Datals{1,4});
%      
%      cfg = [];
%      cfg.latency = postLat;
%      %cfg.channel = chanidx;
%      cfg.avgoverchan = 'yes';
%      CSCdatDHippPost{1} = ft_selectdata(cfg,  Datads{1,1});
%      CSCdatDHippPost{2} = ft_selectdata(cfg,  Datads{1,3});
%      CSCdatDHippPost{3} = ft_selectdata(cfg,  Datads{1,4});
%      
%      
%      for i = 1:3
%          if ~isempty(CSCdatDHippPost{i}.label)
%              CSCdatLHippPost{i}.label = '1'; 
%              CSCdatDHippPost{i}.label = '1';
%              cfg = [];
%              [postlatLockl{i}] = ft_timelockanalysis(cfg, CSCdatLHippPost{i});
%              [postlatLockd{i}] = ft_timelockanalysis(cfg, CSCdatDHippPost{i});
%          end
%      end
%      
%      cfg = [];
%      %cfg.normalizevar   = 'N';
%      if condidx == 1
%          [postlatlGA] = ft_timelockgrandaverage(cfg, postlatLockl{1},postlatLockl{3});
%          [postlatdGA] = ft_timelockgrandaverage(cfg, postlatLockd{1},postlatLockd{3});       
%      else
%          [postlatlGA] = ft_timelockgrandaverage(cfg, postlatLockl{1},postlatLockl{2},postlatLockl{3});
%          [postlatdGA] = ft_timelockgrandaverage(cfg, postlatLockd{1},postlatLockl{2},postlatLockd{3});        
%      end
%      
%      AbsERPlocal  = abs(postlatlGA.avg);
%      ERPcSumLocal = cumsum(AbsERPlocal);
%      normERPLocal(1,:) = ERPcSumLocal / ERPcSumLocal(1,end);
%      
%      AbsERPdistal  = abs(postlatdGA.avg);
%      ERPcSumdistal = cumsum(AbsERPdistal);
%      normERPDistal(1,:) = ERPcSumdistal / ERPcSumdistal(1,end);
%      
%     %% Compute ERP grand Average
%     
% %    for i = 1:3
% %          if ~isempty(CSCdatDHippPost{i}.label)
% %              CSCdatLHippPost{i}.label = '1'; 
% %              CSCdatDHippPost{i}.label = '1';
% %              cfg = [];
% %              [postlatLockl{i}] = ft_timelockanalysis(cfg, CSCdatLHippPost{i});
% %              [postlatLockd{i}] = ft_timelockanalysis(cfg, CSCdatDHippPost{i});
% %          end
% %      end
%     
%     figure
%     
%     subplot(4,2,1)
%     
%     
%     hold on
%     shadedErrorBar(Datale{1,1}.time{1,1},ERPlGA.avg, mean(stdERPl),'lineProps', 'b')
%     axis('tight');
%     lim = axis;
%     rectangle('Position', [-0.02,-1000, 0.046, 2000], 'FaceColor', 'w','EdgeColor','w')
%     axis(lim);
%     xlim([-0.1 1]);
%     %ylim([-600 200])
%     hold off
%     
%     subplot(4,2,2)
%     hold on
%     shadedErrorBar(Datade{1,1}.time{1,1},ERPdGA.avg, mean(stdERPd),'lineProps', 'r')
%     axis('tight');
%     lim = axis;
%     rectangle('Position', [-0.02,-1000, 0.046, 2000], 'FaceColor', 'w','EdgeColor','w')
%     axis(lim);
%     xlim([-0.1 1]);
%     hold off
%     
%     
%     %% Comupute COMSUM grand Average
%     normERPlGA = normERPLocal;
%     normERPdGA = normERPDistal;
%     
%     
%     subplot(4,2,3:4)
%    
%     
%     hold on
%     plot(postlatlGA.time, normERPlGA)  % std(normERPLocal)/sqrt(length(Datal.trial)
%     plot(postlatdGA.time, normERPdGA) % std(normERPDistal)/sqrt(length(Datad.trial)
%     legend('Local','Distal')
%     %plot(0.174,0.2,'k*')
%     %plot(0.335,0.2,'k*')
%     %line([0.174, 0.335],[0.2 0.2], 'Color', 'k')
%     title([ID , ' ' , condName])
%     hold off
%  
    %% Grand Average Freq
    cfg = [];
    
    if condidx == 1               
        
        [FFTlpreCd{1,1}]  = ft_freqdescriptives(cfg, FFTlpreC{1,1});
        [FFTlpreCd{1,3}]  = ft_freqdescriptives(cfg, FFTlpreC{1,4});
        FFTlpreCd{1,1}.label = {'a';'b';'c';'d'};
        FFTlpreCd{1,3}.label = {'a';'b';'c';'d'};
        
        
        [FFTlpostCd{1,1}] = ft_freqdescriptives(cfg, FFTlpostC{1,1});
        [FFTlpostCd{1,3}] = ft_freqdescriptives(cfg, FFTlpostC{1,4});
        FFTlpostCd{1,1}.label = {'a';'b';'c';'d'};
        FFTlpostCd{1,3}.label = {'a';'b';'c';'d'};
        
        
        
        [FFTldiffCd{1,1}] = ft_freqdescriptives(cfg, FFTldiffC{1,1});
        [FFTldiffCd{1,3}] = ft_freqdescriptives(cfg, FFTldiffC{1,4});
        FFTldiffCd{1,1}.label = {'a';'b';'c';'d'};
        FFTldiffCd{1,3}.label = {'a';'b';'c';'d'};
        
        
        [FFTdpreCd{1,1}]  = ft_freqdescriptives(cfg, FFTdpreC{1,1});
        [FFTdpreCd{1,3}]  = ft_freqdescriptives(cfg, FFTdpreC{1,4});        
        FFTdpreCd{1,1}.label = {'a';'b';'c';'d'};
        FFTdpreCd{1,3}.label = {'a';'b';'c';'d'};
        
        
        
        [FFTdpostCd{1,1}] = ft_freqdescriptives(cfg, FFTdpostC{1,1});
        [FFTdpostCd{1,3}] = ft_freqdescriptives(cfg, FFTdpostC{1,4});
        FFTdpostCd{1,1}.label = {'a';'b';'c';'d'};
        FFTdpostCd{1,3}.label = {'a';'b';'c';'d'};
        
        
        [FFTddiffCd{1,1}] = ft_freqdescriptives(cfg, FFTddiffC{1,1});
        [FFTddiffCd{1,3}] = ft_freqdescriptives(cfg, FFTddiffC{1,4});
        FFTddiffCd{1,1}.label = {'a';'b';'c';'d'};
        FFTddiffCd{1,3}.label = {'a';'b';'c';'d'};
        
        
        cfg = [];
        [FFTlpreCGA]  = ft_freqgrandaverage(cfg, FFTlpreCd{1,1},   FFTlpreCd{1,3});
        [FFTlpostCGA] = ft_freqgrandaverage(cfg, FFTlpostCd{1,1},  FFTlpostCd{1,3});
        [FFTldiffCGA] = ft_freqgrandaverage(cfg, FFTldiffCd{1,1},  FFTldiffCd{1,3});
        
        cfg = [];
        [FFTdpreCGA]  = ft_freqgrandaverage(cfg, FFTdpreCd{1,1},  FFTdpreCd{1,3});
        [FFTdpostCGA] = ft_freqgrandaverage(cfg, FFTdpostCd{1,1}, FFTdpostCd{1,3});
        [FFTddiffCGA] = ft_freqgrandaverage(cfg, FFTddiffCd{1,1}, FFTddiffCd{1,3});
    else
        [FFTlpreCd{1,1}]  = ft_freqdescriptives(cfg, FFTlpreC{1,1});
        [FFTlpreCd{1,2}]  = ft_freqdescriptives(cfg, FFTlpreC{1,3});
        [FFTlpreCd{1,3}]  = ft_freqdescriptives(cfg, FFTlpreC{1,4});
        FFTlpreCd{1,1}.label = {'a';'b';'c';'d'};
        FFTlpreCd{1,2}.label = {'a';'b';'c';'d'};
        FFTlpreCd{1,3}.label = {'a';'b';'c';'d'};
        
        
        [FFTlpostCd{1,1}] = ft_freqdescriptives(cfg, FFTlpostC{1,1});
        [FFTlpostCd{1,2}] = ft_freqdescriptives(cfg, FFTlpostC{1,3});
        [FFTlpostCd{1,3}] = ft_freqdescriptives(cfg, FFTlpostC{1,4});
        FFTlpostCd{1,1}.label = {'a';'b';'c';'d'};
        FFTlpostCd{1,2}.label = {'a';'b';'c';'d'};
        FFTlpostCd{1,3}.label = {'a';'b';'c';'d'};
        
        
        
        [FFTldiffCd{1,1}] = ft_freqdescriptives(cfg, FFTldiffC{1,1});
        [FFTldiffCd{1,2}] = ft_freqdescriptives(cfg, FFTldiffC{1,3});
        [FFTldiffCd{1,3}] = ft_freqdescriptives(cfg, FFTldiffC{1,4});        
        FFTldiffCd{1,1}.label = {'a';'b';'c';'d'};
        FFTldiffCd{1,2}.label = {'a';'b';'c';'d'};
        FFTldiffCd{1,3}.label = {'a';'b';'c';'d'};
        
        
        [FFTdpreCd{1,1}]  = ft_freqdescriptives(cfg, FFTdpreC{1,1});
        [FFTdpreCd{1,2}]  = ft_freqdescriptives(cfg, FFTdpreC{1,3}); 
        [FFTdpreCd{1,3}]  = ft_freqdescriptives(cfg, FFTdpreC{1,4});        
        FFTdpreCd{1,1}.label = {'a';'b';'c';'d'};
        FFTdpreCd{1,2}.label = {'a';'b';'c';'d'};
        FFTdpreCd{1,3}.label = {'a';'b';'c';'d'};
        
        
        
        [FFTdpostCd{1,1}] = ft_freqdescriptives(cfg, FFTdpostC{1,1});
        [FFTdpostCd{1,2}] = ft_freqdescriptives(cfg, FFTdpostC{1,3});
        [FFTdpostCd{1,3}] = ft_freqdescriptives(cfg, FFTdpostC{1,4});
        FFTdpostCd{1,1}.label = {'a';'b';'c';'d'};
        FFTdpostCd{1,2}.label = {'a';'b';'c';'d'};
        FFTdpostCd{1,3}.label = {'a';'b';'c';'d'};
        
        
        [FFTddiffCd{1,1}] = ft_freqdescriptives(cfg, FFTddiffC{1,1});
        [FFTddiffCd{1,2}] = ft_freqdescriptives(cfg, FFTddiffC{1,3});
        [FFTddiffCd{1,3}] = ft_freqdescriptives(cfg, FFTddiffC{1,4});
        FFTddiffCd{1,1}.label = {'a';'b';'c';'d'};
        FFTddiffCd{1,2}.label = {'a';'b';'c';'d'};
        FFTddiffCd{1,3}.label = {'a';'b';'c';'d'};
                
        cfg = [];
        [FFTlpreCGA]  = ft_freqgrandaverage(cfg, FFTlpreCd{1,1},  FFTlpreCd{1,2},  FFTlpreCd{1,3});
        [FFTlpostCGA] = ft_freqgrandaverage(cfg, FFTlpostCd{1,1}, FFTlpostCd{1,2}, FFTlpostCd{1,3});
        [FFTldiffCGA] = ft_freqgrandaverage(cfg, FFTldiffCd{1,1}, FFTldiffCd{1,2}, FFTldiffCd{1,3});
        
        cfg = [];
        [FFTdpreCGA]  = ft_freqgrandaverage(cfg, FFTdpreCd{1,1},  FFTdpreCd{1,2}, FFTdpreCd{1,3});
        [FFTdpostCGA] = ft_freqgrandaverage(cfg, FFTdpostCd{1,1}, FFTdpostCd{1,2}, FFTdpostCd{1,3});
        [FFTddiffCGA] = ft_freqgrandaverage(cfg, FFTddiffCd{1,1}, FFTddiffCd{1,2}, FFTddiffCd{1,3});
    end
    figure
    subplot(2,2,1)
    
    
    hold on
    cfg = [];
    cfg.channel = 'all';
    cfg.graphcolor = 'brk';
    ft_singleplotER(cfg, FFTlpreCGA, FFTlpostCGA, FFTldiffCGA);
     xlabel(['Frequency in Hz']);
    ylabel(['Power'])
    legend('Pre', 'Post', 'diff');
    hold off
    
    subplot(2,2,2)
    
    hold on
    cfg = [];
    cfg.channel = 'all';
    cfg.graphcolor = 'brk';
    ft_singleplotER(cfg, FFTdpreCGA, FFTdpostCGA, FFTddiffCGA);
     xlabel(['Frequency in Hz']);
    ylabel(['Power'])
    legend('Pre', 'Post', 'diff');
    hold off
        
    %% Same again for HF
    
    if condidx == 1
        
        [FFTlpreCdHF{1,1}]  = ft_freqdescriptives(cfg, FFTlpreCHF{1,1});
        [FFTlpreCdHF{1,3}]  = ft_freqdescriptives(cfg, FFTlpreCHF{1,4});
        FFTlpreCdHF{1,1}.label = {'a';'b';'c';'d'};
        FFTlpreCdHF{1,3}.label = {'a';'b';'c';'d'};
        
        
        [FFTlpostCdHF{1,1}] = ft_freqdescriptives(cfg, FFTlpostCHF{1,1});
        [FFTlpostCdHF{1,3}] = ft_freqdescriptives(cfg, FFTlpostCHF{1,4});
        FFTlpostCdHF{1,1}.label = {'a';'b';'c';'d'};
        FFTlpostCdHF{1,3}.label = {'a';'b';'c';'d'};
        
        
        
        [FFTldiffCdHF{1,1}] = ft_freqdescriptives(cfg, FFTldiffCHF{1,1});
        [FFTldiffCdHF{1,3}] = ft_freqdescriptives(cfg, FFTldiffCHF{1,4});
        FFTldiffCdHF{1,1}.label = {'a';'b';'c';'d'};
        FFTldiffCdHF{1,3}.label = {'a';'b';'c';'d'};
        
        
        [FFTdpreCdHF{1,1}]  = ft_freqdescriptives(cfg, FFTdpreCHF{1,1});
        [FFTdpreCdHF{1,3}]  = ft_freqdescriptives(cfg, FFTdpreCHF{1,4});
        FFTdpreCdHF{1,1}.label = {'a';'b';'c';'d'};
        FFTdpreCdHF{1,3}.label = {'a';'b';'c';'d'};
        
        
        
        [FFTdpostCdHF{1,1}] = ft_freqdescriptives(cfg, FFTdpostCHF{1,1});
        [FFTdpostCdHF{1,3}] = ft_freqdescriptives(cfg, FFTdpostCHF{1,4});
        FFTdpostCdHF{1,1}.label = {'a';'b';'c';'d'};
        FFTdpostCdHF{1,3}.label = {'a';'b';'c';'d'};
        
        
        [FFTddiffCdHF{1,1}] = ft_freqdescriptives(cfg, FFTddiffCHF{1,1});
        [FFTddiffCdHF{1,3}] = ft_freqdescriptives(cfg, FFTddiffCHF{1,4});
        FFTddiffCdHF{1,1}.label = {'a';'b';'c';'d'};
        FFTddiffCdHF{1,3}.label = {'a';'b';'c';'d'};
        
        
        cfg = [];
        [FFTlpreCGAHF]  = ft_freqgrandaverage(cfg, FFTlpreCdHF{1,1},   FFTlpreCdHF{1,3});
        [FFTlpostCGAHF] = ft_freqgrandaverage(cfg, FFTlpostCdHF{1,1},  FFTlpostCdHF{1,3});
        [FFTldiffCGAHF] = ft_freqgrandaverage(cfg, FFTldiffCdHF{1,1},  FFTldiffCdHF{1,3});
        
        cfg = [];
        [FFTdpreCGAHF]  = ft_freqgrandaverage(cfg, FFTdpreCdHF{1,1},  FFTdpreCdHF{1,3});
        [FFTdpostCGAHF] = ft_freqgrandaverage(cfg, FFTdpostCdHF{1,1}, FFTdpostCdHF{1,3});
        [FFTddiffCGAHF] = ft_freqgrandaverage(cfg, FFTddiffCdHF{1,1}, FFTddiffCdHF{1,3});
    else
        [FFTlpreCdHF{1,1}]  = ft_freqdescriptives(cfg, FFTlpreCHF{1,1});
        [FFTlpreCdHF{1,2}]  = ft_freqdescriptives(cfg, FFTlpreCHF{1,3});
        [FFTlpreCdHF{1,3}]  = ft_freqdescriptives(cfg, FFTlpreCHF{1,4});
        FFTlpreCdHF{1,1}.label = {'a';'b';'c';'d'};
        FFTlpreCdHF{1,2}.label = {'a';'b';'c';'d'};
        FFTlpreCdHF{1,3}.label = {'a';'b';'c';'d'};
        
        
        [FFTlpostCdHF{1,1}] = ft_freqdescriptives(cfg, FFTlpostCHF{1,1});
        [FFTlpostCdHF{1,2}] = ft_freqdescriptives(cfg, FFTlpostCHF{1,3});
        [FFTlpostCdHF{1,3}] = ft_freqdescriptives(cfg, FFTlpostCHF{1,4});
        FFTlpostCdHF{1,1}.label = {'a';'b';'c';'d'};
        FFTlpostCdHF{1,2}.label = {'a';'b';'c';'d'};
        FFTlpostCdHF{1,3}.label = {'a';'b';'c';'d'};
        
        
        
        [FFTldiffCdHF{1,1}] = ft_freqdescriptives(cfg, FFTldiffCHF{1,1});
        [FFTldiffCdHF{1,2}] = ft_freqdescriptives(cfg, FFTldiffCHF{1,3});
        [FFTldiffCdHF{1,3}] = ft_freqdescriptives(cfg, FFTldiffCHF{1,4});
        FFTldiffCdHF{1,1}.label = {'a';'b';'c';'d'};
        FFTldiffCdHF{1,2}.label = {'a';'b';'c';'d'};
        FFTldiffCdHF{1,3}.label = {'a';'b';'c';'d'};
        
        
        [FFTdpreCdHF{1,1}]  = ft_freqdescriptives(cfg, FFTdpreCHF{1,1});
        [FFTdpreCdHF{1,2}]  = ft_freqdescriptives(cfg, FFTdpreCHF{1,3});
        [FFTdpreCdHF{1,3}]  = ft_freqdescriptives(cfg, FFTdpreCHF{1,4});
        FFTdpreCdHF{1,1}.label = {'a';'b';'c';'d'};
        FFTdpreCdHF{1,2}.label = {'a';'b';'c';'d'};
        FFTdpreCdHF{1,3}.label = {'a';'b';'c';'d'};
        
        
        
        [FFTdpostCdHF{1,1}] = ft_freqdescriptives(cfg, FFTdpostCHF{1,1});
        [FFTdpostCdHF{1,2}] = ft_freqdescriptives(cfg, FFTdpostCHF{1,3});
        [FFTdpostCdHF{1,3}] = ft_freqdescriptives(cfg, FFTdpostCHF{1,4});
        FFTdpostCdHF{1,1}.label = {'a';'b';'c';'d'};
        FFTdpostCdHF{1,2}.label = {'a';'b';'c';'d'};
        FFTdpostCdHF{1,3}.label = {'a';'b';'c';'d'};
        
        
        [FFTddiffCdHF{1,1}] = ft_freqdescriptives(cfg, FFTddiffCHF{1,1});
        [FFTddiffCdHF{1,2}] = ft_freqdescriptives(cfg, FFTddiffCHF{1,3});
        [FFTddiffCdHF{1,3}] = ft_freqdescriptives(cfg, FFTddiffCHF{1,4});
        FFTddiffCdHF{1,1}.label = {'a';'b';'c';'d'};
        FFTddiffCdHF{1,2}.label = {'a';'b';'c';'d'};
        FFTddiffCdHF{1,3}.label = {'a';'b';'c';'d'};
        
        cfg = [];
        [FFTlpreCGAHF]  = ft_freqgrandaverage(cfg, FFTlpreCdHF{1,1},  FFTlpreCdHF{1,2},  FFTlpreCdHF{1,3});
        [FFTlpostCGAHF] = ft_freqgrandaverage(cfg, FFTlpostCdHF{1,1}, FFTlpostCdHF{1,2}, FFTlpostCdHF{1,3});
        [FFTldiffCGAHF] = ft_freqgrandaverage(cfg, FFTldiffCdHF{1,1}, FFTldiffCdHF{1,2}, FFTldiffCdHF{1,3});
        
        cfg = [];
        [FFTdpreCGAHF]  = ft_freqgrandaverage(cfg, FFTdpreCdHF{1,1},  FFTdpreCdHF{1,2}, FFTdpreCdHF{1,3});
        [FFTdpostCGAHF] = ft_freqgrandaverage(cfg, FFTdpostCdHF{1,1}, FFTdpostCdHF{1,2}, FFTdpostCdHF{1,3});
        [FFTddiffCGAHF] = ft_freqgrandaverage(cfg, FFTddiffCdHF{1,1}, FFTddiffCdHF{1,2}, FFTddiffCdHF{1,3});
    end

    subplot(2,2,3) 
    hold on
    
    cfg = [];
    cfg.channel = 'all';
    cfg.graphcolor = 'brk';
    ft_singleplotER(cfg, FFTlpreCGAHF, FFTlpostCGAHF, FFTldiffCGAHF);
    legend('Pre', 'Post', 'diff');
    xlabel(['Frequency in Hz']);
    ylabel(['Power'])
    hold off
    
    subplot(2,2,4)
    hold on
    cfg = [];
    cfg.channel = 'all';
    cfg.graphcolor = 'brk';
    ft_singleplotER(cfg, FFTdpreCGAHF, FFTdpostCGAHF, FFTddiffCGAHF);
    legend('Pre', 'Post', 'diff');
    
     xlabel(['Frequency in Hz']);
    ylabel(['Power'])
    hold off
    
       
    [~, diffidx1] = min(abs(normERPlGA - 0.3))   
    [~, diffidx2] = min(abs(normERPdGA - 0.3))
    cumsumdiff(condidx) = abs((postlatlGA.time(1,diffidx1) - postlatlGA.time(1,diffidx2)))*1000;
    mean(cumsumdiff)
end
