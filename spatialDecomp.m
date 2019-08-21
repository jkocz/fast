%function decomposition(file,pos,bits)
%
% decomposition.m
%
% This function to reads in and correlates raw 4-bit voltage data. 
% (Where each file had four streams of data)
% It then takes the singular value decomposition of the
% resulting correlation matrix.
%
% It takes three parameters.
% 1) The path of the files to be read, this should include the first part
%    of the filename. For example:
%                   /data/20040901
%    where appended to the end of 20040901 is _14, _25 and _26 for the 
%    different receivers respectively.
%
% 2) The position of the file in which to start reading data from in bits
%
% 3) The number of bits to read in from the file.
%

%--------------------------------------------------------------------------
% Initialise variables
%--------------------------------------------------------------------------
% 
% file = '../../data/99-308-064200';
% pos =0;
% bits = 1671165;
% 
% filename = sprintf('%s_14.rsp',file);
% filename2 = sprintf('%s_25.rsp',file);
% filename3 = sprintf('%s_36.rsp',file);
% 
% % the position in the file to start reading from
% %pos = pos;
% 
% % the number of bits to read
% %bits = bits;
% 
% fid = fopen(filename,'r');
% fid2 = fopen(filename2,'r');
% fid3 = fopen(filename3,'r');
% 
% %fseek(fid,pos,-1);
% %fseek(fid2,pos,-1);
% %fseek(fid3,pos,-1);
% 
% 
% 
% %--------------------------------------------------------------------------
% % decode data sets
% %--------------------------------------------------------------------------
% 
% i=1;
% k=1;
% j=1;
% disp(sprintf('Decoding data sets'));
% j=32769;
% 
% % read in the first 50 records after 32768
% % j <= 1671165  - 50
% % j <= 16416765 - 500
% % j <= 32800765 - 1000
% 
% num_avg = 50;
% 
% bit03_3 = zeros(num_avg,8192);
% bit47_3 = zeros(num_avg,8192);
% bit811_3 = zeros(num_avg,8192);
% bit1215_3 = zeros(num_avg,8192);
% 
% bit03_2 = zeros(num_avg,8192);
% bit47_2 = zeros(num_avg,8192);
% bit811_2 = zeros(num_avg,8192);
% bit1215_2 = zeros(num_avg,8192);
% 
% bit03 = zeros(num_avg,8192);
% bit47 = zeros(num_avg,8192);
% bit811 = zeros(num_avg,8192);
% bit1215 = zeros(num_avg,8192);
% 
% cprod = zeros(78,512);
% stream_fft =zeros(12,4096);
% stream_fft =zeros(12,8192);
% 
% disp(sprintf('Init complete'));
% 
% % from data 3
% 
% fread(fid3,32768,'ubit4');       
% fread(fid,32768,'ubit4');
% fread(fid2,32768,'ubit4');
% 
% 
% for j=1:num_avg
%     j
%     for k=1:8192
%         data3 = fread(fid3,1,'ubit4');
%         bit03_3(j,k) = 2.*mod(data3+8,16)-15;
%         data3 = fread(fid3,1,'ubit4');       
%         bit47_3(j,k) = 2.*mod(data3+8,16)-15;
%         data3 = fread(fid3,1,'ubit4');           
%         bit811_3(j,k) = 2.*mod(data3+8,16)-15;
%         data3 = fread(fid3,1,'ubit4');       
%         bit1215_3(j,k) = 2.*mod(data3+8,16)-15;
% 
%         data2 = fread(fid2,1,'ubit4');
%         bit03_2(j,k) = 2.*mod(data2+8,16)-15;
%         data2 = fread(fid2,1,'ubit4');       
%         bit47_2(j,k) = 2.*mod(data2+8,16)-15;
%         data2 = fread(fid2,1,'ubit4');           
%         bit811_2(j,k) = 2.*mod(data2+8,16)-15;
%         data2 = fread(fid2,1,'ubit4');       
%         bit1215_2(j,k) = 2.*mod(data2+8,16)-15;
% 
%         data = fread(fid,1,'ubit4');
%         bit03(j,k) = 2.*mod(data+8,16)-15;
%         data = fread(fid,1,'ubit4');       
%         bit47(j,k) = 2.*mod(data+8,16)-15;
%         data = fread(fid,1,'ubit4');           
%         bit811(j,k) = 2.*mod(data+8,16)-15;
%         data = fread(fid,1,'ubit4');       
%         bit1215(j,k) = 2.*mod(data+8,16)-15;
%     end
% end
%         
% fclose(fid);
% fclose(fid2);
% fclose(fid3);
% % while (j<=(bits-3)) 
% % 
% %     data3 = fread(fid3,1,'ubit4');
% %     bit03_3(i,k) = 2.*mod(data3+8,16)-15;
% %     data3 = fread(fid3,1,'ubit4');       
% %     bit47_3(i,k) = 2.*mod(data3+8,16)-15;
% %     data3 = fread(fid3,1,'ubit4');           
% %     bit811_3(i,k) = 2.*mod(data3+8,16)-15;
% %     data3 = fread(fid3,1,'ubit4');       
% %     bit1215_3(i,k) = 2.*mod(data3+8,16)-15;
% %         
% %     k=k+1;    
% %     if (mod(j,32768) == 0)
% %         i=i+1;
% %         k=1;
% %         disp(sprintf('Iteration %d',i));
% %     end    
% %     j=j+4;        
% % end       
% % 
% %data3 = 0;
% 
% % i=1;
% % k=1;
% % j=1;
% % disp(sprintf('Decoding data sets'));
% % j=32769;
% % 
% % % from data 1
% % 
% % while (j<=(bits-3)) 
% %     data = fread(fid,1,'ubit4');        
% %     bit03(i,k) = 2.*mod(data+8,16)-15;
% %     data = fread(fid,1,'ubit4');        
% %     bit47(i,k) = 2.*mod(data+8,16)-15;
% %     data = fread(fid,1,'ubit4');        
% %     bit811(i,k) = 2.*mod(data+8,16)-15;
% %     data = fread(fid,1,'ubit4');        
% %     bit1215(i,k) = 2.*mod(data+8,16)-15;
% %      
% %     k=k+1;    
% %     if (mod(j,32768) == 0)
% %         i=i+1;
% %         k=1;
% %         disp(sprintf('Iteration %d',i));
% %     end    
% %     j=j+4;        
% % end       
% % 
% % %data = 0;
% % 
% % i=1;
% % k=1;
% % j=1;
% % disp(sprintf('Decoding data sets'));
% % j=32769;
% % 
% % % from data 2
% % 
% % while (j<=(bits-3)) 
% %        
% %     data2 = fread(fid2,1,'ubit4');        
% %     bit03_2(i,k) = 2.*mod(data2+8,16)-15;
% %     data2 = fread(fid2,1,'ubit4');        
% %     bit47_2(i,k) = 2.*mod(data2+8,16)-15;
% %     data2 = fread(fid2,1,'ubit4');        
% %     bit811_2(i,k) = 2.*mod(data2+8,16)-15;
% %     data2 = fread(fid2,1,'ubit4');        
% %     bit1215_2(i,k) = 2.*mod(data2+8,16)-15;    
% %     
% %     k=k+1;    
% %     if (mod(j,32768) == 0)
% %         i=i+1;
% %         k=1;
% %         disp(sprintf('Iteration %d',i));
% %     end    
% %     j=j+4;        
% % end       
% % 
% % data2 = 0;
% 
% % we now have the decoded datasets for each polarisation of the 6 antennas
% 
% %--------------------------------------------------------------------------
% % take the fft of each of the input streams
% %--------------------------------------------------------------------------
% 
% % initialise the cprod array       
% % for l=1:512
% %     for m=1:78
% %         cprod(m,l)=0;
% %     end
% % end
% 
% for (m=1:num_avg)
% 
%     m
%     
%     stream_fft_tmp(7,:)  = fft(bit03(m,:));
%     stream_fft_tmp(8,:)  = fft(bit47(m,:));
%     stream_fft_tmp(1,:)  = fft(bit811(m,:));
%     stream_fft_tmp(2,:)  = fft(bit1215(m,:));
% 
%     stream_fft_tmp(9,:)   = fft(bit03_2(m,:));
%     stream_fft_tmp(10,:)   = fft(bit47_2(m,:));
%     stream_fft_tmp(3,:)   = fft(bit811_2(m,:));
%     stream_fft_tmp(4,:)   = fft(bit1215_2(m,:));
%     
%     stream_fft_tmp(11,:)   = fft(bit03_3(m,:));
%     stream_fft_tmp(12,:)  = fft(bit47_3(m,:));
%     stream_fft_tmp(5,:)  = fft(bit811_3(m,:));
%     stream_fft_tmp(6,:)  = fft(bit1215_3(m,:));
%     
%     % reduce numbers to keep size manageable, and remove duplicate
%     % fft information
%         
%     for j=1:12
%         for k=1:4096
%             stream_fft(j,k) = stream_fft_tmp(j,k)/1000;
%         end
%     end
%     
%     %--------------------------------------------------------------------------
%     % compute the power and cross spectra
%     %--------------------------------------------------------------------------
%     
%     iprod=0;    
%     
%     % process each channel
%     for ia=1:12    
%         for ib=ia:12
%             iprod=iprod+1;
%             for j=1:512
%                 jj=8.*(j-1);
%                 for kk=1:8
%                     cprod(iprod,j)=cprod(iprod,j) + ...
%                         stream_fft(ia,jj+kk).*conj(stream_fft(ib,jj+kk));
%                 end
%             end
%         end
%     end        
% end    
% 
% 


