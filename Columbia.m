%Columbia Data
workspace;
ncid = netcdf.create('columbia.nc', 'NC_WRITE');

d1 = m(1).d;



%dimid = netcdf.defDim(ncid,'x',50);

%varid = netcdf.defVar(ncid,'myvar','double',dimid);


varid = netcdf.getConstant('GLOBAL');
netcdf.putAtt(ncid,varid,'ncei_template_version','yes');
netcdf.putAtt(ncid,varid,'featureType','yes');
netcdf.putAtt(ncid,varid,'title','data gathered at location');
netcdf.putAtt(ncid,varid,'naming_authority','edu.columbia.ldeo');
netcdf.putAtt(ncid,varid,'creator_url','http://www.ldeo.columbia.edu/');
netcdf.putAtt(ncid,varid,'publisher_name','US National Centers for Environmental Information');
netcdf.putAtt(ncid,varid,'publisher_email','ncei.info@noaa.gov');
netcdf.putAtt(ncid,varid,'publisher_url','https://www.ncei.noaa.gov');

netcdf.close(ncid)