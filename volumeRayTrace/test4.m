function test
    clear
    close all
    
    maxDepth = 1000;
    x = zeros(maxDepth, 2);
    w = zeros(maxDepth, 2);



    %%
    sigmaT_resolution = 320;
%     sigmaT = peaks(sigmaT_resolution)+peaks(sigmaT_resolution)';
%     sigmaT(sigmaT<0) = -sigmaT(sigmaT<0);
%     sigmaT = sigmaT * 0.5;
%     sigmaT(sigmaT<0.5) = 4-sigmaT(sigmaT<0.5);    
    %%
    sigmaT = rand(sigmaT_resolution,sigmaT_resolution)*6;

    
    %%    
    % down sample
    windowsizeList = [1,2,5,10,20,40];
    figure;
    flag = 0;
    for windowsize = windowsizeList
        flag = flag + 1
        window = ones(windowsize,windowsize)/(windowsize*windowsize);
        sigmaT_d = conv2(sigmaT,window,'valid');
        sigmaT_d = sigmaT_d(1:windowsize:end,1:windowsize:end);
        std_d = std(sigmaT_d(:));
        
        subplot(3,6,flag);
        imagesc(sigmaT_d)
        colorbar
        axis equal
        axis off
        title(['std:' num2str(std_d) ' samples: ' num2str(sigmaT_resolution/windowsize) ' by ' num2str(sigmaT_resolution/windowsize)]);
        
        
        fft_d = log(abs(fftshift(fft2(sigmaT_d)))+1);
        fft_mean_d = mean(fft_d(:));

        subplot(3,6,flag+6)
        imagesc(fft_d);
        colorbar
        axis equal
        axis off
        title(['fft:' num2str(fft_mean_d)])
        
    %%    
        y = [];

        for samples = 1: 200000
            
            x(1,:) = [rand,1];
            w(1,:) = [0,1];
            w(2:end,:) = [];
            x(2:end,:) = [];

            for dep = 1 : maxDepth - 1
                c = round((1-x(dep,2))*size(sigmaT_d,1));
                r = round(x(dep,1)*size(sigmaT_d,2));
                c(c==0)=1;r(r==0)=1;
                t = -log(rand)/sigmaT_d(c,r);
                x1 = x(dep, :) - t*w(dep, :);
                if x1(1) < 0.0 || x1(1) > 1.0 || x1(2) < 0.0 || x1(2) > 1.0
                    y = [y; x(1:dep-1, :)];
                    break;
                end
                theta = 2*pi*rand;
                w(dep + 1,:) = [cos(theta),sin(theta)];
                x(dep + 1,:) = x1;
            end
%             y = [y; x(end,:)];
        end

        % density map
        mapSize = 64;
        densityMap = zeros(mapSize,mapSize);
        for i = 1: size(y,1)
            c = round((1-y(i,2))*mapSize);
            r = round(y(i,1)*mapSize);
            c(c==0)=1;r(r==0)=1;
            densityMap(c, r) = densityMap(c, r) + 1;
        end

%         densityMap = conv2(densityMap, ones(10,10));
%         subplot(3,6,flag+6)
%         imagesc(densityMap)
%         colorbar
%         axis equal
%         axis off
%         title(['mean:' num2str(mean(densityMap(:)))])
        
        
        densityMap = log(densityMap+1);
        subplot(3,6,flag+12)
        imagesc(densityMap)
        colorbar
        axis equal
        axis off      
        title(['mean:' num2str(mean(densityMap(:)))])
    end
end
