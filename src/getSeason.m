function s = getSeason(date, lat)

    m = date.Month;

    if lat > 0 % Northern hemisphere
        
        switch m
            case {12, 1, 2}
                s = "Winter";
            case {3, 4, 5}
                s = "Spring";
            case {6, 7, 8}
                s = "Summer";
            case {9, 10, 11}
                s = "Autumn";
        end
        
    else
        
        switch m
            case {12, 1, 2}
                s = "Summer";
            case {3, 4, 5}
                s = "Autumn";
            case {6, 7, 8}
                s = "Winter";
            case {9, 10, 11}
                s = "Spring";
        end

    end

end

