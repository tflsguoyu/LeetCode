function test
clear;

for i = 1:8
    x(i) = 10^i;
    d(i) = randNumber(x(i),50);
end

semilogx(x,d,'o-');axis on;
guoyu = 1;


function deep = randNumber(N_global, seedStart)


L_global = 0;
R_global = 1;

a_global = 0.4;
b_global = 0.9;

% N_global = 200000000;
% N_global = 100;
% 
% seedStart = 100;

randNumber_global_N1 = [];

% tic
% Generate1(L_global,R_global,N_global);
% disp(['generating date time is ' num2str(toc)]);

% tic
% Generate2(L_global,R_global,N_global,100);
% disp(['generating date time is ' num2str(toc)]);
% 
% % randNumber_global_N1 = sort(randNumber_global_N1)
% % hist(randNumber_global_N1, 10)
% 
% numberOfRandNumber = 0;
% tic 
% Query1(a_global,b_global,randNumber_global_N1)
% disp(['Query time is ' num2str(toc)]);
% numberOfRandNumber
% whos randNumber_global_N1;

numberOfRandNumber = 0;
tic
deep = Query2(a_global,b_global,L_global,R_global,N_global,seedStart);
toc
numberOfRandNumber



function Generate1(L,R,N)
    
    rng(1);
    randNumber_global_N1 = L + (R-L)*rand(N,1);
    
end

function Generate2(L,R,N,nodeID)

    if N==1
        rng(mod(nodeID,2^32)+1);
        randNumber_global_N1 = [randNumber_global_N1; L+(R-L)*rand];
    else
        rng(mod(nodeID,2^32)+1);
        N0 = binornd(N, 0.5);
        if N0 == 0
            N0 = 1;
        end
        if N0 == N
            N0 = N -1;
        end
        P = (L+R)/2;
        Generate2(L,P,N0,2*nodeID);
        Generate2(P,R,N-N0,2*nodeID+1);
    end
    return;

end


function Query1(a,b,randNumber_N1)
    
    N = length(randNumber_N1);
    for i = 1:N
        thisNumber = randNumber_N1(i);
        if thisNumber>a && thisNumber<b
            numberOfRandNumber = numberOfRandNumber + 1;
        end        
    end
end

function depth = Query2(a,b,L,R,N,nodeID)
    
    if R<a || L>b
        depth = 1;
    elseif L>a && R<b
        numberOfRandNumber = numberOfRandNumber + N;
        depth = 1;
    else
        if N==1
            rng(mod(nodeID,2^32)+1);
            thisNumber = L+(R-L)*rand;
            if thisNumber>a && thisNumber<b
                numberOfRandNumber = numberOfRandNumber + 1;
            end
            depth = 1;            
        else
            rng(mod(nodeID,2^32)+1);
            N0 = binornd(N, 0.5);
            if N0 == 0
                N0 = 1;
            end
            if N0 == N
                N0 = N -1;
            end
            P = (L+R)/2;
            depth_L = Query2(a,b,L,P,N0,2*nodeID);
            depth_R = Query2(a,b,P,R,N-N0,2*nodeID+1);
            depth = max(depth_L,depth_R)+1;
        end
    end
end


end



end