function MaxPrint(fid) 
fprintf(fid,'\n');
    fprintf(fid,'Set oModule = oDesign.GetModule("FieldsReporter")\n');
    fprintf(fid,'oModule.ExportMarkerTable "C:/Users/95340/Desktop/MRI/api/Report_Top&Bot.csv"');
end