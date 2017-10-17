# Columbia_South_Ocean_Mooring

File for converting the mooring data files from Columbia university to MATLAB.

To run the file begin by importing the desired data into MATLAB underneath the 'Home' tab -> 'Import Data'.

When the script is run, it will gather any desired information and add it to a NetCDF file generated in the same folder as the script.   

To add any information to the NetCDF file, it can be added in the %Global Attributes section of the script using the format:

netcdf.putAtt(ncid,varid,'Data Name',data);

Example using bioluminescence data located in the d1 folder:
netcdf.putAtt(ncid,varid,'Bioluminescence',d1.Bioluminescnece);

If any errors occur on run, information the script is looking for is not located in the data package or not in the path it is pointing towards. If the data the script is searching for is not in the data package, one solution is to comment the section of data throwing the error.

If the data is located in the data file and the MATLAB script is not in the path the script is directed towards, the path must be changed.  This can be altered using the format:
folder1.folder2.folder3.dataName
