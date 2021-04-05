function [B] = MagneticField(cpath,tpos,I)
%MAGNETICFIELD 计算通电导线在指定区域内产生的磁场分布
%   [B] = MagneticField(cpath,tpos);
%   [B] = MagneticField(cpath,tpos,I);
%
%   输入参数：
%           cpath	电流路径坐标数据，1,2,3行分别对应x,y,z坐标
%           tpos	计算目标点坐标数据，1,2,3行分别对应x,y,z坐标
%           I       导线中通入电流大小
%   输出参数：
%           B   磁场值
%
% Author: He Yucheng
% date: 2020-07-07
% version: v1.0
% Email: heyucheng@cqu.edu.cn

if nargin==2        % 判断输入参数个数
    I = 1;
elseif nargin<=1
    error('Please input correct parameters!\nUsage: MagnticField(cpath,tpos,I)',nargin);
end

u0 = pi*4e-7;		% 真空磁导率
npos = size(tpos);      % 
ncp = length(cpath);        % 电流路径点数
B = zeros(3,npos(2));       % 初始化B

for m=1:npos(2)         
    for k=1:(ncp-1)         
        dl(:,k) = cpath(:,k+1)-cpath(:,k);    % dl线段积分微元
        dlpos(:,k) = (cpath(:,k+1)+cpath(:,k))/2;   % dl线段中心坐标
        r = dlpos(:,k) - tpos(:,m);
        dB = u0.*I./(4*pi)*cross(dl(:,k),r)./magnitude(r)^3;    % Biot-Savart law
        B(:,m) = B(:,m)+dB;
    end
end
end

