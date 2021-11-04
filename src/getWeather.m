function weather = getWeather(date, lat)

    opts    = [WeatherTypes.Sunny, WeatherTypes.PartlyCloudy, WeatherTypes.Overcast];
    s       = getSeason(date, lat);
    
    switch s
        case "Summer"
            w = [43, 37, 12];
        case "Autumn"
            w = [33, 27, 31];
        case "Winter"
            w = [24, 31, 36];
        case "Spring"
            w = [34, 31, 26];
    end
    
    % Normalise the weights
    w = w / sum(w);
    
    % Take a random sample
    weather = randsample(opts, 1, true, w);

end