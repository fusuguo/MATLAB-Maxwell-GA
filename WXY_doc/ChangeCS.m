function ChangeCS(fid,select)
fprintf(fid,'\n\n');
    if select == 0
        % 回归global
        fprintf(fid,'oEditor.SetWCS Array("NAME:SetWCS Parameter", "Working Coordinate System:=", "Global")');
    else
        % 转到CS1
        fprintf(fid,'oEditor.SetWCS Array("NAME:SetWCS Parameter", "Working Coordinate System:=","RelativeCS1")');
    end
fprintf(fid,'\n');    
end