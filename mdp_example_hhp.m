%{
Consider two simple propagations. (The number of news M = 2)
News A: 1->2->3
News B: 1->2,3
(e,f) for A in t=1,2,3
: (1, *), (2, *) ,(3, *)

(e,f) for B in t=1,2,3
: (1, *), (3, *) ,(3, *)

Budget K = 1;
%}


% State : Status of checked or not. (c1, ... ,cM) where ci is 0 or 1.
% Action : (a1, ... ,an) where ai is 0 or 1 and \sum ai = K.
% transition probability is computed by
% p_t(j|,s_t,,a) = 1 if j = s_t + a , 0 otherwise.

T = 49; % upper limit of time 
K = 2;
M = 6;
d = 0:(2^M-1);
S = de2bi(d,[],2,'left-msb'); % b: state of states
%S(i, :) == (i-1) with a form of a binary vector.

expsr = nan(M, T); % status matrix of exposure, each row denotes the news, and t-th column mean the cumulated number of exposure at time t.
flags = nan(M, T); % status matrix of exposure, each row denotes the news, and t-th column mean the cumulated number of fake-flag at time t.

%% for the simple simulation,
% expsr = [1,2,3;1,3,3];
% flags = [0,1,1;0,0,0];

expsr = [0,0,0,946,1300,1300,2840,3580,4430,5510,6620,7410,9070,9900,10700,11500,11900,12100,12500,12700,12900,13000,13200,13300,13400,13500,13500,13500,13500,13500,13500,13500,13500,13500,13500,13500,13500,13500,13500,13500,13500,13500,13500,13500,13500,13500,13500,13500,13500;0,703,703,903,1270,1870,2240,2790,3680,4010,4180,4890,4890,5220,5510,5510,6000,6000,6260,6620,6620,7090,7240,7240,7830,8120,8710,9280,9900,10600,11000,11300,11700,12200,12600,13000,13000,13200,13300,13400,13400,13400,13500,13500,13500,13500,13500,13500,13500;141,141,1060,2580,3460,4490,5210,6780,7730,8150,8970,10200,10700,10900,11700,11800,12000,12600,13000,13100,13500,13500,13500,13700,13700,13700,13900,13900,14000,14000,14000,14000,14000,14000,14000,14000,14000,14000,14000,14000,14000,14000,14000,14000,14000,14000,14000,14000,14000;187,187,903,1980,2540,3160,4100,4820,5740,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840,6840;0,1150,1550,1970,2490,2810,2940,3830,4160,4690,4880,5160,5680,6140,6460,7000,7280,7490,8100,8370,8520,8970,8970,9400,9620,9900,10200,10200,10400,10900,11100,11100,12000,12100,12500,12700,12700,13000,13100,13300,13300,13700,13700,13700,13800,13900,13900,13900,14000;186,186,897,1080,1660,2420,2780,3500,5020,5480,6940,7110,7750,9020,9690,9950,10200,10900,11500,11700,12100,12400,12600,12700,12800,12900,12900,13000,13000,13000,13200,13200,13200,13400,13400,13800,13800,13900,14000,14000,14200,14200,14300,14300,14300,14300,14300,14300,14300;194,194,194,1020,1410,2720,3280,4120,4990,5500,6330,7210,7510,7950,8820,9640,10200,10600,11000,11400,11500,11800,12300,12700,12800,12800,12800,12800,12800,12800,12800,12800,12800,12800,12800,12800,12800,12800,12800,12800,12800,12800,12800,12800,12800,12800,12800,12800,12800;0,1150,1310,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410,2410;199,199,746,1050,1820,2290,3020,4190,4710,4900,5430,6070,6680,6680,7230,8590,8890,9150,9970,10800,11600,12000,12500,12600,13400,14000,14400,14400,14400,14500,14500,14500,14500,14500,14500,14500,14500,14500,14500,14500,14500,14500,14500,14500,14500,14500,14500,14500,14500;220,816,989,1180,1750,2700,3070,4110,4770,5590,5890,6070,6530,6980,7310,7510,7800,7950,7950,8550,8830,9090,9340,9760,10200,10600,11000,12000,12000,12000,12000,12000,12000,12000,12000,12000,12000,12000,12000,12000,12000,12000,12000,12000,12000,12000,12000,12000,12000];
tmp = expsr;
expsr = tmp(1:6, :);
flags = [0,0,0,39,50,50,102,128,160,198,238,263,317,339,372,395,409,413,425,434,448,451,456,460,463,468,468,468,468,468,468,468,468,468,468,468,468,468,468,468,468,468,468,468,468,468,468,468,468;0,25,25,33,50,79,94,118,143,151,159,180,180,187,195,195,209,209,217,231,231,248,253,253,273,285,302,317,337,360,370,380,392,416,426,444,444,447,451,456,456,456,460,460,460,460,460,460,460;7,7,47,97,123,153,172,220,247,262,290,332,351,361,387,392,397,418,432,435,457,457,457,468,468,468,478,478,481,481,481,481,481,481,481,481,481,481,481,481,481,481,481,481,481,481,481,481,481;10,10,47,97,116,145,183,214,248,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293,293;0,53,74,87,105,114,120,147,158,172,174,181,190,203,214,232,241,248,269,276,282,297,297,307,312,324,331,331,346,366,374,374,400,403,420,430,430,439,443,452,452,474,474,474,477,479,479,479,482;10,10,44,50,64,97,104,124,168,178,226,232,255,290,317,327,334,356,371,380,397,411,414,418,421,427,427,430,430,430,440,440,440,448,448,466,466,472,479,479,490,490,492,492,492,492,492,492,492;7,7,7,39,53,100,119,140,161,184,203,226,236,249,278,306,327,341,358,371,372,385,406,420,428,428,428,428,428,428,428,428,428,428,428,428,428,428,428,428,428,428,428,428,428,428,428,428,428;0,60,66,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120;14,14,36,45,70,84,106,138,150,156,167,185,200,200,214,265,275,281,307,335,364,380,401,406,444,468,491,491,491,494,494,494,494,494,494,494,494,494,494,494,494,494,494,494,494,494,494,494,494;12,47,57,65,97,137,148,192,215,250,260,266,287,304,315,321,333,341,341,369,379,386,395,416,435,449,468,526,526,526,526,526,526,526,526,526,526,526,526,526,526,526,526,526,526,526,526,526,526];
tmp = flags;
flags= tmp(1:6, :);
nS = size(S,1); % == 2^M : number of the whole states.
Actions = nan(nchoosek(M,K), M); % set of actions.
nA = size(Actions,1); % == nchoosek(M,K); % number of the whole actions.
P = zeros(nS,nS, nA); %P(SxSxA) = transition probability matrix 

