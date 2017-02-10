%Columbia Data
workspace; %open workspace
d1 = m(1).d;
times = d1.p24perDay0000start;
%for number of entries in m
%for number of entries underneath m

filename = d1(1,1).moorID; %name file moorID entry TODO change y to entry underneath m
filename = [filename '13' '.nc'];
nccreate(filename,'var1')
ncid = netcdf.create(filename, 'NC_WRITE');

[timex,timesy] = size(times);
timeDimID = netcdf.defDim(ncid,'time',timesy); %create dimension with len time

type1 = d1.type;
[lenx1,leny1] = size(type1);
timeseriesDimID = netcdf.defDim(ncid,'timeseries',leny1); %dim of number of sensors for that year

pr = times.pr;
[presx,presy] = size(pr);
presSizeDimID = netcdf.defDim(ncid, 'pressureSensors', presx); %define sizes of each data array for writing data

te = times.te;
[tempx,tempy] = size(te);
tempSizeDimID = netcdf.defDim(ncid, 'temperatureSensors', tempx);

sa = times.sa;
[salx,saly] = size(sa);
salSizeDimID = netcdf.defDim(ncid, 'salinitySensors', saly);

latitude = d1.lt;
lat_id = netcdf.defVar(ncid,'lat','float',timeseriesDimID);
netcdf.putAtt ( ncid, lat_id, 'standard_name', 'latitude');
netcdf.putAtt ( ncid, lat_id, 'units', 'degrees_north');
netcdf.putAtt ( ncid, lat_id, 'axis', 'Y');
netcdf.putAtt ( ncid, lat_id, 'valid_min', latitude);
netcdf.putAtt ( ncid, lat_id, 'valid_max', latitude);
netcdf.putAtt ( ncid, lat_id, 'FillValue', latitude);
netcdf.putAtt ( ncid, lat_id, 'comment', '');
latArr(1:leny1) = latitude; %Fill array of length timeseries with values of lat.

longitude = d1.ln;
lon_id = netcdf.defVar(ncid,'lon','float',timeseriesDimID);
netcdf.putAtt ( ncid, lon_id, 'standard_name', 'longitude');
netcdf.putAtt ( ncid, lon_id, 'units', 'degrees_east');
netcdf.putAtt ( ncid, lon_id, 'axis', 'X');
netcdf.putAtt ( ncid, lon_id, 'valid_min', longitude);
netcdf.putAtt ( ncid, lon_id, 'valid_max', longitude);
netcdf.putAtt ( ncid, lon_id, 'FillValue', longitude);
netcdf.putAtt ( ncid, lon_id, 'comment', '');
lonArr(1:leny1) = longitude; %Fill array of length timeseries with values of lat.

depth_id = netcdf.defVar(ncid,'depth','float',timeseriesDimID);
netcdf.putAtt ( ncid, depth_id, 'long_name', 'array of all depths when mooring is maximally taut');
netcdf.putAtt ( ncid, depth_id, 'standard_name', 'depth');
netcdf.putAtt ( ncid, depth_id, 'units', 'm');
netcdf.putAtt ( ncid, depth_id, 'axis', 'z');
netcdf.putAtt ( ncid, depth_id, 'positive', 'down');
netcdf.putAtt ( ncid, depth_id, 'FillValue', 'NaN');
depthArr = d1.deNom;

pressure_id = netcdf.defVar(ncid,'pressure','float',[timeDimID,presSizeDimID]);
netcdf.putAtt ( ncid, pressure_id, 'standard_name', 'Pressure');
netcdf.putAtt ( ncid, pressure_id, 'units', 'dbar');
netcdf.putAtt ( ncid, pressure_id, 'long_name', 'Matrix of pressure sensors at different depth vs data');
netcdf.putAtt ( ncid, pressure_id, 'valid_min', '0.0');
netcdf.putAtt ( ncid, pressure_id, 'valid_max', '0.0');
netcdf.putAtt ( ncid, pressure_id, 'ccomment', 'Data array of moorings and pressure');

temperature_id = netcdf.defVar(ncid,'temperature','float',[timeDimID,tempSizeDimID]);
netcdf.putAtt ( ncid, temperature_id, 'standard_name', 'Temperature');
netcdf.putAtt ( ncid, temperature_id, 'units', 'c');
netcdf.putAtt ( ncid, temperature_id, 'long_name', 'Matrix of temperature sensors at different depth vs data');
netcdf.putAtt ( ncid, temperature_id, 'valid_min', '0.0');
netcdf.putAtt ( ncid, temperature_id, 'valid_max', '0.0');
netcdf.putAtt ( ncid, temperature_id, 'ccomment', 'Data array of moorings and temperature');

