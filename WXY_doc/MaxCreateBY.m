function MaxCreateBY(fid)
    fprintf(fid,'\n');
    fprintf(fid,'Set oModule = oDesign.GetModule("FieldsReporter")\n');
    fprintf(fid,'oModule.CalcStack "clear"\n');
    fprintf(fid,'oModule.EnterQty "B"\n');
    fprintf(fid,'oModule.CalcOp "ScalarY"\n');
    fprintf(fid,'oModule.CalcOp "Smooth"\n');
    fprintf(fid,'oModule.AddNamedExpression "B_Y", "Fields"\n');
    end