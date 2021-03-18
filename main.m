%% 利用软件包创建一个圆柱体
clear all;
false = 0;
true = 1;
%% HFSS执行路径
hfssExePath = 'C:\Program Files\AnsysEM\Maxwell16.0\Win64\maxwell.exe';
% 临时文件路径
tmpPrjFile = 'C:\Users\95340\Desktop\MRI\api\testing3_16_1.mxwl';
%tmpDataFile = 'E:\ansoft\temp\tmpData.dat';
tmpScriptFile = 'C:\Users\95340\Desktop\MRI\api\testing3_16_1.vbs';
% 创建一个新的HFSS临时脚本文件
fid = fopen(tmpScriptFile, 'wt'); % 'wt'表示以文本模式打开文件，可写，覆盖原有内容
%% 创建一个新的工程并插入一个新的设计 设计参数
hfssNewProject(fid);
hfssInsertDesign(fid, 'Testing3_16_1');
% 线圈数目
n = 10;
% 层数 nc = 4;
% 线圈宽度 ys
ys = 20;
d = 10;
%% 创建模型&电流
%创建坐标轴CS1
CreateCS(fid);
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
    %改回global CS
    ChangeCS(fid, 0);
    %建立底层线路
    level_s = num2str(level);
    for i = 1:n
        yp = (i - 1) * (d + ys);
        i_n = num2str(i);
        %BoxName = strcat(box,)
        BoxName = strcat('BOX_',level_s);
        BoxName = strcat(BoxName,'_');
        BoxName = strcat(BoxName, i_n);
        %建立底层线路
        MaxBoxFRP(fid, BoxName, ys, yp,zs, zp,FRP_copper);
    end
    fprintf(fid, '\n');
    level_s = num2str(level);
    section_n = count * 2 - 1;
    MaxSection(fid, level_s, n, section_n); %建立截面并添加电流
    %count = count + 1;
end

%% 添加观测区域
ChangeCS(fid, 0);
FRP_vacuum = "vacuum";
BoxName_ob = "BoxObserve";
zs = 345;
zp = 0;
ys = yp+ys;
yp = 0;
MaxBoxFRP(fid, BoxName_ob,ys,yp,zs,zp,FRP_vacuum);

%% 添加analysis
count_i = 10; %迭代次数
p_error = 1;
Maxanlysis(fid,count_i,p_error);

%% 开始运行
MaxRun(fid);

%% 生成观测面并取点

% 导出csv文件

%% 保存文件
hfssSaveProject(fid, tmpPrjFile, true);
fclose(fid);
fclose('all');
