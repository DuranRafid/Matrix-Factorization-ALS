function [loss,rmsloss] = calculateLoss(I,J,X,U,V_T,lamda_u,lamda_v)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
rmsloss = 0;
[d,n] = size(I);
for t=1:d 
        i = I(t,n);
        j = J(t,n);
        x = X(i,j);
        val = U(i,:)*V_T(:,j);
        rmsloss = rmsloss + (x - val)^2;
end
square_U = U.^2;
square_V = V_T.^2;
loss = rmsloss + lamda_u*sum(square_U(:)) + lamda_v*sum(square_V(:));
rmsloss = sqrt(rmsloss/d);
end

