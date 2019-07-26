function q_learning_D2D(dtx,dty,drx,dry,cx,cy)

Nu=length(dtx);
%%%%% Learning Parameters
alpha=0.5;  %%%% Learning rate
epsilon=0.1;    %%%% Exploration probability
gamma=0.5;      %%%% Discount fatcor

state=[0,1];
action=2:22; %%%Power in dBm
Q=zeros(length(state),length(action),Nu);
K=1000; %% maximum number of iterations
state_idx=1;
action_idx=zeros(1,Nu);
for k=1:K
    display(['iteration = ' num2str(k)]);
    r=rand(1);
    for j=1:Nu 
        if r<epsilon
            current_action=datasample(action,1);
        else
            [~,umax]=max(Q(state_idx,:,j));
            current_action=action(umax);
        end
        action_idx(j)=find(action==current_action); %%% Finding the index of the current action
    end
    [next_state, next_reward]=learning_model(action_idx,dtx,dty,drx,dry,cx,cy);
    next_state_idx=find(state==next_state);
    Reward=sum(next_reward);
    % print the results in each iteration
    disp(['current state : ' num2str(state(state_idx)) ' next state : ' num2str(state(next_state_idx)) ' taken action : ' num2str(action(action_idx))]);
    disp([' next reward : ' num2str(Reward)]);
    % Update Q-Table
    for j=1:Nu
        Q(state_idx,action_idx(j),j)=max(Q(state_idx,action_idx(j),j), (next_reward(j)+gamma*max(Q(next_state_idx,:,j))));
    end
    state_idx=next_state_idx;
end
end
function [next_state,next_reward]=learning_model(x,dtx,dty,drx,dry,cx,cy)

    [BI,DI]=SINR(action(x),dtx,dty,drx,dry,cx,cy);
    C=1/80;
    QoS=6;
    if BI>=QoS
        next_state=1;
        next_reward=C*log2(1+DI);
    else
        next_state=0;
        next_reward=-1;
    end
end