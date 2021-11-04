function res = getL(filenames)

    res = cell(1, length(filenames));

    for i = 1:length(filenames)
        filename = filenames(i);
        
        M = csvread(filename);
        x_value = M(:, 1);
        y_value = M(:, 2);

        res{i} = sqrt(x_value.^2 + y_value.^2);
    end
end