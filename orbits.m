% Michelle Bergeron - Mathematics Capstone %
% Spring 2014 %

% Runs the program
function orbits()
syms x y;
    Rxy1 = generateRxy1(2);
    Rxy2 = generateRxy2(2);
    Rxy3 = generateRxy3(2);
%     Rxy4 = generateRxy4(3); 
%     Rxy5 = generateRxy5(2); 

    SL2mod2 = generateSL2modN(2);    
    SL2mod3 = generateSL2modN(3);
    SL2mod5 = generateSL2modN(5) 
    
%     % Comment out the ones you don't want to use
% %     disp('Mapping orbits using SL2(mod 2) and R[x,y]_1:');
% %     for i = 1:length(SL2mod2)
% %         currentMat = SL2mod2(:, :, i);
% %         disp('Using matrix:');
% %         disp(currentMat);
% %         mapOrbits(currentMat, Rxy1, 1, 2); 
% %         fprintf('\n');
% %     end
%     
% %         
%     disp('Mapping orbits using SL2(mod 2) and R[x,y]_2:');
%     for i = 1:length(SL2mod2)
%         currentMat = SL2mod2(:, :, i);
%         disp('Using matrix:');
%         disp(currentMat);
%         mapOrbits(currentMat, Rxy2, 2, 2); 
%         fprintf('\n');
%     end 
%         
%     disp('Mapping orbits using SL2(mod 3) and R[x,y]_2:');
%     for i = 1:length(SL2mod3)
%         currentMat = SL2mod3(:, :, i);
%         disp('Using matrix:');
%         disp(currentMat);
%         mapOrbits(currentMat, Rxy2, 2, 3); 
%         fprintf('\n');
%     end
% % %     
%     disp('Mapping orbits using SL2(mod 2) and R[x,y]_3:');
%     for i = 1:length(SL2mod2)
%         currentMat = SL2mod2(:, :, i);
%         disp('Using matrix:');
%         disp(currentMat);
%         mapOrbits(currentMat, Rxy3, 3, 2); 
%         fprintf('\n');
%     end 
    
%     disp('Mapping orbits using SL2(mod 2) and R[x,y]_5:');
%     for i = 1:length(SL2mod2)
%         currentMat = SL2mod2(:, :, i);
%         disp('Using matrix:');
%         disp(currentMat);
%         mapOrbits(currentMat, Rxy5, 5, 2); 
%         fprintf('\n');
%     end 
%         
%     disp('Mapping orbits using SL2(mod 3) and R[x,y]_3:');
%     for i = 1:length(SL2mod3)
%         currentMat = SL2mod3(:, :, i);
%         disp('Using matrix:');
%         disp(currentMat);
%         mapOrbits(currentMat, Rxy3, 3, 3); 
%         fprintf('\n');
%     end
end

% Generates the set of matrices that satisfy SL2 (mod n), given n. 
% R[x,y]_p is defined as polynomials with powers up to p 
% with coeffiecients mod n
%
% Parameters: SL2modN - Set of matrices in SL2(mod n)
%             RxyP - Set of polynomials in R[x,y]_p
%             p - Power of R[x,y]_p
%             n - modulus
function mapOrbits(SL2modN, RxyP, p, n)
    syms x y;
    if(p == 1)
        for i = 1:length(RxyP)            
            poly = x*RxyP(1,i) + y*RxyP(2,i);
            result = multiply1(poly, SL2modN, n);
            fprintf('%s ----> %s\n', char(poly), char(result));
        end
    end
    if(p == 2)
        for i = 1:length(RxyP)            
            poly = x^2*RxyP(1,i) + x*y*RxyP(2,i) + y^2*RxyP(3,i);
            result = multiply2(poly, SL2modN, n);
            fprintf('%s ----> %s\n', char(poly), char(result));
        end
    end   
    if(p == 3)
        for i = 1:length(RxyP)            
            poly = x^3*RxyP(1,i) + x^2*y*RxyP(2,i) + y^2*x*RxyP(3,i) + y^3*RxyP(4,i);
            result = multiply3(poly, SL2modN, n);
            fprintf('%s ----> %s\n', char(poly), char(result));
        end
    end
    if(p == 5)
        for i = 1:length(RxyP)            
            poly = x^5*RxyP(1,i) + x^4*y*RxyP(2,i) + x^3*y^2*RxyP(3,i) + x^2*y^3*RxyP(4,i) + x*y^4*RxyP(5, i) + y^5*RxyP(6, i);
            result = multiply5(poly, SL2modN, n);
            fprintf('%s ----> %s\n', char(poly), char(result));
        end
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
        c = fliplr(coeffs(poly + y + x) - 1);

        % If x is being multiplied, then it's xa + yb
        % If y is being multiplied, then it's xc + yd

        % First coefficient: x
        result = result + c(1)*(x*matrix(1, 1) + y*matrix(1, 2));

        % Second coefficient: y
        result = result + c(2)*(x*matrix(2, 1) + y*matrix(2, 2));
        
        % MATLAB doesn't like supporting multivariate polynomials
        % but this persuades it to give me the coefficients I need
        resultCoeffs = coeffs(result + x + y);
        resultCoeffs = mod(resultCoeffs - 1 , n); 
        result = x*resultCoeffs(2) + y*resultCoeffs(1);
    end
