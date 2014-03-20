% Generates R[x, y]_4
% Parameter: n - modulus
function Rxy4 = generateRxy4(n)
    syms x y; 
    c = coeffs(expand((x + y)^4));
    c = zeros(size(c)); 
    Rxy4 = zeros(length(c),2^(5));    
    index = 1;
    
    % McCabe is turning in his grave
    for i = 1:size(c)
        for j = 0:(n-1)
            for k = 0:(n-1)
                for l = 0:(n-1)
                    for m = 0:(n-1) 
                        for o = 0:(n-1)
                        c = [j k l m o];
                        Rxy4(:,index) = c;
                        index = index+1;
                        end
                    end
                end
            end
        end
    end
    for i = 1:length(Rxy4)
        disp(Rxy4(1, i)*x^4+ Rxy4(2, i)*x^3*y + Rxy4(3, i)*x^2*y^2 + Rxy4(4, i)*x*y^3 + Rxy4(5, i)*y^4);
    end
end