%
%
%--------------------------------------------------------------------------
% Initialise variables
%--------------------------------------------------------------------------
tic

% fil files dedispersed at 0 DM for time series flagging.
filename01 = 'B1_I_2019-06-21_02-11-18.fil.tim';
filename02 = 'B2_I_2019-06-21_02-11-18.fil.tim';
filename03 = 'B3_I_2019-06-21_02-11-18.fil.tim';
filename04 = 'B5_I_2019-06-21_02-11-18.fil.tim';
filename05 = 'B7_I_2019-06-21_02-11-18.fil.tim';
filename06 = 'B8_I_2019-06-21_02-11-18.fil.tim';
filename07 = 'B11_I_2019-06-21_02-11-18.fil.tim';
filename08 = 'B12_I_2019-06-21_02-11-18.fil.tim';

fw01 = 'B1_I_2019-06-21_02-11-18.fil.clean.tim';
fw02 = 'B2_I_2019-06-21_02-11-18.fil.clean.tim';
fw03 = 'B3_I_2019-06-21_02-11-18.fil.clean.tim';
fw04 = 'B5_I_2019-06-21_02-11-18.fil.clean.tim';
fw05 = 'B7_I_2019-06-21_02-11-18.fil.clean.tim';
fw06 = 'B8_I_2019-06-21_02-11-18.fil.clean.tim';
fw07 = 'B11_I_2019-06-21_02-11-18.fil.clean.tim';
fw08 = 'B12_I_2019-06-21_02-11-18.fil.clean.tim';


fidx(1) = fopen(filename01,'r');
fidx(2) = fopen(filename02,'r');
fidx(3) = fopen(filename03,'r');
fidx(4) = fopen(filename04,'r');
fidx(5) = fopen(filename05,'r');
fidx(6) = fopen(filename06,'r');
fidx(7) = fopen(filename07,'r');
fidx(8) = fopen(filename08,'r');

% fidr(1) = fopen(fw01,'w');
% fidr(2) = fopen(fw02,'w');
% fidr(3) = fopen(fw03,'w');
% fidr(4) = fopen(fw04,'w');
% fidr(5) = fopen(fw05,'w');
% fidr(6) = fopen(fw06,'w');
% fidr(7) = fopen(fw07,'w');
% fidr(8) = fopen(fw08,'w');

%fidw = fopen('flagfile.txt','w');

numAC = 8;
numCH = 50000;
avgFac = 32;
decomp_size = numCH;
headerSize = 367;

dataAC_int = zeros(1,numCH);
dataAC_avg_int = zeros(numAC,numCH);

num_int = 1;

for i=1:numAC     
    header = fread(fidx(i),headerSize,'int8');
end

for outL=1:num_int
    for m=1:numAC
        [dataAC_int rcount] = fread(fidx(m),numCH,'int32');
        dataAC_avg_int(m,1:rcount) = dataAC_int(1:rcount);
    end   
    xcorr_matrix = zeros(numAC,numAC,rcount);
    
    for ia=1:numAC
        for ib=ia:numAC
            xcorr_matrix(ia,ib,:) = (dataAC_avg_int(ia,1:rcount)-mean(dataAC_avg_int(ia,2:rcount))).*(dataAC_avg_int(ib,1:rcount) - mean(dataAC_avg_int(ib,2:rcount)));
        end
    end
       
    decomp_size = rcount;
    
    U = zeros(1,numAC,numAC);
    S = zeros(decomp_size,numAC,numAC);
    V = zeros(1,numAC,numAC);

    for i=1:decomp_size
        [U(1,:,:), S(i,:,:),V(1,:,:)] = svd(xcorr_matrix(:,:,i));
    end
    start_lim = 1;
    end_lim = rcount;
    flags = ones(1,(end_lim-start_lim)+1,'int8');
    k=0;

    flag_s1 = 2*mean(S(:,1,1));
    mad100 = 100*mad(S(:,numAC,numAC),0);
    mad101 = 100*mad(S(:,numAC,numAC),1);
    for i=start_lim:end_lim
        k=k+1;       
        if S(i,numAC,numAC) > mad100
            flags(k) = 0;
        elseif S(i,numAC,numAC) >  mad101
            if S(i,2,2) > flag_s1
                flags(k) = 0;
            end
            
        end
    end

%   dlmwrite('flagfile.txt',flags','newline','unix','-append');

%   for fileID=1:13
%       fwrite(fidr(fileID),dataAC_avg_int(fileID,1:rcount).*flags(1:rcount),'int8');
%   end
    toc
    
end

for i=1:numAC
    fclose(fidx(i));
end;
%fclose(fidw);