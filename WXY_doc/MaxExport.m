function MaxExport(fid,path)
    fprintf(fid,'\n');
    fprintf(fid,'oModule.ExportMarkerTable "%s"\n',path);
end