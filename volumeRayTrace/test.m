clear
close all


figure;
sigmaT_list = [0.1:0.1:0.9];
% sigmaT_list = [1:0.5:5];

for index = 1:length(sigmaT_list)
    
    sigmaT = sigmaT_list(index)
    
    d = 1;

    x(1,:) = [0,0];
    w(1,:) = [cos(0.8),sin(0.8)];

    for samples = 1: 5000

        pathDepth = 1;
        t = 0;
        while(t<d)
            t = -log(rand)/sigmaT;
            theta = 2*pi*rand;
            w(pathDepth+1,:) = [cos(theta),sin(theta)];
            x(pathDepth+1,:) = x(pathDepth,:) - t * w(pathDepth,:);
            pathDepth = pathDepth+1;
        end
        y(samples,:) = x(end,:); % save final position of each path
        x(2:end,:) = [];
        w(2:end,:) = [];
    end

    subplot(3,3,index);  
    plot(y(:,1),y(:,2),'b.');hold on
    plot(x(1,1),x(1,2),'ro');
    quiver(x(1,1),x(1,2),w(1,1),w(1,2),5,'r','MaxHeadSize',1);hold off
    axis([-10 10 -10 10])
    title(['d=' num2str(d) ' sigmaT=' num2str(sigmaT)])
    

end