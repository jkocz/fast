% recombine .m
% 
%tic



ch = 26;
freq_ch = 512;
% 
 S_new = S26;
%S_new = SX;
% 
tmp = 0;
% 
u_tmp = zeros(ch,ch);
s_tmp = zeros(ch,ch);
v_tmp = zeros(ch,ch);
% 
recombined_26 = zeros(ch,ch,freq_ch);

for j=1:freq_ch
    tmp = 0;
    for i=3:ch
        tmp = tmp + S26(j,i,i);
    end
    tmp = tmp / (ch-2);

     S_new(j,1,1) = tmp;
     S_new(j,2,2) = tmp;

end

for j=1:freq_ch
    for ia=1:ch
        for ib=1:ch
            u_tmp(ia,ib) = U26(j,ia,ib);
            s_tmp(ia,ib) = S_new(j,ia,ib);
            v_tmp(ia,ib) = V26(j,ia,ib);

        end
    end
    recombined_26(:,:,j) = (u_tmp*s_tmp*v_tmp');
end


