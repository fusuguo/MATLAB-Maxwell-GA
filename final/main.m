%% 开始
clear; clc;
false = 0;
true = 1;
%% 初始值 + 父代
N = 0; %初始个体数（从0到20）
N_total = 120; %总体个体数
Chrom = zeros (N_total, 14);
% 把种群中的n和d实数化(这个是第一次交叉种群的n和d的实数值)
Chrom_dig_n = zeros(N_total, 1);
Chrom_dig_d = zeros(N_total, 1);
data_need = zeros(N_total, 3);

while (N < N_total)
    var = crtbp(1, 14);
    var_str = num2str(var); %把二进制变字符串
    var_str = strrep(var_str, ' ', ''); %去除字符串内空格
    % var_str = deblank(var_str);        %去除首尾的多余空格
    var_str_n = var_str(1:6);
    var_str_d = var_str(7:14); %取出n和d的值
    % var_dig_n = str2num(var_str_n); var_dig_d = str2num(var_str_n); %把字符串变二进制
    var_10_n = bin2dec (var_str_n);
    var_10_d = bin2dec (var_str_d);

    if (var_10_n * var_10_d) < 390 && (var_10_n * var_10_d) > 0 && (var_10_n <= 50) && (var_10_n >= 3)
        N = N + 1;
        Chrom_dig_n(N, 1) = var_10_n;
        Chrom_dig_d(N, 1) = var_10_d;

        for i = 1:14
            Chrom(N, i) = var(1, i);
        end

    end

end

