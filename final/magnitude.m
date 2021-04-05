function [mag] = magnitude(vector)
%MAGNITUDE 计算向量的模值
%   [mag] = magnitude(vector)
%
%   vector     向量
%   mag        模值
%
% Author: Yucheng He
% date: 2020-07-07
% version: v1.0
% Email: heyucheng@cqu.edu.cn

    square = vector.*vector;
    mag = sqrt(sum(square));
end

