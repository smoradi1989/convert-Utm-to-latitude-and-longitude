% Function definition must be at the end
function [lat, lon] = utm2latlon(x, y, zone, hemisphere)
    % Constants
    a = 6378137.0; % WGS84 major axis
    f = 1 / 298.257223563; % WGS84 flattening
    k0 = 0.9996; % Scale factor
    e = sqrt(f * (2 - f));
    
    % Define false northing
    if hemisphere == 'S'
        y = y - 10000000;
    end

    % UTM parameters
    e1 = (1 - sqrt(1 - e^2)) / (1 + sqrt(1 - e^2));
    x = x - 500000; % Remove false easting
    m = y / k0;
    
    % Compute footprint latitude
    mu = m / (a * (1 - e^2 / 4 - 3 * e^4 / 64 - 5 * e^6 / 256));
    phi1 = mu + (3*e1/2 - 27*e1^3/32) * sin(2*mu) + (21*e1^2/16 - 55*e1^4/32) * sin(4*mu) ...
          + (151*e1^3/96) * sin(6*mu) + (1097*e1^4/512) * sin(8*mu);
    
    % Compute longitude and latitude
    N1 = a / sqrt(1 - e^2 * sin(phi1)^2);
    T1 = tan(phi1)^2;
    C1 = (e^2 / (1 - e^2)) * cos(phi1)^2;
    R1 = a * (1 - e^2) / (1 - e^2 * sin(phi1)^2)^(3/2);
    D = x / (N1 * k0);

    lat = phi1 - (N1 * tan(phi1) / R1) * (D^2 / 2 - (5 + 3*T1 + 10*C1 - 4*C1^2 - 9*e^2) * D^4 / 24 ...
          + (61 + 90*T1 + 298*C1 + 45*T1^2 - 252*e^2 - 3*C1^2) * D^6 / 720);
    lat = lat * (180/pi);

    lon = (D - (1 + 2*T1 + C1) * D^3 / 6 + (5 - 2*C1 + 28*T1 - 3*C1^2 + 8*e^2 + 24*T1^2) * D^5 / 120) / cos(phi1);
    lon = lon * (180/pi) + (zone - 1) * 6 - 180 + 3;
end
