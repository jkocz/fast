function plotter(type,start_lim,end_lim,curr_matrix,xlength)

% plotter.m
%
% function plotter(type,start limit, end limit, matrix)
% 
% This function reads in a value and plots a corresponding set of plots
%
% type '1' = magnitude of xcorr matrix
% type '2' = phase of xcorr matrix
% type '3' = eigenvalues
% type '4' = eigenvalues on 1 plot
% type '5' = autocorr on 1 plot
% type '6' = xcorr on 1 plot
% type '7' = magnitude of xcorr matrix line
% type '8' = phase of xcorr matrix line
% type '9' = single phase
% type '10' = eigenVECTORs on several subplots

lim_range = (end_lim - start_lim) + 1;

xrange = xlength;

if (type == 1)
    % plot the magnitudes of the xcorr matrix
    figure;
    k=0;
    for i=start_lim:end_lim
        for j=start_lim:end_lim
            k=k+1;
            subplot(lim_range,lim_range,k);
            xlim([0 xrange]);
%            ylim([-6 1.5]);
            hold;
            mag = sqrt(  (real(squeeze(curr_matrix(i,j,2:xrange))).^2)+(imag(squeeze(curr_matrix(i,j,2:xrange))).^2)  );
            plot(10.*log(mag));
        end
    end

elseif (type == 2)
    % plot the phases on the xcorr matrix
    figure;
    k=0;
    for i=start_lim:end_lim
        for j=start_lim:end_lim
            k=k+1;
            subplot(lim_range,lim_range,k);
            xlim([0 xrange]);
            hold;
            phase = atan2(imag(squeeze(curr_matrix(i,j,2:xrange))),real(squeeze(curr_matrix(i,j,2:xrange))));
            plot(phase,'.');
        end
    end
elseif (type == 3) 
    % plot the S values on different plots
    figure;
    k=0;
    for i=start_lim:end_lim
        k=k+1;
        subplot(7,4,k);
        xlim([0 xrange]);
        hold on;
        plot(curr_matrix(2:xrange,i,i));
    end        
elseif (type == 4)
    % plot the S values on the same plot
    figure;
    ylabel('Power (10*log)');
    xlabel('Freq (CH)');
    hold on;
    for i=start_lim:end_lim
        if (i==1)            
            plot(10*log(curr_matrix(2:xrange,i,i)),'r');
        elseif (rem(i,2) == 0)
            plot(10*log(curr_matrix(2:xrange,i,i)),'b');
        else
            plot(10*log(curr_matrix(2:xrange,i,i)),'g');
        end
    end
elseif (type == 5)
    figure;
    ylabel('Power [dB]');
    xlabel('Freq (CH)');
    hold on;
    for i=start_lim:end_lim
        mag = sqrt(  (real(squeeze(curr_matrix(i,i,2:xrange))).^2)+(imag(squeeze(curr_matrix(i,i,2:xrange))).^2)  );
        if (rem(i,2) == 0)
            plot(10*log(mag),'b');
        else
            plot(10*log(mag),'r');
        end
    end
elseif (type == 6)
    figure;
    ylabel('Power [dB]');
    xlabel('Freq (CH)');
    hold on;
    for i=start_lim:end_lim
        mag = sqrt(  (real(squeeze(curr_matrix(start_lim,i,2:xrange))).^2)+(imag(squeeze(curr_matrix(start_lim,i,2:xrange))).^2)  );
        if (rem(i,2) == 0)
            plot(log(mag),'g');
        else
            plot(log(mag),'b');
        end
    end
elseif (type == 7)
    figure;
    k=0;
    for zz = start_lim:end_lim
        for i=1:28
            k=k+1;
            subplot(lim_range,28,k);
            xlim([0 xrange]);
            hold;
            mag = sqrt(  (real(squeeze(curr_matrix(zz,i,2:xrange))).^2)+(imag(squeeze(curr_matrix(zz,i,2:xrange))).^2)  );
            plot(mag);
        end
    end
elseif (type == 8)
    figure;
    k=0;
    for i=1:end_lim
           k=k+1;
            subplot(1,28,k);
            xlim([0 xrange]);
            hold on;
            phase = atan2(imag(squeeze(curr_matrix(start_lim,i,2:xrange))),real(squeeze(curr_matrix(start_lim,i,2:xrange))));
            plot(phase,'.');
   
    end
elseif (type == 9)
    figure;
    hold;
    phase = atan2(imag(squeeze(curr_matrix(start_lim,end_lim,2:xrange))),real(squeeze(curr_matrix(start_lim,end_lim,2:xrange))));
    plot(phase,'.');
elseif (type == 10)
    figure;
    k=0;
    for i=start_lim:end_lim
        k=k+1;
        subplot(8,8,k);
        xlim([0 xrange]);
        hold;
        plot(abs(curr_matrix(:,k,1)));
    end    
end
    
