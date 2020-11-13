rng(5);
n_values = [5 10 20 40 60 80 100 500 10^3 10^4];

lambda = 5; % true parameter value

% the two matrices below store the boxplot values
% the first coordinate refers to the sample number
% while the second coordinate is the index of the current n value
mle_bx = zeros(100, length(n_values));
mpm_bx = zeros(100, length(n_values));

alpha = 5.5;
beta = 1;
% parameters for the prior

for k=1:length(n_values)
   n = n_values(k); % choose n
   for m=1:100
      data = -log(rand(n,1))/lambda; % transformation of the uniform RV
      
      mle = n/sum(data); % MLE estimate for lambda
      mpm = (n+alpha)/(sum(data)+beta); % Posterior Mean estimate, derived in report
     
          
      mle_bx(m, k) = abs(mle-lambda)/lambda;
      mpm_bx(m, k) = abs(mpm-lambda)/lambda;
      % store the value
      
   end
    
end

figure;
axis equal;
boxplot(mle_bx, 'Labels', {'5','10', '20', '40','60', '80', '100', '500', '10^3', '10^4'});
xlabel("N");
ylabel("Relative error for MLE Estimate");

figure;
axis equal;
boxplot(mpm_bx, 'Labels', {'5','10', '20', '40','60', '80', '100', '500', '10^3', '10^4'});
xlabel("N");
ylabel("Relative error for Posterior Mean Estimate");
