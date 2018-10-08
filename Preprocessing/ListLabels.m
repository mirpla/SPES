switch subjID    
    case 'P072'
        clear stimfirstlabels;
        stimfirstlabels = strings(2,length(stimartlabel));
        stimfirstlabels(1,1:14) = 'R O pi_2';
        stimfirstlabels(2,1:14) = 'R O pi_3';
        
        stimfirstlabels(1,15:30) = 'R O pi_3';
        stimfirstlabels(2,15:30) = 'R O pi_4';
        
        stimfirstlabels(1,37:45) = 'R O pi_4';
        stimfirstlabels(2,37:45) = 'R O pi_5';
        
        stimfirstlabels(1,46:62) = 'R P as_2';
        stimfirstlabels(2,46:62) = 'R P as_3';
        
        stimfirstlabels(1,63:82) = 'R P as_3';
        stimfirstlabels(2,63:82) = 'R P as_4';
        
        stimfirstlabels(1,83:104) = 'R P as_4';
        stimfirstlabels(2,83:104) = 'R P as_5';
        
        stimfirstlabels(1,105:119) = 'R P as_5';
        stimfirstlabels(2,105:119) = 'R P as_6';
        
        stimfirstlabels(1,120:147) = 'R P as_6';
        stimfirstlabels(2,120:147) = 'R P as_7';
        
        stimfirstlabels(1,148:163) = 'R C_2';
        stimfirstlabels(2,148:163) = 'R C_3';
        
        stimfirstlabels(1,164:184) = 'R C_3';
        stimfirstlabels(2,164:184) = 'R C_4';
        
        stimfirstlabels(1,185:199) = 'R C_4';
        stimfirstlabels(2,185:199) = 'R C_5';
        
        stimfirstlabels(1,200:214) = 'R C_5';
        stimfirstlabels(2,200:214) = 'R C_6';
        
        stimfirstlabels(1,215:218) = 'R C_6';
        stimfirstlabels(2,215:218) = 'R C_7';
        
        stimfirstlabels(1,219:230) = 'ROF_2';
        stimfirstlabels(2,219:230) = 'ROF_3';
        
        stimfirstlabels(1,231:249) = 'ROF_3';
        stimfirstlabels(2,231:249) = 'ROF_4';
        
        stimfirstlabels(1,250:263) = 'ROF_4';
        stimfirstlabels(2,250:263) = 'ROF_5';
        
        stimfirstlabels(1,264:278) = 'ROF_5';
        stimfirstlabels(2,264:278) = 'ROF_6';
        
        stimfirstlabels(1,279:293) = 'ROF_6';
        stimfirstlabels(2,279:293) = 'ROF_7';
        
        stimfirstlabels(1,294:306) = 'ROF_7';
        stimfirstlabels(2,294:306) = 'ROF_8';
        
        stimfirstlabels(1,307:323) = 'L MH_2';
        stimfirstlabels(2,307:323) = 'L MH_3';
        
        stimfirstlabels(1,324:336) = 'L MH_3';
        stimfirstlabels(2,324:336) = 'L MH_4';
        
        stimfirstlabels(1,337:350) = 'L MH_4';
        stimfirstlabels(2,337:350) = 'L MH_5';
        
        stimfirstlabels(1,351:362) = 'L MH_5';
        stimfirstlabels(2,351:362) = 'L MH_6';
        
        stimfirstlabels(1,363:374) = 'L MH_6';
        stimfirstlabels(2,363:374) = 'L MH_7';
        
        stimfirstlabels(1,375:386) = 'L MH_7';
        stimfirstlabels(2,375:386) = 'L MH_8';
        
        stimfirstlabels(1,387:400) = 'L MH_8';
        stimfirstlabels(2,387:400) = 'LPO_1';
        
        
        
    case 'P07' % 0303
        clear stimfirstlabels;
        stimfirstlabels = strings(2,length(stimartfdefRej));
        stimfirstlabels(1,1:25) = 'RAH_2';
        stimfirstlabels(2,1:25) = 'RAH_3';
        
        stimfirstlabels(1,26:64) = 'RAH_3';
        stimfirstlabels(2,26:64) = 'RAH_4';
        
        stimfirstlabels(1,65:101) = 'RAH_4';
        stimfirstlabels(2,65:101) = 'RAH_5';
        
        stimfirstlabels(1,102:122) = 'RAH_5';
        stimfirstlabels(2,102:122) = 'RAH_6';
        
        stimfirstlabels(1,123:137) = 'RAH_6';
        stimfirstlabels(2,123:137) = 'RAH_7';
        
        stimfirstlabels(1,138:150) = 'RAH_7';
        stimfirstlabels(2,138:150) = 'RAH_8';
        
        stimfirstlabels(1,151:174) = 'RMH_2';
        stimfirstlabels(2,151:174) = 'RMH_3';
        
        stimfirstlabels(1,175:203) = 'RMH_3';
        stimfirstlabels(2,175:203) = 'RMH_4';
        
        stimfirstlabels(1,204:219) = 'RMH_4';
        stimfirstlabels(2,204:219) = 'RMH_5';
        
        stimfirstlabels(1,220:253-1) = 'RMH_5';
        stimfirstlabels(2,220:253-1) = 'RMH_6';
        
        stimfirstlabels(1,254-1:269-1) = 'RMH_7';
        stimfirstlabels(2,254-1:269-1) = 'RMH_8';
        
        stimfirstlabels(1,270-1:291-1) = 'RPH_2';
        stimfirstlabels(2,270-1:291-1) = 'RPH_3';
        
        stimfirstlabels(1,292-1:319-1) = 'RPH_3';
        stimfirstlabels(2,292-1:319-1) = 'RPH_4';
        
        stimfirstlabels(1,320-1:336-1) = 'RPH_4';
        stimfirstlabels(2,320-1:336-1) = 'RPH_5';
        
        stimfirstlabels(1,337-1:356-1) = 'RPH_5';
        stimfirstlabels(2,337-1:356-1) = 'RPH_6';
        
        stimfirstlabels(1,357-1:374-1) = 'RPH_6';
        stimfirstlabels(2,357-1:374-1) = 'RPH_7';
        
        stimfirstlabels(1,375-1:401-1) = 'R O ai_2';
        stimfirstlabels(2,375-1:401-1) = 'R O ai_3';
        
        stimfirstlabels(1,402-1:419-1) = 'R O ai_3';
        stimfirstlabels(2,402-1:419-1) = 'R O ai_4';
        
        stimfirstlabels(1,420-1:432-1) = 'R O ai_5';
        stimfirstlabels(2,420-1:432-1) = 'R O ai_6';
        
        stimfirstlabels(1,433-1:459-1) = 'R P ps_2';
        stimfirstlabels(2,433-1:459-1) = 'R P ps_3';
        
        stimfirstlabels(1,460-1:479-1) = 'R P ps_3';
        stimfirstlabels(2,460-1:479-1) = 'R P ps_4';
        
        stimfirstlabels(1,480-1:499-2) = 'R P ps_4';
        stimfirstlabels(2,480-1:499-2) = 'R P ps_5';
        
        
    case 'P082'
        % the 0706
        clear stimfirstlabels;
        stimfirstlabels = strings(2,length(stimartlabel));
        stimfirstlabels(1,1:15) = 'LAH_1';
        stimfirstlabels(2,1:15) = 'LAH_2';
        
        stimfirstlabels(1,16:30) = 'LAH_2';
        stimfirstlabels(2,16:30) = 'LAH_3';
        
        stimfirstlabels(1,31:46) = 'LAH_3';
        stimfirstlabels(2,31:46) = 'LAH_4';
        
        stimfirstlabels(1,47:63) = 'LAH_4';
        stimfirstlabels(2,47:63) = 'LAH_5';
        
        stimfirstlabels(1,64:81) = 'LAH_5';
        stimfirstlabels(2,64:81) = 'LAH_6';
        
        stimfirstlabels(1,82:97) = 'LAH_6';
        stimfirstlabels(2,82:97) = 'LAH_7';
        
        stimfirstlabels(1,98:112) = 'LAH_7';
        stimfirstlabels(2,98:112) = 'LAH_8';
        
        stimfirstlabels(1,113:132) = 'LMH_1';
        stimfirstlabels(2,113:132) = 'LMH_2';
        
        stimfirstlabels(1,133:150) = 'LMH_2';
        stimfirstlabels(2,133:150) = 'LMH_3';
        
        stimfirstlabels(1,151:167) = 'LMH_3';
        stimfirstlabels(2,151:167) = 'LMH_4';
        
        stimfirstlabels(1,168:184) = 'LMH_4';
        stimfirstlabels(2,168:184) = 'LMH_5';
        
        stimfirstlabels(1,185:200) = 'LMH_5';
        stimfirstlabels(2,185:200) = 'LMH_6';
        
        stimfirstlabels(1,201:218) = 'LMH_6';
        stimfirstlabels(2,201:218) = 'LMH_7';
        
        stimfirstlabels(1,219:234) = 'LMH_7';
        stimfirstlabels(2,219:234) = 'LMH_8';
        
        stimfirstlabels(1,235:253) = 'LPH_1';
        stimfirstlabels(2,235:253) = 'LPH_2';
        
        stimfirstlabels(1,254:268) = 'LPH_2';
        stimfirstlabels(2,254:268) = 'LPH_3';
        
        stimfirstlabels(1,269:284) = 'LPH_3';
        stimfirstlabels(2,269:284) = 'LPH_4';
        
        stimfirstlabels(1,285:301) = 'LPH_4';
        stimfirstlabels(2,285:301) = 'LPH_5';
        
        stimfirstlabels(1,302:318) = 'LPH_5';
        stimfirstlabels(2,302:318) = 'LPH_6';
        
        stimfirstlabels(1,319:335) = 'LPH_6';
        stimfirstlabels(2,319:335) = 'LPH_7';
        
        stimfirstlabels(1,336:355) = 'LPH_7';
        stimfirstlabels(2,336:355) = 'LPH_8';
        
    case 'P08' %% 0606 variable
        clear stimfirstlabels;
        stimfirstlabels = strings(2,length(stimartlabel));
        stimfirstlabels(1,1:15) = 'RAH_1';
        stimfirstlabels(2,1:15) = 'RAH_2';
        
        stimfirstlabels(1,[16:30, 137:153]) = 'RAH_2';
        stimfirstlabels(2,[16:30, 137:153]) = 'RAH_3';
        
        stimfirstlabels(1,31:52) = 'RAH_3';
        stimfirstlabels(2,31:52) = 'RAH_4';
        
        stimfirstlabels(1,53:68) = 'RAH_4';
        stimfirstlabels(2,53:68) = 'RAH_5';
        
        stimfirstlabels(1,69:84) = 'RAH_5';
        stimfirstlabels(2,69:84) = 'RAH_6';
        
        stimfirstlabels(1,85:101) = 'RAH_6';
        stimfirstlabels(2,85:101) = 'RAH_7';
        
        stimfirstlabels(1,102:118) = 'RAH_7';
        stimfirstlabels(2,102:118) = 'RAH_8';
        
        stimfirstlabels(1,119:136) = 'RMH_1';
        stimfirstlabels(2,119:136) = 'RMH_2';
        
        stimfirstlabels(1,154:172) = 'RMH_2';
        stimfirstlabels(2,154:172) = 'RMH_3';
        
        stimfirstlabels(1,173:187) = 'RMH_3';
        stimfirstlabels(2,173:187) = 'RMH_4';
        
        stimfirstlabels(1,188:204) = 'RMH_4';
        stimfirstlabels(2,188:204) = 'RMH_5';
        
        stimfirstlabels(1,205:222) = 'RMH_5';
        stimfirstlabels(2,205:222) = 'RMH_6';
        
        stimfirstlabels(1,223:237) = 'RMH_6';
        stimfirstlabels(2,223:237) = 'RMH_7';
        
        stimfirstlabels(1,238:254) = 'RMH_7';
        stimfirstlabels(2,238:254) = 'RMH_8';
        
        stimfirstlabels(1,255:270) = 'RPH_1';
        stimfirstlabels(2,255:270) = 'RPH_2';
        
        stimfirstlabels(1,271:285) = 'RPH_2';
        stimfirstlabels(2,271:285) = 'RPH_3';
        
        stimfirstlabels(1,286:300) = 'RPH_3';
        stimfirstlabels(2,286:300) = 'RPH_4';
        
        stimfirstlabels(1,301:317) = 'RPH_4';
        stimfirstlabels(2,301:317) = 'RPH_5';
        
        stimfirstlabels(1,318:333) = 'RPH_5';
        stimfirstlabels(2,318:333) = 'RPH_6';
        
        stimfirstlabels(1,334:352) = 'RPH_6';
        stimfirstlabels(2,334:352) = 'RPH_7';
        
        stimfirstlabels(1,353:369) = 'RPH_7';
        stimfirstlabels(2,353:369) = 'RPH_8';
    case 'P09'
        clear stimfirstlabels;
        stimfirstlabels = strings(2,length(stimartlabel));
        stimfirstlabels(1,1:20) = 'LAH_1';
        stimfirstlabels(2,1:20) = 'LAH_2';
        
        stimfirstlabels(1,21:37) = 'LAH_2';
        stimfirstlabels(2,21:37) = 'LAH_3';
        
        stimfirstlabels(1,38:53) = 'LAH_3';
        stimfirstlabels(2,38:53) = 'LAH_4';
        
        
        stimfirstlabels(1,54:68) = 'LAH_4';
        stimfirstlabels(2,54:68) = 'LAH_5';
        
        stimfirstlabels(1,69:84) = 'LAH_5';
        stimfirstlabels(2,69:84) = 'LAH_6';
        
        stimfirstlabels(1,85:121) = 'LAH_7';
        stimfirstlabels(2,85:121) = 'LAH_8';
        
        stimfirstlabels(1,122:137) = 'LMH_1';
        stimfirstlabels(2,122:137) = 'LMH_2';
        
        stimfirstlabels(1,138:151) = 'LMH_2';
        stimfirstlabels(2,138:151) = 'LMH_3';
        
        stimfirstlabels(1,152:167) = 'LMH_3';
        stimfirstlabels(2,152:167) = 'LMH_4';
        
        stimfirstlabels(1,168:184) = 'LMH_4';
        stimfirstlabels(2,168:184) = 'LMH_5';
        
        stimfirstlabels(1,185:204) = 'LMH_5';
        stimfirstlabels(2,185:204) = 'LMH_6';
        
        stimfirstlabels(1,205:226) = 'LMH_6';
        stimfirstlabels(2,205:226) = 'LMH_7';
        
        stimfirstlabels(1,227:237) = 'LMH_7';
        stimfirstlabels(2,227:237) = 'LMH_8';
        
        stimfirstlabels(1,238:260) = 'LPH_1';
        stimfirstlabels(2,238:260) = 'LPH_2';
        
        stimfirstlabels(1,261:281) = 'LPH_3';
        stimfirstlabels(2,261:281) = 'LPH_4';
        
        stimfirstlabels(1,282:295) = 'LPH_4';
        stimfirstlabels(2,282:295) = 'LPH_5';
        
        stimfirstlabels(1,296:311) = 'LPH_5';
        stimfirstlabels(2,296:311) = 'LPH_6';
        
        stimfirstlabels(1,312:326) = 'LPH_6';
        stimfirstlabels(2,312:326) = 'LPH_7';
        
        stimfirstlabels(1,327:341) = 'LPH_7';
        stimfirstlabels(2,327:341) = 'LPH_8';
        
        stimfirstlabels(1,342:359) = 'LPHG_1';
        stimfirstlabels(2,342:359) = 'LPHG_2';
        
        stimfirstlabels(1,360:376) = 'LPHG_2';
        stimfirstlabels(2,360:376) = 'LPHG_3';
        
        stimfirstlabels(1,377:392) = 'LPHG_3';
        stimfirstlabels(2,377:392) = 'LPHG_4';
        
        stimfirstlabels(1,393:408) = 'LPHG_4';
        stimfirstlabels(2,393:408) = 'LPHG_5';
        
        stimfirstlabels(1,409:428) = 'LPHG_5';
        stimfirstlabels(2,409:428) = 'LPHG_6';
        
        stimfirstlabels(1,429:443) = 'LPHG_6';
        stimfirstlabels(2,429:443) = 'LPHG_7';
        
        stimfirstlabels(1,444:445) = 'LPHG_7';
        stimfirstlabels(2,444:445) = 'LPHG_8';
        
end