%% 开始计算（父代）
for e = 1:N_total

    %% 微分线段
    a = [];
    d = Chrom_dig_d(e, 1);
    n = Chrom_dig_n(e, 1);
    ys = (390 - (n - 1) * d) / n;
    n1 = 52;
    n2 = 3;
    n3 = 3;

    zstandard = 21;

    PointLocation = 1;

    for points = 1:4 * n - 1

        if points == 1
            x = 540;
            y = ys / 2;
            z = 0;
            condition = 1;
        end

        if points == 2 % x卤浠?0
            x = 0;
            y = y;
            z = 0;
            condition = 2;
        end

        if mod(points + 2, 4) == 1 && points > 2
            x = 0;
            y = y;
            z = zstandard;
            condition = 1;
        elseif mod(points + 2, 4) == 2 && points > 2
            x = 540;
            y = y;
            z = zstandard;
            condition = 3;
        elseif mod(points + 2, 4) == 3 && points > 2
            x = 540;
            y = y + d + ys;
            z = 0;
            condition = 1;
        elseif mod(points + 2, 4) == 0 && points > 2
            x = 0;
            y = y;
            z = 0;
            condition = 2;
        end

        if condition == 1 % x变
            initalp = 0;

            for nn = PointLocation:PointLocation + n1 + 1

                if nn == PointLocation + n1 + 1

                    if x == 0
                        a(1, nn) = 540;
                        a(2, nn) = y;
                        a(3, nn) = z;
                    else
                        a(1, nn) = 0;
                        a(2, nn) = y;
                        a(3, nn) = z;
                    end

                    break
                end

                if x == 0
                    a(1, nn) = 540 / (n1 + 1) * initalp;
                    initalp = initalp + 1;
                    a(2, nn) = y;
                    a(3, nn) = z;
                else
                    a(1, nn) = 540 - 540 / (n1 + 1) * initalp;
                    initalp = initalp + 1;
                    a(2, nn) = y;
                    a(3, nn) = z;
                end

            end

            PointLocation = PointLocation + n1 + 1;
        end

        if condition == 2 % z变
            initalp = 0;

            for nn = PointLocation:PointLocation + n2 + 1

                if nn == PointLocation + n2 + 1

                    if z == 0
                        a(1, nn) = x;
                        a(2, nn) = y;
                        a(3, nn) = zstandard;
                    else
                        a(1, nn) = x;
                        a(2, nn) = y;
                        a(3, nn) = 0;
                    end

                    break
                end

                if z == 0
                    a(1, nn) = x;
                    a(2, nn) = y;
                    a(3, nn) = zstandard / (n2 + 1) * initalp;
                    initalp = initalp + 1;
                else
                    a(1, nn) = x;
                    a(2, nn) = y;
                    a(3, nn) = zstandard - zstandard / (n2 + 1) * initalp;
                    initalp = initalp + 1;
                end

            end

            PointLocation = PointLocation + n2 + 1;
        end

        if condition == 3
            initalp = 0;

            for nn = PointLocation:PointLocation + n3 + 1

                if nn == PointLocation + n3 + 1
                    a(1, nn) = x;
                    a(2, nn) = y + d + ys;
                    a(3, nn) = 0;
                    break
                end

                a(1, nn) = x;
                a(2, nn) = y + (d + ys) / (n3 + 1) * initalp;
                a(3, nn) = zstandard - zstandard / (n3 + 1) * initalp;
                initalp = initalp + 1;

            end

            PointLocation = PointLocation + n3 + 1;
        end

    end

    z_high = 316;

    for points = 1:4 * n - 1

        if points == 1
            x = 540;
            y = y;
            z = z_high;
            condition = 1;
        end

        if points == 2 % x卤浠?0
            x = 0;
            y = y;
            z = z_high;
            condition = 2;
        end

        if mod(points + 2, 4) == 1 && points > 2
            x = 0;
            y = y;
            z = z_high + zstandard;
            condition = 1;
        elseif mod(points + 2, 4) == 2 && points > 2
            x = 540;
            y = y;
            z = z_high + zstandard;
            condition = 3;
        elseif mod(points + 2, 4) == 3 && points > 2
            x = 540;
            y = y - d - ys;
            z = z_high;
            condition = 1;
        elseif mod(points + 2, 4) == 0 && points > 2
            x = 0;
            y = y;
            z = z_high;
            condition = 2;
        end

        if condition == 1 % x变
            initalp = 0;

            for nn = PointLocation:PointLocation + n1 + 1

                if nn == PointLocation + n1 + 1

                    if x == 0
                        a(1, nn) = 540;
                        a(2, nn) = y;
                        a(3, nn) = z;
                    else
                        a(1, nn) = 0;
                        a(2, nn) = y;
                        a(3, nn) = z;
                    end

                    break
                end

                if x == 0
                    a(1, nn) = 540 / (n1 + 1) * initalp;
                    initalp = initalp + 1;
                    a(2, nn) = y;
                    a(3, nn) = z;
                else
                    a(1, nn) = 540 - 540 / (n1 + 1) * initalp;
                    initalp = initalp + 1;
                    a(2, nn) = y;
                    a(3, nn) = z;
                end

            end

            PointLocation = PointLocation + n1 + 1;
        end

        if condition == 2 % z变
            initalp = 0;

            for nn = PointLocation:PointLocation + n2 + 1

                if nn == PointLocation + n2 + 1

                    if z == z_high
                        a(1, nn) = x;
                        a(2, nn) = y;
                        a(3, nn) = z_high + zstandard;
                    else
                        a(1, nn) = x;
                        a(2, nn) = y;
                        a(3, nn) = z_high;
                    end

                    break
                end

                if z == z_high
                    a(1, nn) = x;
                    a(2, nn) = y;
                    a(3, nn) = z_high + zstandard / (n2 + 1) * initalp;
                    initalp = initalp + 1;
                else
                    a(1, nn) = x;
                    a(2, nn) = y;
                    a(3, nn) = z_high + zstandard - zstandard / (n2 + 1) * initalp;
                    initalp = initalp + 1;
                end

            end

            PointLocation = PointLocation + n2 + 1;
        end

        if condition == 3
            initalp = 0;

            for nn = PointLocation:PointLocation + n3 + 1

                if nn == PointLocation + n3 + 1
                    a(1, nn) = x;
                    a(2, nn) = y - d - ys;
                    a(3, nn) = z_high;
                    break
                end

                a(1, nn) = x;
                a(2, nn) = y - (d + ys) / (n3 + 1) * initalp;
                a(3, nn) = z_high + zstandard - zstandard / (n3 + 1) * initalp;
                initalp = initalp + 1;

            end

            PointLocation = PointLocation + n3 + 1;
        end

    end

    %% 取观测点
    %O.= [270;195;169]
    mun = 180 * 19 + 2;
    star_1 = 0;
    star_2 = 0;
    z_o = 169;
    location = zeros(3, mun);

    for h = -90:10:90
        location(3, star_1 + 1:star_1 + 180) = z_o + h;
        r = ((100)^2 - (abs(h))^2)^(1/2);

        for i = 0:1:179
            star_2 = star_2 + 1;
            location(1, star_2) = 270 + r * cosd(i * 2);
            location(2, star_2) = 195 + r * sind(i * 2);
        end

        star_1 = star_1 + 180;
    end

    location(1, mun - 1) = 270;
    location(2, mun - 1) = 195;
    location(3, mun - 1) = 169;
    location(1, mun) = 270;
    location(2, mun) = 195;
    location(3, mun) = 69;
    %% 取不均匀度
    MagData = MagneticField(a, location);
    data_need(e, 1) = max(max(MagData(2, :)));
    data_need(e, 2) = min(min(MagData(2, :)));
    data_need(e, 3) = (data_need(e, 1) - data_need(e, 2)) / ((data_need(e, 1) + data_need(e, 2)) / 2);
