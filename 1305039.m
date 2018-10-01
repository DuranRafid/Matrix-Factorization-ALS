TrainingSet = xlsread('ratings_train.xlsx');
ValidationMat = xlsread('ratings_validate.xlsx');

K_set = [10, 20, 40];
lamda_set = [0.01, 0.1, 1.0, 10.0];

[~,sizeK_set] = size(K_set);
[~,sizelamda_u_set] = size(lamda_set);


min = Inf;
for K_iter = 1 : 3
    for lamda_iter = 1 : 4
           k = K_set(1,K_iter)
           lamda_u = lamda_set(1,lamda_iter)
           lamda_v = lamda_u;
           [U,V_T] = ALS(TrainingSet,k,lamda_u,lamda_v);
           string = strcat('k',num2str(K_iter),'lamda',num2str(lamda_iter),'.mat');
           save(string,'V_T');
           disp('For validation');
           RMSE = calculateRMSE(V_T,ValidationMat,k,lamda_u)
           if(RMSE < min)
               min = RMSE;
               final_k = k;
               final_lamda_u = lamda_u;
               final_lamda_v = lamda_v;
           end
    end
end



