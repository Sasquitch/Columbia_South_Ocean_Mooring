%Columbia Data
workspace; %open workspace
d1 = m(1).d;
times = d1.p24perDay0000start;
%for number of entries in m
%for number of entries underneath m

filename = d1(1,1).moorID; %name file moorID entry TODO change y to entry underneath m
ncid = netcdf.create(filename, 'NC_WRITE');

[timex,timesy] = size(times);
timeDimID = netcdf.defDim(ncid,'time',timesy); %create dimension with len time

type1 = d1.type;
[lenx,leny] = size(type1);
timeseriesDimID = netcdf.defDim(ncid,'timeseries',leny); %dim of number of sensors for that year

latitude = d1.lt;
lat_id = netcdf.defVar(ncid,'lat','float',timeseriesDimID);
netcdf.putAtt ( ncid, lat_id, 'standard_name', 'latitude');
netcdf.putAtt ( ncid, lat_id, 'units', 'degrees_north');
netcdf.putAtt ( ncid, lat_id, 'axis', 'Y');
netcdf.putAtt ( ncid, lat_id, 'valid_min', latitude);
netcdf.putAtt ( ncid, lat_id, 'valid_max', latitude);
netcdf.putAtt ( ncid, lat_id, 'FillValue', latitude);
netcdf.putAtt ( ncid, lat_id, 'comment', '');
latArr(1:leny) = latitude; %Fill array of length timeseries with values of lat.

longitude = d1.ln;
lon_id = netcdf.defVar(ncid,'lon','float',timeseriesDimID);
netcdf.putAtt ( ncid, lon_id, 'standard_name', 'longitude');
netcdf.putAtt ( ncid, lon_id, 'units', 'degrees_east');
netcdf.putAtt ( ncid, lon_id, 'axis', 'X');
netcdf.putAtt ( ncid, lon_id, 'valid_min', longitude);
netcdf.putAtt ( ncid, lon_id, 'valid_max', longitude);
netcdf.putAtt ( ncid, lon_id, 'FillValue', longitude);
netcdf.putAtt ( ncid, lon_id, 'comment', '');
lonArr(1:leny) = longitude; %Fill array of length timeseries with values of lat.

depth_id = netcdf.defVar(ncid,'depth','float',timeseriesDimID);
netcdf.putAtt ( ncid, depth_id, 'long_name', 'array of all depths when mooring is maximally taut');
netcdf.putAtt ( ncid, depth_id, 'standard_name', 'depth');
netcdf.putAtt ( ncid, depth_id, 'units', 'm');
netcdf.putAtt ( ncid, depth_id, 'axis', 'z');
netcdf.putAtt ( ncid, depth_id, 'positive', 'down');
%valid min
%valid max
netcdf.putAtt ( ncid, depth_id, 'FillValue', 'NaN');
%notes
depthArr = d1.deNom;

varid = netcdf.getConstant('GLOBAL');
netcdf.putAtt(ncid,varid,'ncei_template_version','yes');
netcdf.putAtt(ncid,varid,'featureType','yes');
netcdf.putAtt(ncid,varid,'title','data gathered at location');
netcdf.putAtt(ncid,varid,'naming_authority','edu.columbia.ldeo');
netcdf.putAtt(ncid,varid,'creator_url','http://www.ldeo.columbia.edu/');
netcdf.putAtt(ncid,varid,'publisher_name','US National Centers for Environmental Information');
netcdf.putAtt(ncid,varid,'publisher_email','ncei.info@noaa.gov');
netcdf.putAtt(ncid,varid,'publisher_url','https://www.ncei.noaa.gov');

mlTimes = {times.dn};
mlPress = {times.pr};
mlTemp = {times.te};
mlSal = {times.sa};

%class(mlPress)
%mlPressSeries = timeseries(mlPress);
%mlPressSeries(mlPress)
%times(1).pr';

for c = 1:timesy
    mlPressArr(c,:) = times(c).pr';
    mlTempArr(c,:) = times(c).te';
    mlSalArr(c,:) = times(c).sa';
end

mlPressSeries = timeseries(mlPressArr,mlTimes,'Name','pressureTS')
mlTempSeries = timeseries(mlTempArr,mlTimes,'Name','temperatureTS')
mlSalSeries = timeseries(mlSalArr,mlTimes,'Name','SalinityTS')

netcdf.endDef (ncid);
%Assign all labels to Variables
netcdf.putVar (ncid, lat_id, latArr);
netcdf.putVar (ncid, lon_id, lonArr);
netcdf.putVar (ncid, depth_id, depthArr);
netcdf.close(ncid);