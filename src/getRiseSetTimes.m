function [riseTime, setTime] = getRiseSetTimes(date, lat, lon, tz)
    phi     = lat;
    elev    = 0;

    [delta, jTransit] = getDeclinationAngle(date, lon);
    
    a           = -0.83 + (-2.076 * sqrt(elev) / 60);
    omega0      = acosd((sind(a) - sind(phi) * sind(delta)) / (cosd(phi) * cosd(delta)));
    Jrise       = jTransit - omega0 / 360;
    Jset        = jTransit + omega0 / 360;

    riseTime    = datetime(Jrise, 'convertfrom', 'juliandate', 'TimeZone', tz);
    setTime     = datetime(Jset, 'convertfrom', 'juliandate', 'TimeZone', tz);
    

end
