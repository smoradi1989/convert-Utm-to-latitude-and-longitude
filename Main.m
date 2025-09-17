clc;clear;close all;

[b, a] = uigetfile('.xlsx');
[X, adr] = xlsread([a filesep b]);

for i = 1:size (X,1)
    
% Main script
utmX = X(i,1) ;  % Easting
utmY = X(i,2) ; % Northing
zoneNumber = 39; % UTM Zone
hemisphere = 'N'; % 'N' for Northern Hemisphere, 'S' for Southern

[lat, lon] = utm2latlon(utmX, utmY, zoneNumber, hemisphere);

Latitude(i)=lat;
Longitude(i)=lon;

fprintf('Latitude: %.6f, Longitude: %.6f\n', lat, lon);
end
xlswrite([a filesep 'R.csv'],adr,'sheet1','A');
xlswrite([a filesep 'R.csv'],Latitude','Sheet1','B');
xlswrite([a filesep 'R.csv'],Longitude','sheet1','C');
