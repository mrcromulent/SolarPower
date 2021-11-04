function beta = getHeliostatTowerAngle(alpha, H, L)

    beta = 1/2 * (alpha - atand(H ./ L));
end