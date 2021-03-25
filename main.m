%% 开始
clear all;
false = 0;
true = 1;
%% 文件路径
hfssExePath = 'C:\Program Files\AnsysEM\Maxwell16.0\Win64\maxwell.exe';
% maxwell启动路径
tmpPrjFile = 'C:\Users\95340\Desktop\MRI\api\testing3_16_1.mxwl';
%tmpDataFile = 'E:\ansoft\temp\tmpData.dat';
tmpScriptFile = 'C:\Users\95340\Desktop\MRI\api\testing3_16_1.vbs';
% 临时文件路径
fid = fopen(tmpScriptFile, 'wt'); % 写入
%% 创建一个新的工程并插入一个新的设计
hfssNewProject(fid);
hfssInsertDesign(fid, 'Testing3_16_1');
%线圈数
n = 10;
%ys 宽度
ys = 20;
d = 10;
%% 创建模型&电流
%创建坐标轴CS1
CreateCSBox(fid);
FRP_copper = "copper";
count = 1;
zs = 0.2;

for level = 1:4

    if level == 1
        zp = 0;
    elseif level == 2
        zp = 22;
    elseif level == 3
        zp = 316;
    elseif level == 4
        zp = 338;
    end

    ChangeCS(fid, 0);
    level_s = num2str(level);

    for i = 1:n
        yp = (i - 1) * (d + ys);
        i_n = num2str(i);
        BoxName = strcat('BOX_', level_s);
        BoxName = strcat(BoxName, '_');
        BoxName = strcat(BoxName, i_n);
        %建立建模
        MaxBoxFRP(fid, BoxName, ys, yp, zs, zp, FRP_copper);
    end

    fprintf(fid, '\n');
    level_s = num2str(level);
    section_n = count * 2 - 1;
    MaxSection(fid, level_s, n, section_n); %建立截面并添加电流

end

%% 添加观测区域
ChangeCS(fid, 0);
FRP_vacuum = "vacuum";
BoxName_ob = "BoxObserve";
zs = 345;
zp = 0;
ys = yp + ys;
yp = 0;
MaxBoxFRP(fid, BoxName_ob, ys, yp, zs, zp, FRP_vacuum);
% 添加5倍观测区域

%% 添加analysis
count_i = 10; %迭代次数
p_error = 1;
Maxanlysis(fid, count_i, p_error);

%% 开始运行
MaxRun(fid);

%% 生成观测面并取点
y = ys / 2;
x = 270;
R = 100;
MaxCreateBY(fid);
open = 0;

for i = 1:21
    i_n = num2str(i);
    doc_count = 1;
    CS_Name = "CS_Ob_";
    CS_Name = strcat(CS_Name, i_n);
    Circle = "Circle_";
    Circle = strcat(Circle, i_n);
    FileName = "Report_";
    FileName = strcat(FileName, i_n);
    z = 59 + 10 * i;

    if i == 1
        continue
    end

    if i == 21
        z = 169;
        MaxChangeCStoXZ(fid);
        R_tem = 100;
        MaxBuildCir(fid, Circle, z, -y, R_tem);
        R_p = 2 * pi * R_tem;
        MaxReport(fid, FileName, Circle, R_p);
        break
    end

    CreateCS(fid, CS_Name, x, y, z);
    ChangeCS(fid, 0);
    h = 10 * abs(11 - i);
    R_tem = sqrt(R^2 - h^2);
    MaxBuildCir(fid, Circle, y, z, R_tem);
    R_p = 2 * pi * R_tem;
    MaxReport(fid, FileName, Circle, R_p);
end

%% 保存文件并删除
hfssSaveProject(fid, tmpPrjFile, true);
ProjectName = "testing3_16_1";
MaxDelete(fid, ProjectName);
fclose(fid);
fclose('all');

%% 运行脚本文件
batname = 'testing3_16_1.vbs';
path = fullfile('C:\Users\95340\Desktop\MRI\api', batname);
Cmd = [path];
system(Cmd);

%% 读取生成的report 1~22
