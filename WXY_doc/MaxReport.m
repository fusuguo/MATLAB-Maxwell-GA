function MaxReport(fid,FileName,CName,R_p)
	fprintf(fid,'\n');
	fprintf(fid,'Set oModule = oDesign.GetModule("ReportSetup")\n');
	fprintf(fid,'oModule.CreateReport "XY Plot 1", "Fields", "Rectangular Plot", "Setup1 : LastAdaptive", Array("Context:=", "%s", "PointCount:=", 1001), Array("Distance:=", Array("All")), Array("X Component:=", "Distance", "Y Component:=", Array("B_Y")), Array()',CName);
	fprintf(fid,'\n');
	fprintf(fid,'oModule.ExportUniformPointsToFile "XY Plot 1", "C:/Users/95340/Desktop/MRI/api/%s.csv", "0mm", "%fmm", "%fmm"',FileName,R_p,R_p/180);
    fprintf(fid,'\n');
    fprintf(fid,'oModule.DeleteAllReports');
end