end

%% 开始子代计算
for yr = 1:300
    %% 引入父代并创建子代种群
    %相关参数
    GGAP = 0.9; %代沟
    year = num2str(yr);
    Pm_1 = 0.2; %变异概率
    Pm_2 = 0.2;
    k_1 = 3; %n基因的交叉点
    k_2 = 4; %d基因的交叉点
    n_max = 100;
    d_max = 200;
    SUBPOP = 1; %（P88）
    InsOpt = [0, 1]; %子代替代方式 （P88）
    %for i = 1:N_total
    %    data_need(i, 3) = (data_need(i, 1) - data_need(i, 2)) / ((data_need(i, 1) + data_need(i, 2)) / 2);
    %end
    [min_1, loc] = min(data_need(:, 3));
    FintV = ranking(data_need(:, 3)); %分配适应度值
    SelCh = select('sus', Chrom, FintV); %选择
    %[m,n]=size(SelCh);
    SelCh_str = num2str(SelCh);
    SelCh_str = char(strrep(cellstr(SelCh_str), ' ', '')); %去除字符串内空格

    for i = 1:N_total
        SelCh_str_n(i, 1:6) = SelCh_str(i, 1:6);
        SelCh_str_d(i, 1:8) = SelCh_str(i, 7:14);
    end

    %去空格
    %SelCh_dig_n = zeros (x,1); SelCh_dig_d = zeros (x,1);
    SelCh_dig_n = zeros(N_total, 6); SelCh_dig_d = zeros(N_total, 8);

    for i = 1:N_total

        for n_1 = 1:6
            SelCh_dig_n(i, n_1) = str2double(SelCh_str_n(i, n_1));
            %SelCh_str_n_new(i,:) = dec2bin(SelCh_dig_n(i,:));
        end

        for m_1 = 1:8
            SelCh_dig_d(i, m_1) = str2double(SelCh_str_d(i, m_1));
            %SelCh_str_d_new(i,:) = dec2bin(SelCh_dig_d(i,:));
        end

    end

    %SelCh_str_d = char(strrep(cellstr(SelCh_str_d),' ',''));  %去除字符串内空格
    %recombin part
    %SelCh_n = recombin('xovsp',SelCh_str_n);
    %SelCh_d = recombin('xovsp',SelCh_str_d);
    %交叉基因
    SelCh_n = xovsp (SelCh_dig_n, k_1);
    SelCh_d = xovsp (SelCh_dig_d, k_2);
    %变异
    SelCh_n = mut(SelCh_n, Pm_1);
    SelCh_d = mut(SelCh_d, Pm_2);
    SelCh_new = [SelCh_n, SelCh_d]; %把基因片段组合起来
    %变异
    %SelCh_new = mutate('mut',SelCh_new);
    %Chrom = reins(Chrom, SelCh, SUBPOP, InsOpt);
    Chrom = SelCh_new;
    %数据重置
    data_need = zeros(N_total, 3);
    Chrom_dig_n = zeros(N_total, 1);
    Chrom_dig_d = zeros(N_total, 1);
    Chrom_str = num2str(Chrom);
    Chrom_str = char(strrep(cellstr(Chrom_str), ' ', '')); %去除字符串内空格

    for i = 1:N_total
        Chrom_10_n = Chrom_str(i, 1:6);
        Chrom_dig_n(i, 1) = bin2dec (Chrom_10_n);
        Chrom_10_d = Chrom_str(i, 7:14);
        Chrom_dig_d(i, 1) = bin2dec (Chrom_10_d);
    end

    for i = 1:N_total

        if Chrom_dig_n(i, 1) <= 3 || Chrom_dig_n(i, 1) > n_max || (Chrom_dig_n(i, 1) - 1) * Chrom_dig_d(i, 1) > 390 || Chrom_dig_d(i, 1) <= 0 || Chrom_dig_d(i, 1) > d_max
            N_1 = 0;

            while N_1 <= 0
                var_new = crtbp(1, 14);
                var_new_str = num2str(var_new); %把二进制变字符串
                var_new_str = strrep(var_new_str, ' ', ''); %去除字符串内空格
                var_new_str_n = var_new_str(1:6);
                var_new_str_d = var_new_str(7:14); %取出n和d的值
                var_new_10_n = bin2dec (var_new_str_n);
                var_new_10_d = bin2dec (var_new_str_d);

                if (var_new_10_n * var_new_10_d) < 390 && (var_new_10_n * var_new_10_d) > 0 && (var_new_10_n <= 50) && (var_new_10_n >= 3)
                    N_1 = N_1 + 1;
                    Chrom_dig_n(i, 1) = var_new_10_n;
                    Chrom_dig_d(i, 1) = var_new_10_d;

                    for j = 1:14
                        Chrom(i, j) = var_new(1, j);
                    end

                end

            end

            %            Chrom_dig_n(i, 1) = bin2dec (SelCh_str_n(loc,:));
            %            Chrom(i,1:6) = SelCh(loc,1:6);
            %        end
            %        if Chrom_dig_d(i, 1)<= 0 || Chrom_dig_d(i, 1)> d_max || Chrom_dig_n(i, 1)*Chrom_dig_d(i, 1) > 390
            %            Chrom_dig_d(i, 1) = bin2dec (SelCh_str_d(loc,:));
            %            Chrom(i,7:14) = SelCh(loc,7:14);
        end

    end

    %% 开始计算子代
    for e = 1:N_total
        %% 微分线段
        %% 微分线段
        a = [];
        d = Chrom_dig_d(e, 1);
        n = Chrom_dig_n(e, 1);
        ys = (390 - (n - 1) * d) / n;
        n1 = 52;
        n2 = 3;
        n3 = 3;

        zstandard = 21;

        PointLocation = 1;

        for points = 1:4 * n - 1

            if points == 1
                x = 540;
                y = ys / 2;
                z = 0;
                condition = 1;
            end

            if points == 2 % x卤浠?0
                x = 0;
                y = y;
                z = 0;
                condition = 2;
            end

            if mod(points + 2, 4) == 1 && points > 2
                x = 0;
                y = y;
                z = zstandard;
                condition = 1;
            elseif mod(points + 2, 4) == 2 && points > 2
                x = 540;
                y = y;
                z = zstandard;
                condition = 3;
            elseif mod(points + 2, 4) == 3 && points > 2
                x = 540;
                y = y + d + ys;
                z = 0;
                condition = 1;
            elseif mod(points + 2, 4) == 0 && points > 2
                x = 0;
                y = y;
                z = 0;
                condition = 2;
            end

            if condition == 1 % x变
                initalp = 0;

                for nn = PointLocation:PointLocation + n1 + 1

                    if nn == PointLocation + n1 + 1

                        if x == 0
                            a(1, nn) = 540;
                            a(2, nn) = y;
                            a(3, nn) = z;
                        else
                            a(1, nn) = 0;
                            a(2, nn) = y;
                            a(3, nn) = z;
                        end

                        break
                    end

                    if x == 0
                        a(1, nn) = 540 / (n1 + 1) * initalp;
                        initalp = initalp + 1;
                        a(2, nn) = y;
                        a(3, nn) = z;
                    else
                        a(1, nn) = 540 - 540 / (n1 + 1) * initalp;
                        initalp = initalp + 1;
                        a(2, nn) = y;
                        a(3, nn) = z;
                    end

                end

                PointLocation = PointLocation + n1 + 1;
            end

            if condition == 2 % z变
                initalp = 0;

                for nn = PointLocation:PointLocation + n2 + 1

                    if nn == PointLocation + n2 + 1

                        if z == 0
                            a(1, nn) = x;
                            a(2, nn) = y;
                            a(3, nn) = zstandard;
                        else
                            a(1, nn) = x;
                            a(2, nn) = y;
                            a(3, nn) = 0;
                        end

                        break
                    end

                    if z == 0
                        a(1, nn) = x;
                        a(2, nn) = y;
                        a(3, nn) = zstandard / (n2 + 1) * initalp;
                        initalp = initalp + 1;
                    else
                        a(1, nn) = x;
                        a(2, nn) = y;
                        a(3, nn) = zstandard - zstandard / (n2 + 1) * initalp;
                        initalp = initalp + 1;
                    end

                end

                PointLocation = PointLocation + n2 + 1;
            end

            if condition == 3
                initalp = 0;

                for nn = PointLocation:PointLocation + n3 + 1

                    if nn == PointLocation + n3 + 1
                        a(1, nn) = x;
                        a(2, nn) = y + d + ys;
                        a(3, nn) = 0;
                        break
                    end

                    a(1, nn) = x;
                    a(2, nn) = y + (d + ys) / (n3 + 1) * initalp;
                    a(3, nn) = zstandard - zstandard / (n3 + 1) * initalp;
                    initalp = initalp + 1;

                end

                PointLocation = PointLocation + n3 + 1;
            end

        end

        z_high = 316;

        for points = 1:4 * n - 1

            if points == 1
                x = 540;
                y = y;
                z = z_high;
                condition = 1;
            end

            if points == 2 % x卤浠?0
                x = 0;
                y = y;
                z = z_high;
                condition = 2;
            end

            if mod(points + 2, 4) == 1 && points > 2
                x = 0;
                y = y;
                z = z_high + zstandard;
                condition = 1;
            elseif mod(points + 2, 4) == 2 && points > 2
                x = 540;
                y = y;
                z = z_high + zstandard;
                condition = 3;
            elseif mod(points + 2, 4) == 3 && points > 2
                x = 540;
                y = y - d - ys;
                z = z_high;
                condition = 1;
            elseif mod(points + 2, 4) == 0 && points > 2
                x = 0;
                y = y;
                z = z_high;
                condition = 2;
            end

            if condition == 1 % x变
                initalp = 0;

                for nn = PointLocation:PointLocation + n1 + 1

                    if nn == PointLocation + n1 + 1

                        if x == 0
                            a(1, nn) = 540;
                            a(2, nn) = y;
                            a(3, nn) = z;
                        else
                            a(1, nn) = 0;
                            a(2, nn) = y;
                            a(3, nn) = z;
                        end

                        break
                    end

                    if x == 0
                        a(1, nn) = 540 / (n1 + 1) * initalp;
                        initalp = initalp + 1;
                        a(2, nn) = y;
                        a(3, nn) = z;
                    else
                        a(1, nn) = 540 - 540 / (n1 + 1) * initalp;
                        initalp = initalp + 1;
                        a(2, nn) = y;
                        a(3, nn) = z;
                    end

                end

                PointLocation = PointLocation + n1 + 1;
            end

            if condition == 2 % z变
                initalp = 0;

                for nn = PointLocation:PointLocation + n2 + 1

                    if nn == PointLocation + n2 + 1

                        if z == z_high
                            a(1, nn) = x;
                            a(2, nn) = y;
                            a(3, nn) = z_high + zstandard;
                        else
                            a(1, nn) = x;
                            a(2, nn) = y;
                            a(3, nn) = z_high;
                        end

                        break
                    end

                    if z == z_high
                        a(1, nn) = x;
                        a(2, nn) = y;
                        a(3, nn) = z_high + zstandard / (n2 + 1) * initalp;
                        initalp = initalp + 1;
                    else
                        a(1, nn) = x;
                        a(2, nn) = y;
                        a(3, nn) = z_high + zstandard - zstandard / (n2 + 1) * initalp;
                        initalp = initalp + 1;
                    end

                end

                PointLocation = PointLocation + n2 + 1;
            end

            if condition == 3
                initalp = 0;

                for nn = PointLocation:PointLocation + n3 + 1

                    if nn == PointLocation + n3 + 1
                        a(1, nn) = x;
                        a(2, nn) = y - d - ys;
                        a(3, nn) = z_high;
                        break
                    end

                    a(1, nn) = x;
                    a(2, nn) = y - (d + ys) / (n3 + 1) * initalp;
                    a(3, nn) = z_high + zstandard - zstandard / (n3 + 1) * initalp;
                    initalp = initalp + 1;

                end

                PointLocation = PointLocation + n3 + 1;
            end

        end

        %% 取观测点
        %O.= [270;195;169]
        mun = 180 * 19 + 2;
        star_1 = 0;
        star_2 = 0;
        z_o = 169;
        location = zeros(3, mun);

        for h = -90:10:90
            location(3, star_1 + 1:star_1 + 180) = z_o + h;
            r = ((100)^2 - (abs(h))^2)^(1/2);

            for i = 0:1:179
                star_2 = star_2 + 1;
                location(1, star_2) = 270 + r * cosd(i * 2);
                location(2, star_2) = 195 + r * sind(i * 2);
            end

            star_1 = star_1 + 180;
        end

        location(1, mun - 1) = 270;
        location(2, mun - 1) = 195;
        location(3, mun - 1) = 169;
        location(1, mun) = 270;
        location(2, mun) = 195;
        location(3, mun) = 69;
        %% 取不均匀度
        MagData = MagneticField(a, location);
        data_need(e, 1) = max(max(MagData(2, :)));
        data_need(e, 2) = min(min(MagData(2, :)));
        data_need(e, 3) = (data_need(e, 1) - data_need(e, 2)) / ((data_need(e, 1) + data_need(e, 2)) / 2);
        FileName = 'Report_Year_';
        FileName = strcat(FileName, year);
        FileName = strcat(FileName, '.csv');
        T = table(Chrom_dig_n, Chrom_dig_d, data_need(:, 1), data_need(:, 2), data_need(:, 3));
        writetable(T, FileName)
        
    end
fprintf('%s is done!\n',FileName);
end
