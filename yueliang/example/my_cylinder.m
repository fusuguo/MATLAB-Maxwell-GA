% 利用软件包创建一个圆柱体

clear all;

false = 0;
true = 1;

% 圆柱体尺寸
r = 0.5; % 半径
h = 1.0; % 高度

% HFSS执行路径
hfssExePath = 'C:\Program Files\AnsysEM\Maxwell16.0\Win64\maxwell.exe';

% 临时文件路径
tmpPrjFile = 'C:\Users\95340\Desktop\MRI\api\my_conicalhorn.mxwl';
%tmpDataFile = 'E:\ansoft\temp\tmpData.dat';
tmpScriptFile = 'C:\Users\95340\Desktop\MRI\api\my_conicalhorn.vbs';

    % 创建一个新的HFSS临时脚本文件
    fid = fopen(tmpScriptFile, 'wt'); % 'wt'表示以文本模式打开文件，可写，覆盖原有内容 

	% 创建一个新的工程并插入一个新的设计
	hfssNewProject(fid);
	hfssInsertDesign(fid, 'cylinder_test');

	% 创建圆柱体
	hfssCylinder(fid, 'Cylinder', 'Z', [0, 0, 0], r, h, 'mm');

	% 保存工程到临时文件夹
	hfssSaveProject(fid, tmpPrjFile, true);

	% 关闭HFSS脚本文件
	fclose(fid);