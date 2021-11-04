function zeta = getZenithAngle(lat, delta, varphi)
    zeta = acosd(sind(lat) * sind(delta) + cosd(lat) * cosd(delta) * cosd(varphi));
    if zeta > 90
        zeta = 90;
    end
end