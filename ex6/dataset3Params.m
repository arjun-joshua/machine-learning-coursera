function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
Ctry = logspace(-2,log10(30),8);%assign values to trial values of C and sigma
sigmaTry = logspace(-2,log10(30),8);

predErr = zeros(length(Ctry),length(sigmaTry));%initialize matrix of prediction errors

for i = 1:length(Ctry)%Calculate prediction error matrix on cross-validation set
    for j = 1:length(sigmaTry)
        %Train model on training set
        model= svmTrain(X, y, Ctry(i), @(x1, x2) gaussianKernel(x1, x2, sigmaTry(j)));
        
        %Calculate error on cross validation set
        pred = svmPredict(model, Xval);
        predErr(i,j) = mean(double(pred ~= yval));
    end
end

[minPredErr,I] = min(predErr(:));%find indices of prediction matrix corresponding to
[I_row,I_col] = ind2sub(size(predErr),I);%minimum error

C = Ctry(I_row);
sigma = sigmaTry(I_col);







% =========================================================================

end
