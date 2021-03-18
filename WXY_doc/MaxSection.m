% oEditor.Section Array("NAME:Selections", "Selections:=",  _
%   "BOX1_1,BOX1_2,BOX1_3,BOX1_4,BOX1_5,BOX1_6,BOX1_7,BOX1_8,BOX1_9,BOX1_10,BOX1_11" & _
%   ",BOX1_12,BOX1_13", "NewPartsModelFlag:=", "Model"), Array("NAME:SectionToParameters", "CreateNewObjects:=",  _
%   true, "SectionPlane:=", "YZ", "SectionCrossObject:=", false)
%Set oModule = oDesign.GetModule("BoundarySetup")
function MaxSection(fid, level, n, section_n)

    for f_s = 1:2

        if f_s == 2
            % 更改坐标轴
            ChangeCS(fid, 1);
        end

        fprintf(fid, '\n');
        % 创建截面
        fprintf(fid, 'oEditor.Section Array("NAME:Selections", "Selections:=","');

        for i = 1:n
            BoxName = strcat('BOX_', level);
            BoxName = strcat(BoxName, '_');
            i_n = num2str(i);
            BoxName = strcat(BoxName, i_n);
            fprintf(fid, '%s,', BoxName);
        end

        fprintf(fid, '","NewPartsModelFlag:=", "Model"), Array("NAME:SectionToParameters", "CreateNewObjects:=", true, "SectionPlane:=", "YZ", "SectionCrossObject:=", false)');
        fprintf(fid, '\n');

        %首次截面创建
        if f_s == 1
            fprintf(fid, 'Set oModule = oDesign.GetModule("BoundarySetup")');
        end

        fprintf(fid, '\n');
        fprintf(fid, 'oModule.AssignCurrentGroup Array(');
        f_s_s = num2str(f_s);
        for i = 1:n
            %if level = 1 or 3,x = "x+"
            %Current_level_x+_i
            Current = "Current_";
            Current = strcat(Current, level);
            Current = strcat(Current, '_');
            
            Current = strcat(Current, f_s_s);

            %level = str2num(level);
            if (level == "1" || level == "3")
                x = "x+";
            else
                x = "x-";
            end

            Current = strcat(Current, '_');
            Current = strcat(Current, x);
            Current = strcat(Current, '_');
            i_n = num2str(i);
            Current = strcat(Current, i_n);

            if i == 1
                Current_lead = Current;
            end

            if i == n
                fprintf(fid, '"%s"', Current);
            else
                fprintf(fid, '"%s",', Current);
            end

        end

        fprintf(fid, '),Array("NAME:%s",', Current_lead);
        fprintf(fid, '"Objects:=",Array(');

        for i = 1:n
            BoxSection = "BOX";
            BoxSection = strcat(BoxSection, '_');
            BoxSection = strcat(BoxSection, level);
            BoxSection = strcat(BoxSection, '_');
            i_n = num2str(i);
            BoxSection = strcat(BoxSection, i_n);
            BoxSection = strcat(BoxSection, '_');
            BoxSection = strcat(BoxSection, 'Section');
            %section_n_s = num2str(section_n);
            BoxSection = strcat(BoxSection, f_s_s);

            if i == n
                fprintf(fid, '"%s"', BoxSection);
            else
                fprintf(fid, '"%s",', BoxSection);
            end

        end

        section_n = section_n + 1;

        if (level == "1" || level == "3")

            if f_s == 1
                fprintf(fid, '), "Current:=", "1A", "IsSolid:=", true, "Point out of terminal:=", false)');
            else f_s == 2
                fprintf(fid, '), "Current:=", "1A", "IsSolid:=", true, "Point out of terminal:=", true)');
            end

        else

            if f_s == 1
                fprintf(fid, '), "Current:=", "1A", "IsSolid:=", true, "Point out of terminal:=", true)');
            else f_s == 2
                fprintf(fid, '), "Current:=", "1A", "IsSolid:=", true, "Point out of terminal:=", false)');
            end

        end

    end

end