tmp = 0;
for i = 1:nS
    if sum(S(i,:)) == K
        tmp = tmp +1;
        Actions(tmp, :) = S(i,:);
    end
end
    
for j = 1:nS
    for a = 1:nA
        nextS = S(j,:) + Actions(a,:);
        if ~ prod(nextS < 2) % if the actions is unfeasible
            P(j,j, a) = 1; % let the state hold
%             disp([j,a])
        else
            P(j, bi2de(nextS,'left-msb') + 1, a) = 1;
        end
    end
end
% P

%   R(SxA) = reward matrix
% The reward does not depend on S but only A
% Here a in in {1, 2, ... , nchoosek(M, K)}.
RewardMatrix = zeros(nS, nA, T);
%RewardMatrix(:,:,T) = zeros(nS, nA);
for t = 1:T-1
    for j = 1:nA
        a = Actions(j,:);
        checkIdx = 1:M; 
        checkIdx = checkIdx(logical(a)); 
        for k = checkIdx
            RewardMatrix(:,j,t) = RewardMatrix(:,j,t) + (expsr(k, t+1) - expsr(k,t))*flags(k,t)*ones(nS,1);
        end
        for cc = checkIdx
            for ss = 1:nS
                if S(ss, cc) == 1
                    RewardMatrix(ss,j,t) = -100000000;
                end
            end
        end
    end
end
discount = 1;
N = T;
h = zeros(nS,1);
[V, policy, cpu_time] = mdp_finite_horizon_time(P, RewardMatrix, discount, N, h);
start = 1; %(0,0,...,0) no news is checked.
paths = nan(T,1);
paths(1) = start;
for t = 1:T-1
    paths(t+1) =  find(P(paths(t),:,policy(paths(t), t))==1);
end
optim_policy = nan(T,1);
for tt = 1:T
    optim_policy(tt) = policy(paths(tt), tt);
end
% optim_policy

decision = Actions(optim_policy, :);
CurrentState = zeros(T, M);
for t=1:T
    if t>1
        CurrentState(t,:) = CurrentState(t-1,:)  + Actions(optim_policy(t), :);
    else
        CurrentState(t,:);
    end
end
