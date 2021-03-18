 function Maxanlysis(fid,count,p_error)
    fprintf(fid,'\n\n');
    fprintf(fid,'Set oModule = oDesign.GetModule("AnalysisSetup")');
    fprintf(fid,'\n');
    fprintf(fid,'oModule.InsertSetup "Magnetostatic", Array("NAME:Setup1", "Enabled:=", true, "MaximumPasses:=",  _\n %d, "MinimumPasses:=", 2, "MinimumConvergedPasses:=", 1 , "PercentRefinement:=",  _ \n 30, "SolveFieldOnly:=", false, "PercentError:=", %f, "SolveMatrixAtLast:=",  _\n  true, "PercentError:=", %f, "UseIterativeSolver:=", false, "RelativeResidual:=",  _ \n  1E-006, "ComputeForceDensity:=", false, "ComputePowerLoss:=", false, "NonLinearResidual:=",  _ \n   0.001, Array("NAME:MuHcOption", "MuNonLinearBH:=", true, "HcNonLinearBH:=", true, "ComputeHc:=",  _ \n  false))',count ,p_error,p_error);
end