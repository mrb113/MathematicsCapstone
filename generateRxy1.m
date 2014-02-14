% Generates R[x, y]_1 
% Parameter: n - modulus
function Rxy1 = generateRxy1(n)
    syms x y; 
    c = coeffs(expand((x + y)));
    c = zeros(size(c)); 
    Rxy1 = zeros(length(c),2^(2));
    
    index = 1;
    for i = 1:size(c)
        for j = 0:(n-1)
            for k = 0:(n-1)                    
                c = [j k];
                Rxy1(:,index) = c;
                index = index+1;             
            end
        end
    end
end