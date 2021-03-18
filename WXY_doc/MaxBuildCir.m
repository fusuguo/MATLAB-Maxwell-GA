function MaxBuildCir(fid,Name,y,z,r)
	fprintf(fid,'\n');
	fprintf(fid,'oEditor.CreateCircle Array("NAME:CircleParameters", "IsCovered:=", true, "XCenter:=", "270mm", "YCenter:=", "%fmm", "ZCenter:=", "%fmm", "Radius:=", "%fmm", "WhichAxis:=", "Z", "NumSegments:=", "0"), Array("NAME:Attributes", "Name:=", "%s", "Flags:=", "NonModel#", "Color:=", "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=", true)',y,z,r,Name);
	fprintf(fid,'\n');
	fprintf(fid,'oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DCmdTab", Array("NAME:PropServers", "%s:CoverLines:1"), Array("NAME:ChangedProps", Array("NAME:Suppress Command", "Value:=", true))))',Name);
end