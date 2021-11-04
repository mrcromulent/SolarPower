function s0 = solarRefFlux(nPoints, weather)
    
    Smax = 1000;
    Smin = 0.2 * Smax;

    % Set the reference flux based on the weather
    switch weather
        case WeatherTypes.Sunny
            s0 = Smax * ones(nPoints, 1);
        case WeatherTypes.PartlyCloudy
            s0 = Smax * ones(nPoints, 1);
            s0(rand(nPoints, 1) >= 0.5) = Smin;
        case WeatherTypes.Overcast
            s0 = Smin * ones(nPoints, 1);
    end

end