salinity_id = netcdf.defVar(ncid,'salinity','float',[timeDimID,salSizeDimID]);
netcdf.putAtt ( ncid, salinity_id, 'standard_name', 'sea_water_salinity');
netcdf.putAtt ( ncid, salinity_id, 'units', 'psu');
netcdf.putAtt ( ncid, salinity_id, 'long_name', 'Matrix of salinity sensors at different depth vs data');
netcdf.putAtt ( ncid, salinity_id, 'valid_min', '0.0');
netcdf.putAtt ( ncid, salinity_id, 'valid_max', '0.0');
netcdf.putAtt ( ncid, salinity_id, 'ccomment', 'Data array of moorings and salinity');

varid = netcdf.getConstant('NC_GLOBAL'); %Define global attributes
netcdf.putAtt(ncid,varid,'ncei_template_version','NCEI_TimeSeries_Orthogonal');
netcdf.putAtt(ncid,varid,'featureType','TimeSeries');
netcdf.putAtt(ncid,varid,'Year', d1(1,1).year);
netcdf.putAtt(ncid,varid,'Conventions','CF-1.4');
netcdf.putAtt(ncid,varid,'naming_authority','edu.columbia.ldeo');
currTime = ['File Created on ' datestr(now)];
netcdf.putAtt(ncid,varid,'date_created',currTime);
netcdf.putAtt(ncid,varid,'date_modified',currTime);
netcdf.putAtt(ncid,varid,'Institution','Lamont-Doherty Earth Observatory');
netcdf.putAtt(ncid,varid,'creator_url','http://www.ldeo.columbia.edu/');
netcdf.putAtt(ncid,varid,'publisher_name','US National Centers for Environmental Information');
netcdf.putAtt(ncid,varid,'publisher_email','ncei.info@noaa.gov');
netcdf.putAtt(ncid,varid,'publisher_url','https://www.ncei.noaa.gov');
netcdf.putAtt(ncid,varid,'Latitude',latitude);
netcdf.putAtt(ncid,varid,'Longitude',longitude);
netcdf.putAtt(ncid,varid,'DeploymentCruise',d1(1,1).deploymentCruise);
netcdf.putAtt(ncid,varid,'LTER grid line',d1(1,1).gl);
netcdf.putAtt(ncid,varid,'LTER grid station',d1(1,1).gs);

sensArr = d1(1,1).type; %List of sensors
netcdf.putAtt(ncid,varid,'Sensor Types', strjoin(sensArr));

sensSerialArr = d1(1,1).sensor;
netcdf.putAtt(ncid,varid,'Sensor Serial Numbers', num2str(sensSerialArr));

s39TPk = d1.s39TPk; %Define sensors used
if isempty(s39TPk) == 0 %If the array is not empty
    netcdf.putAtt(ncid,varid,'s39TPk sensors', num2str(s39TPk));
end 

s39Tk = d1.s39Tk;
if isempty(s39Tk) == 0
    netcdf.putAtt(ncid,varid,'s39Tk sensors', num2str(s39Tk));
end

s37k = d1.s37k;
if isempty(s37k) == 0 %If the array is not empty
    netcdf.putAtt(ncid,varid,'s37k sensors', num2str(s39Tk));
end

AEMk = d1.AEMk;
if isempty(AEMk) == 0 
    netcdf.putAtt(ncid,varid,'AEMk sensors', num2str(AEMk));
end

S4k = d1.S4k;
if isempty(S4k) == 0
    netcdf.putAtt(ncid,varid,'S4k sensors', num2str(S4k));
end

mlTimes = {times.dn}; %define the correct column
mlTemp = {times.te};
mlSal = {times.sa};

for c = 1:timesy %could predefine the matrix size
    mlPressArr(c,:) = times(c).pr'; %Loop down p24perday, insert data into matrix
    mlTempArr(c,:) = times(c).te';
    mlSalArr(c,:) = times(c).sa';
end

netcdf.endDef (ncid);

%Assign all labels to Variables
netcdf.putVar (ncid, lat_id, latArr);
netcdf.putVar (ncid, lon_id, lonArr);
netcdf.putVar (ncid, depth_id, depthArr);
netcdf.putVar(ncid,pressure_id,mlPressArr);
netcdf.putVar(ncid,temperature_id,mlTempArr);
netcdf.putVar(ncid,salinity_id,mlSalArr);

netcdf.close(ncid);