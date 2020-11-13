rng(5);
n_values = [5 10 20 40 60 80 100 500 10^3 10^4]; % values of n
mu = 10; % true mean
std = 4; % true standard deviation

% the three matrices below store the boxplot values
% the first coordinate refers to the sample number
% while the second coordinate is the index of the current n value
mle_bx = zeros(100, length(n_values));
map1_bx = zeros(100, length(n_values));
map2_bx = zeros(100, length(n_values));

% parameters of the gaussian we use for the prior
mu_p = 10.5;
std_p = 1;

for k=1:length(n_values)
   n = n_values(k); % choose n
   for m=1:100
      data = mu + std*randn(n,1); % this will transform the standard normal
      % into the required normal distribution
      
      mle = sum(data)/n; % mean mle estimate, derivation in report
      map1 = ((mle)*std_p^2 + mu_p*(std^2/n))/(std_p^2 + (std^2/n));
      % above is the expression for the MAP using gaussian prior.
      % Derivation in report
      
     
      map2 = mle; % the MAP using uniform prior in most cases is the MLE
      if map2 <= 9.5 % but if it goes below the lower limit then
          map2 = 9.5; % the lower limit is the MAP. Proof in report
      end
      
      if map2 >= 11.5
          map2 = 11.5; % same for upper limit
      end
          
      mle_bx(m, k) = abs(mle-mu)/mu;
      map1_bx(m, k) = abs(map1-mu)/mu;
      map2_bx(m, k) = abs(map2-mu)/mu; 
      % above stores the values
   end
    
end

figure;
axis equal;
boxplot(mle_bx, 'Labels', {'5','10', '20', '40','60', '80', '100', '500', '10^3', '10^4'});
xlabel("N");
ylabel("Relative error for MLE Estimate");

figure;
axis equal;
boxplot(map1_bx, 'Labels', {'5','10', '20', '40','60', '80', '100', '500', '10^3', '10^4'});
xlabel("N");
ylabel("Relative error for MAP1 Estimate");

figure;
axis equal;
boxplot(map2_bx, 'Labels', {'5','10', '20', '40','60', '80', '100', '500', '10^3', '10^4'});
xlabel("N");
ylabel("Relative error for MAP2 Estimate");