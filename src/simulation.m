function res = simulation(pps, params)
    
    % Unpack
    startDate = pps.startDate;
    kappa   = pps.kappa;
    sigma   = pps.sigma;
    H       = pps.H;
    lat     = pps.lat;
    lon     = pps.lon;
    tz      = pps.tz;
    dt      = params.dt;
    variableWeather = params.variableWeather;
    
    
    tvals = 1:dt:24;
    dvals = 0:1:364;
    numPPs  = length(pps.filenames);
    summedInsolation = zeros(numPPs, length(tvals));
    
    % Find the L values - the distances from the heliostats to the towers
    ppLs = getL(pps.filenames);
    nPoints = size(ppLs{1}, 1);

    for d = dvals

        date = startDate + days(d);
        [riseTime, setTime] = getRiseSetTimes(date, lat, lon, tz);

        powerGenerationStart    = riseTime + hours(1);
        powerGenerationEnd      = setTime - hours(1);
        
        if variableWeather
            weather = getWeather(date, lat);
        else
            weather = WeatherTypes.Sunny;
        end
        
        for T = tvals

            totalInsolation = zeros(numPPs, 1);
            currTime = date + hours(T);

            if currTime > powerGenerationStart && currTime < powerGenerationEnd
                [delta, ~] = getDeclinationAngle(date, lon);
                varphi = getHourAngle(T);
                zeta = getZenithAngle(lat, delta, varphi);
                alpha = 90 - zeta;
                
                S0 = solarRefFlux(nPoints, weather);
                S = getSolarRadiationFlux(alpha, kappa, S0);
                
                for i = 1:numPPs
                    L = ppLs{i};
                    
                    beta = getHeliostatTowerAngle(alpha, H, L);
                    I = getInsolation(S, sigma, beta);
                    totalInsolation(i) = sum(I);
                end
            end

            idx = find(tvals==T);
            summedInsolation(:, idx) = summedInsolation(:, idx) + totalInsolation;

        end
    end
    
    % Express result in MW
    res = summedInsolation / length(dvals) * 1e-6;
end