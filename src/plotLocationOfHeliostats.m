function h = plotLocationOfHeliostats(filename)

    M = csvread(filename);
    
    h = figure();
    hold on;
    plot(M(:, 1), M(:, 2), "b.", "DisplayName", "Heliostats")
    plot(0.0, 0.0, 'ro', "DisplayName", "Tower")
    title(filename);
    xlabel("x [m]");
    ylabel("y [m]");
    legend();
    axis equal;
    hold off;

end

