% Generates R[x, y]_5
% Parameter: n - modulus
function Rxy5 = generateRxy5(n)
    syms x y; 
    c = coeffs(expand((x + y)^5));
    c = zeros(size(c)); 
    Rxy5 = zeros(length(c), 2^(6));    
    index = 1;
    
    % McCabe is turning in his grave
    for i = 1:size(c)
        for j = 0:(n-1)
            for k = 0:(n-1)
                for l = 0:(n-1)
                    for m = 0:(n-1) 
                        for o = 0:(n-1)
                           for p = 0:(n-1) 
                            c = [j k l m o p ];
                            Rxy5(:,index) = c;
                            index = index+1;
                           end
                        end
                    end
                end
            end
        end
    end
%     for i = 1:length(Rxy5)
%         disp(Rxy5(1, i)*x^5+ Rxy5(2, i)*x^4*y + Rxy5(3, i)*x^3*y^2 + Rxy5(4, i)*x^2*y^3 + Rxy5(5, i)*x*y^4 + Rxy5(6, i)*y^5);
%     end
end