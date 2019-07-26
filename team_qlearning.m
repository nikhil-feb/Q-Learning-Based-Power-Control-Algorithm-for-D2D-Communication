function team_qlearning(A,dtx,dty,drx,dry,cx,cy)

    S=size(A);
    %%%%% Learning Parameters
    alpha=0.5;  %%%% Learning rate
    epsilon=0.9;    %%%% Exploration probability
    gamma=0.5;      %%%% Discount factor

    state=[0,1];
    Q=zeros(length(state),S(1));
    K=500; %% maximum number of iterations
    state_idx=1;
    for k=1:K
        display(['iteration = ' num2str(k)]);
        r=rand(1);
        if r<epsilon
                current_action=datasample(A,1,1);
        else
                [~,umax]=max(Q(state_idx,:));
                current_action=A(umax,:);
        end
        action_idx=find(ismember(A,current_action,'rows'),1); %%% Finding the index of the current action
        [next_state,next_reward]=learning_model(A,action_idx,dtx,dty,drx,dry,cx,cy);
        next_state_idx=find(state==next_state);
        % print the results in each iteration
        disp(['current state : ' num2str(state(state_idx)) ' next state : ' num2str(state(next_state_idx)) ' taken action : ' num2str(A(action_idx,:))]);
        disp([' next reward : ' num2str(next_reward)]);
        % Update Q-Table
        Q(state_idx,action_idx) = Q(state_idx,action_idx) + alpha * (next_reward + gamma* max(Q(next_state_idx,:)) - Q(state_idx,action_idx));
        state_idx=next_state_idx;
    end
    [~,I]=max(Q,[],2);
    optimum_power=A(I(2,1),:);
    display('Optimum Power :');
    disp(optimum_power);
end
function [next_state, next_reward]=learning_model(A,x,dtx,dty,drx,dry,cx,cy)

    P=A(x,:);
    [BI,DI]=SINR(P,dtx,dty,drx,dry,cx,cy);
    BI_dB=10^(BI/10);
    R2=sum(log2(1+DI));
    QoS=6;
    if BI_dB>=QoS
        next_reward=log2(1+BI)+R2;
        next_state=1;
    else
        next_reward=-1;
        next_state=0;
    end
end


