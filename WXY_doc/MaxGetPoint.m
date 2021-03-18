function MaxGetPoint(fid,x,y,z,FileName)
    fprintf(fid,'\n');
	fprintf(fid,'oModule.AddMarker Array("%fmm", "%fmm", "%fmm")',x,y,z);
   
end