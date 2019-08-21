% INTERFERENCE SPACE SUBTRACTION

%proj_matrix_sub = zeros(26,26,512);
%proj_matrix_sub_E = zeros(26,26,512);


pI = zeros(26,26,512);

%pIX = zeros(26,26,512);


for i=1:512
    tmp = squeeze(U26(i,:,1:2));

%%%%%%%%%%%%%%%%%%%%%%%%    
%    For replacing what was lost...
%
%    diag_sum = ((trace(squeeze(S26(i,3:26,3:26))))./24).*eye(2);
%    diag_sum = ((trace(squeeze(SI(i,3:26,3:26))))./24).*eye(2);
%
%    proj_matrix_sub(:,:,i) = tmp*(squeeze(SI(i,1:2,1:2))-diag_sum)*tmp';    
%%%%%%%%%%%%%%%%%%%%%%%

     pI(:,:,i)=tmp*tmp';

%    pn = tmp*tmp';
%    proj_matrix_sub_E(:,:,i) = pn*squeeze(norm_26(:,:,i))*pn;

 
%     tmp = squeeze(UX(i,:,1:2));
%     pIX(:,:,i)=tmp*tmp';
     
     
%     proj_matrix_subX(:,:,i) = pn*squeeze(xcorr_26(:,:,i))*pn;
     
%    zz = tmp*(squeeze(S26(i,1:2,1:2))-diag_sum)*tmp';    

%    zz = tmp*(squeeze(S26(i,1:5,1:5)))*tmp';
%    proj_matrix_i(:,:,i) = zz*squeeze(norm_26(:,:,i))*zz;

%    norm_tmp = squeeze(norm_26(:,:,i));
%    norm_tmp = norm_tmp - zz;
%    int_free(:,:,i) = norm_tmp;
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NULL SPACE PROJECTION
% 
 pn = zeros(26,26,512);
 p24 = zeros(24,24,512);
% pnX = zeros(26,26,512);
% %int_free_proj = zeros(26,26,512);
% % 
for i=1:512
%    i
    tmp = squeeze(U26(i,:,3:26));
    pn(:,:,i) = tmp*tmp';

%    tmp24 = squeeze(U24(i,:,3:24));
%    p24(:,:,i) = tmp24*tmp24';

%    pn=tmp*tmp';
%    tmp = squeeze(UX(i,:,3:26));   
%    pnX(:,:,i) = tmp*tmp';
%    int_free_proj(:,:,i) = pn*squeeze(norm_26(:,:,i))*pn;        
    
end
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


