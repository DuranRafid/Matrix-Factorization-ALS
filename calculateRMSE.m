function [RMSE] = calculateRMSE(V_T,ValidationMat,k,lamda)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
RMSE = 0;
count = 0;
[numberofrows,~] = size(ValidationMat);

for row = 1:numberofrows
    
     sum1 = zeros(k,k);
     sum2 = zeros(k,1);
     F = find(ValidationMat(row,:)>0);
     [~,m] = size(F);
     for t=1:m
         col = F(1,t);
         x = ValidationMat(row,col);
         v_m = V_T(:,col);
         sum1 = sum1 + v_m*v_m' ;
         sum2 = sum2 + x*v_m;
     end
     sum1 = sum1 + lamda*eye(k); 
     u_n = inv(sum1)*sum2;
     validationRating = u_n' * V_T;
     
     for i=1:m
         col = F(1,t);
         actual_rate = ValidationMat(row,col);
         RMSE = RMSE + (actual_rate - validationRating(1,col))^2;
         count = count + 1;
     end
end

RMSE = sqrt(RMSE/count); 
end

