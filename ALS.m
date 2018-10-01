function [U,V_T] = ALS(X,k,lamda_u,lamda_v)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[N,M] = size(X);

rand('seed', 1);
U = rand(N,k);
rand('seed', 1);
V = rand(M,k);
V_T = V';

[I,J] = find(X>-1);

[loss,rmsloss] = calculateLoss(I,J,X,U,V_T,lamda_u,lamda_v);
prev_loss = loss + 100;

iteration = 0;
while(prev_loss - loss > 0.00001 && iteration<100)
    for j=1:M  
        sum1 = zeros(k,k);
        sum2 = zeros(k,1);
        F = find(J==j);
        [d,~] = size(F);
        for t=1:d
            p = F(t,1);
            i = I(p,1);
            x = X(i,j);
            u_n = U(i,:);
            sum1 = sum1 + u_n'*u_n;
            sum2 = sum2 + x*u_n';
        end
        sum1 = sum1 + lamda_v*eye(k);
        V_T(:,j) = inv(sum1)*sum2;
    end
    
    
    for i=1:N
        sum1 = zeros(k,k);
        sum2 = zeros(k,1);
        F = find(I==i);
        [d,n] = size(F);
        for t=1:d
            p = F(t,n);
            j = J(p,1);
            x = X(i,j);
            v_m = V_T(:,j);
            sum1 = sum1 + v_m*v_m' ;
            sum2 = sum2 + x*v_m;
        end
     sum1 = sum1 + lamda_u*eye(k); 
     u_n = inv(sum1)*sum2;
     U(i,:) = u_n';
    end
    
    prev_loss = loss;
    [loss,rmsloss] = calculateLoss(I,J,X,U,V_T,lamda_u,lamda_v);
    iteration = iteration + 1;
        
end

disp("train rmsloss is");
disp(rmsloss);


