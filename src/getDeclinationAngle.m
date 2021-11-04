function [delta, jTransit] = getDeclinationAngle(date, lon)

    jDate       = juliandate(date);
    n           = ceil(jDate - 2451545.0 + 0.0008);
    jStar       = n - lon / 360;
    M           = mod(357.5291 + 0.98560028 * jStar, 360);
    C           = 1.9148 * sind(M) + 0.0200 * sind(2 * M) + 0.0003 * sind(3 * M);
    lambda      = mod(M + C + 180 + 102.9372, 360);
    
    jTransit    = 2451545.0 + jStar + 0.0053 * sind(M) - 0.0069 * sind(2 * lambda);
    delta       = asind(sind(lambda) * sind(23.44));
    
end