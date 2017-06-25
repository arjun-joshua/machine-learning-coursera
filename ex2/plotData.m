function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%
Xpos=X(y==1,:); %pick x1 and x2 values corresponding to y=1
plot(Xpos(:,1),Xpos(:,2),'k+','LineWidth',2)

Xneg=X(y==0,:); %pick x1 and x2 values corresponding to y=0
plot(Xneg(:,1),Xneg(:,2),'ko','MarkerFaceColor','y')







% =========================================================================



hold off;

end
