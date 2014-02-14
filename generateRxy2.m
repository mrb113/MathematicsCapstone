% Generates R[x, y]_2 
% Parameter: n - modulus
function Rxy2 = generateRxy2(n)
    syms x y; 
    c = coeffs(expand((x + y)^2));
    c = zeros(size(c)); 
    Rxy2 = zeros(length(c),2^(3));
    
    index = 1;
    for i = 1:size(c)
        for j = 0:(n-1)
            for k = 0:(n-1)
                for l = 0:(n-1)
                    
                    c = [j k l];
                    Rxy2(:,index) = c;
                    index = index+1;
                end
            end
        end
    end
end