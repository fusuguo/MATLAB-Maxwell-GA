function CreateCS(fid,Name,x,y,z)
    fprintf(fid,'\n');
	%创建初始坐标
	fprintf(fid,'oEditor.CreateRelativeCS Array("NAME:RelativeCSParameters", "OriginX:=", "0mm", "OriginY:=", "0mm", "OriginZ:=", "0mm", "XAxisXvec:=", "0.35mm", "XAxisYvec:=", "0mm", "XAxisZvec:=", "0mm", "YAxisXvec:=", "0mm", "YAxisYvec:=", "0.45mm", "YAxisZvec:=", "0mm"), Array("NAME:Attributes", "Name:=","%s")',Name);
	%修改坐标原点
    fprintf(fid,'\n');
	fprintf(fid,'oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DCSTab", Array("NAME:PropServers", "%s"), Array("NAME:ChangedProps", Array("NAME:Origin", "X:=", "%fmm", "Y:=", "%fmm", "Z:=", "%fmm"))))',Name,x,y,z);
end