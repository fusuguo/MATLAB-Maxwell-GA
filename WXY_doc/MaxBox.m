function MaxBox(fid, Name,ys,yp,zp)
 xp = 0;
 xs = 540;
 zs = 0.2;
 %zp = 0;
 units = "mm";
fprintf(fid,'\n');
fprintf(fid,'oEditor.CreateBox ');

fprintf(fid,'Array("NAME:BoxParameters"');
fprintf(fid,',');
fprintf(fid,'"XPosition:=","%f%s",',xp,units);
fprintf(fid,'"YPosition:=","%f%s",',yp,units);
fprintf(fid,'"ZPosition:=","%f%s",',zp,units);

fprintf(fid,'"XSize:=","%f%s",',xs,units);
fprintf(fid,'"YSize:=","%f%s",',ys,units);
fprintf(fid,'"ZSize:=","%f%s")',zs,units);
fprintf(fid,',');
% , Array("NAME:Attributes", "Name:=", "Box1", "Flags:=", "", "Color:=",  _
%   "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
%   "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
%   true)
fprintf(fid,'Array("NAME:Attributes", "Name:=",');
fprintf(fid,'"%s"',Name);
fprintf(fid,', "Flags:=", "", "Color:=", "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  true)');
  
end