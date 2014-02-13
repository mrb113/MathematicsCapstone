% Michelle Bergeron - Mathematics Capstone %
% Spring 2014 %

% TODO description
function orbits()
    syms x y;
    
    Rxy2 = generateRxy2(2)
    %for i = 1:Rxy2(
    multiply2(x^2, [0 1; 1 0], 2)
    %% TODO %%
end

% Generates the set of matrices that satisfy SL2 (mod n), given n. 
% R[x,y]_p is defined as polynomials with powers up to p 
% with coeffiecients mod n
%
% Parameters: SL2modN - Set of matrices in SL2(mod n)
%             RxyP - Set of polynomials in R[x,y]_p
% 
% Return: That's a great question, I don't know yet if it'll return
% something. We shall see.
function mapOrbits(SL2modN, RxyP)

    %% TODO %%
end

% Helper function returns the resulting polynomial when applied 
% to the 2x2 matrix. This is for R[x, y]_2 for R (mod n)
function result = multiply2(poly, matrix, n)
    if (poly == 0)
        result = 0;
    else
        syms x y;
        result = 0; 
        c = zeros(3); 
        temp = coeffs(poly); 
        for i = 1:length(temp)
           c(i) = temp(i); 
        end
        % Say I have x^2 + xy + y^2
        % This is represented by [1 1 1]
        % If x is being multiplied, then it's xa + yb
        % If y is being multiplied, then it's xc + yd

        % First coefficient: x^2
        result = result + c(1)*(x*matrix(1, 1) + y*matrix(1, 2))^2;

        % Second coefficient: xy
        result = result + c(2)*(((x*matrix(1, 1) + y*matrix(1, 2))) * ((x*matrix(2, 1) + y*matrix(2, 2))));
        
        % Third coefficient: y^2
        result = result + c(3)*(x*matrix(2, 1) + y*matrix(2, 2))^2;
        
        % MATLAB doesn't like supporting multivariate polynomials
        % but this persuades it to give me the coefficients I need
        resultCoeffs = coeffs(result + x^2 + x*y + y^2);
        resultCoeffs = mod(resultCoeffs -1 , n); 
        result = x^2*resultCoeffs(1) + x*y*resultCoeffs(2) + y^2* resultCoeffs(3);
    end
end

% Helper function returns the resulting polynomial when applied 
% to the 2x2 matrix. This is for R[x, y]_1 for R (mod n)
function result = multiply1(poly, matrix, n)
    if (poly == 0)
        result = '0';
    else
        syms x y;
        result = 0; 
        c = [0 0]; 
        temp = fliplr(coeffs(poly + y + x) - 1);
        for i = 1:length(temp)
           c(i) = temp(i); 
        end
        % If x is being multiplied, then it's xa + yb
        % If y is being multiplied, then it's xc + yd

        % First coefficient: x
        result = result + c(1)*(x*matrix(1, 1) + y*matrix(1, 2));

        % Second coefficient: y
        result = result + c(2)*(x*matrix(2, 1) + y*matrix(2, 2));
        
        % MATLAB doesn't like supporting multivariate polynomials
        % but this persuades it to give me the coefficients I need
        resultCoeffs = coeffs(result + x + y);
        resultCoeffs = mod(resultCoeffs -1 , n); 
        result = x*resultCoeffs(2) + y*resultCoeffs(1);
    end
end