%--------------------------------------------------------------------------
% we now need to map cprod back to a matrix form for svd.
%--------------------------------------------------------------------------
for j=1:512
    i=1;
    for ia=1:12
        for ib=ia:12
            svd_matrix(ia,ib) = cprod(i,j);
            svd_matrix(ib,ia) = conj(cprod(i,j));
            i=i+1;
        end
    end
    
    % prior to performing SVD, modify gains on some of the terms
    % in order to make the noise levels more "even" and give
    % a more seperated decomposition.
    
    % multiply the "1" group by gain of 2
    
    ib = 1;
    for ia = 1:12
        svd_matrix(ia,ib) = (2).*(svd_matrix(ia,ib));
    end
    ia = 1;
    for ib = 1:12
        svd_matrix(ia,ib) = (2).*(svd_matrix(ia,ib));
    end
    
    % multiply the "2" group by gain of 2.8
    
    ib = 2;
    for ia = 1:12
        svd_matrix(ia,ib) = (2.8).*(svd_matrix(ia,ib));
    end
    ia = 2;
    for ib = 1:12
        svd_matrix(ia,ib) = (2.8).*(svd_matrix(ia,ib));
    end   
%     
%     % perform the sigular decomposition
     [U(j,:,:),S(j,:,:),V(j,:,:)] = svd(svd_matrix);    
 end

% save the ouput of the SVD and the original data

%save svd U S V;
%save cprod cprod;
