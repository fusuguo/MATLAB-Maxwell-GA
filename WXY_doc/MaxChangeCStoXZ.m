function MaxChangeCStoXZ(fid)
    fprintf(fid,'\noEditor.CreateRelativeCS Array("NAME:RelativeCSParameters", "OriginX:=", "0mm", "OriginY:=", "0mm", "OriginZ:=", "0mm", "XAxisXvec:=", "0.35mm", "XAxisYvec:=", "0mm", "XAxisZvec:=", "0mm", "YAxisXvec:=", "0mm", "YAxisYvec:=", "0.45mm", "YAxisZvec:=", "0mm"), Array("NAME:Attributes", "Name:=","CS_Ob_T&B")');
    fprintf(fid,'\n');
    fprintf(fid,'oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DCSTab", Array("NAME:PropServers","CS_Ob_T&B"), Array("NAME:ChangedProps", Array("NAME:X Axis", "X:=", "600mm", "Y:=", "0mm", "Z:=", "0mm"))))');
    fprintf(fid,'\n');
    fprintf(fid,'oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DCSTab", Array("NAME:PropServers","CS_Ob_T&B"), Array("NAME:ChangedProps", Array("NAME:Y Point", "X:=", "0mm", "Y:=", "0mm", "Z:=", "3mm"))))');
end