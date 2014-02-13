% TODO come up with a way to make this one function %
% Recursion?? that'll probably maybe work
function Rxy3 = generateRxy3(n)
    syms x y; 
    c = coeffs(expand((x + y)^3));
    c = zeros(size(c)); 
    Rxy3 = zeros(length(c),2^(4));    
    index = 1;
    
    % McCabe is turning in his grave
    for i = 1:size(c)
        for j = 0:(n-1)
            for k = 0:(n-1)
                for l = 0:(n-1)
                    for m = 0:(n-1)                    
                        c = [j k l m];
                        Rxy3(:,index) = c;
                        index = index+1;
                    end
                end
            end
        end
    end
end