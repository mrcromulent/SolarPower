function S = getSolarRadiationFlux(alpha, kappa, Sref)
    S = Sref .* exp(- kappa ./ sind(alpha));
end