end

% Helper function returns the resulting polynomial when applied 
% to the 2x2 matrix. This is for R[x, y]_2 for R (mod n)
function result = multiply2(poly, matrix, n)
    if (poly == 0)
        result = '0';
    else
        syms x y;
        result = 0; 
        c = fliplr(coeffs(poly + x^2 + x*y + y^2) - 1);

        % First coefficient: x^2
        result = c(1)*(x*matrix(1, 1) + y*matrix(1, 2))^2;

        % Second coefficient: xy
        result = result + c(2)*(((x*matrix(1, 1) + y*matrix(1, 2))) * ((x*matrix(2, 1) + y*matrix(2, 2))));
        
        % Third coefficient: y^2
        result = result + c(3)*(x*matrix(2, 1) + y*matrix(2, 2))^2;
        
        % MATLAB doesn't like supporting multivariate polynomials
        % but this persuades it to give me the coefficients I need
        resultCoeffs = coeffs(result + x^2 + x*y + y^2);
        resultCoeffs = mod(resultCoeffs -1 , n);  
        result = x^2*resultCoeffs(3) + x*y*resultCoeffs(2) + y^2* resultCoeffs(1);
    end
end

% Helper function returns the resulting polynomial when applied 
% to the 2x2 matrix. T1his is for R[x, y]_3 for R (mod n)
function result = multiply3(poly, matrix, n)
    if (poly == 0)
        result = '0';
    else
        syms x y;
        result = 0; 
        c = fliplr(coeffs(poly + x^3 + x^2*y + x*y^2 + y^3) - 1);

        % First coefficient: x^3
        result = result + c(1)*(x*matrix(1, 1) + y*matrix(1, 2))^3;

        % Second coefficient: x^2*y
        result = result + c(2)*(((x*matrix(1, 1) + y*matrix(1, 2)))^2 * ((x*matrix(2, 1) + y*matrix(2, 2))));
        
        % Third coefficient: x*y^2
        result = result + c(3)*(((x*matrix(1, 1) + y*matrix(1, 2))) * ((x*matrix(2, 1) + y*matrix(2, 2)))^2);
        
        % Fourth coefficient: y^3        
        result = result + c(4)*(x*matrix(2, 1) + y*matrix(2, 2))^3;
        
        % MATLAB doesn't like supporting multivariate polynomials
        % but this persuades it to give me the coefficients I need
        resultCoeffs = coeffs(result + x^3 + x^2*y + x*y^2 + y^3);
        resultCoeffs = mod(resultCoeffs -1 , n); 
        result = x^3*resultCoeffs(1) + x^2*y*resultCoeffs(2) + x*y^2*resultCoeffs(3) + y^3*resultCoeffs(4);
    end
end

function result = multiply5(poly, matrix, n)
    if (poly == 0)
        result = '0';
    else
        syms x y;
        result = 0; 
        c = fliplr(coeffs(poly + x^5 + x^4*y + x^3*y^2 + x^2*y^3 + x*y^4 + y^5) - 1);

        % First coefficient: x^5
        result = result + c(1)*(x*matrix(1, 1) + y*matrix(1, 2))^3;

        % Second coefficient: x^4*y
        result = result + c(2)*(((x*matrix(1, 1) + y*matrix(1, 2)))^4 * ((x*matrix(2, 1) + y*matrix(2, 2))));
        
        % Third coefficient: x^3*y^2
        result = result + c(3)*(((x*matrix(1, 1) + y*matrix(1, 2)))^3 * ((x*matrix(2, 1) + y*matrix(2, 2)))^2);
        
        % Fourth coefficient: x^2*y^3    
        result = result + c(4)*(((x*matrix(1, 1) + y*matrix(1, 2)))^2 * ((x*matrix(2, 1) + y*matrix(2, 2)))^3);
        
        % Fifth coefficient: x*y^4
        result = result + c(5)*(((x*matrix(1, 1) + y*matrix(1, 2))) * ((x*matrix(2, 1) + y*matrix(2, 2)))^4);
        
        % Sixth coefficient: y^5
        result = result + c(6)*(x*matrix(2, 1) + y*matrix(2, 2))^3;
        
        % MATLAB doesn't like supporting multivariate polynomials
        % but this persuades it to give me the coefficients I need
        resultCoeffs = coeffs(result + x^5 + x^4*y + x^3*y^2 + x^2*y^3 + x*y^4 + y^5);
        resultCoeffs = mod(resultCoeffs -1 , n); 
        result = x^5*resultCoeffs(1) + x^4*y*resultCoeffs(2) + x^3*y^2*resultCoeffs(3) + x^2*y^3*resultCoeffs(4) + x*y^4*resultCoeffs(5) + y^5*resultCoeffs(6);
    end
end