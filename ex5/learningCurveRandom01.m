function [error_train, error_val] = ...
    learningCurve(X, y, Xval, yval, lambda)
%Modified learningCurveRandom.m code to randomly select training and validation examples
%that are unique combinations (and not permutations of the same combination, as allowed in 
%learningCurveRandom.m

%BUG: combnk(x,y) becomes too slow for x>15 and y~x/2. Replace with faster combinator.m 
%from fileExchange or use learningCurveRandom.m since very quickly the number of combinations
%themselves exceed 50 and the random permutation used in learningCurveRandom.m is less likely
%to permute the same combination.

% Max number of combinations allowed to keep run speed reasonably fast
nMaxCombos = 50;

% Number of training examples
m = size(X, 1);

% You need to return these values correctly
error_train = zeros(m, 1);
error_val   = zeros(m, 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return training errors in 
%               error_train and the cross validation errors in error_val. 
%               i.e., error_train(i) and 
%               error_val(i) should give you the errors
%               obtained after training on i examples.
%
% Note: You should evaluate the training error on the first i training
%       examples (i.e., X(1:i, :) and y(1:i)).
%
%       For the cross-validation error, you should instead evaluate on
%       the _entire_ cross validation set (Xval and yval).
%
% Note: If you are using your cost function (linearRegCostFunction)
%       to compute the training and cross validation error, you should 
%       call the function with the lambda argument set to 0. 
%       Do note that you will still need to use lambda when running
%       the training to obtain the theta parameters.
%
% Hint: You can loop over the examples with the following:
%
%       for i = 1:m
%           % Compute train/cross validation errors using training examples 
%           % X(1:i, :) and y(1:i), storing the result in 
%           % error_train(i) and error_val(i)
%           ....
%           
%       end
%

% ---------------------- Sample Solution ----------------------
mVal = size(Xval,1);
%for i = 1:m
%    theta = trainLinearReg(X(1:i,:), y(1:i), lambda);
%    error_train(i) = linearRegCostFunction( X(1:i,:), y(1:i), theta, 0 );
%    error_val(i) = linearRegCostFunction( Xval, yval, theta, 0);
%end

for i = 1:m
    combTrain = combnk(1:m,i); nCombTrain = size(combTrain,1);
    combVal = combnk(1:mVal,i); nCombVal = size(combVal,1);
    if nCombTrain > nMaxCombos
       combTrain = combTrain(randperm(nCombTrain,nMaxCombos),:);
       nCombTrain = nMaxCombos;
    end
    if nCombVal > nCombTrain
       combVal = combVal(randperm(nCombVal,nCombTrain),:);
       nCombVal = nCombTrain;
    end
    if nCombVal < nCombTrain
       combVal = combVal(rem(1:nCombTrain,nCombVal)+1,:);
       nCombVal = nCombTrain;
    for j = 1:nCombTrain
        theta = trainLinearReg(X(combTrain(j,:),:), y(combTrain(j,:)), lambda);
        error_train(i) = error_train(i) + linearRegCostFunction( X(combTrain(j,:),:), y(combTrain(j,:)), theta, 0 );
        error_val(i) = error_val(i) + linearRegCostFunction( Xval(combVal(j,:),:), yval(combVal(j,:)), theta, 0);
    end
    error_train(i) = error_train(i)/nCombTrain;
    error_val(i) = error_val(i)/nCombVal;
end



% -------------------------------------------------------------

% =========================================================================

end
