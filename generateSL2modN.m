% Michelle Bergeron - Mathematics Capstone, Spring 2014 
%
% Generates the set of matrices that satisfy SL2 (mod n), given n. 
% SL2 (mod n) is defined as matrices with entries mod n with 
% non-zero determinants.
%
% Parameters: n - Desired modulus
% 
% Return: The matrices in SL2(mod n) 
function SL2modN = generateSL2modN(n)
    % We don't know how many matrices there will be
    unknown = 0; 
    SL2modN = zeros(2,2,unknown);
    i = 1;
    % The McCabe's complexity of this function is too damn high
    for a = 0:(n-1)
        for b = 0:(n-1)
            for c = 0:(n-1)
                for d = 0:(n-1)
                    currentMat = [a b; c d];
                    if (mod(det(currentMat), n) ~= 0) 
                        SL2modN(:, :, i) = currentMat;
                        i = i+1; 
                    end
                end
            end
        end
    end
end % wheeee