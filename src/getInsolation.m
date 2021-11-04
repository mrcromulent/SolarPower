function I = getInsolation(S, sigma, beta)
    I = S .* sigma .* cosd(beta);
end

