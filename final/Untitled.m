clc;clear;    
a = [];
    d = 10;
    n = 13;
    ys = (390 - (n - 1) * d) / n;
    n1 = 3;
    n2 = 3;
    n3 = 3;
    zstandard = 21;
    PointLocation = 1;
    n_num = 1;
    for points = 1:4*n
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
%             if mod(n,2) == 1 % odd
%                 n_num = floor((points+2)/4);
%                 d = 
%             else
%                 
%             end
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
                    a(1,nn) = x;
                    a(2,nn) = y + d + ys;
                    a(3,nn) = 0;
                    break
                end
                a(1,nn) = x;
                a(2,nn) = y + (d+ys)/(n3+1) * initalp;
                a(3,nn) = zstandard - zstandard / (n3 + 1) * initalp;
                initalp = initalp + 1;
            end
        PointLocation = PointLocation + n3 + 1;
        end
    end
%     
%     for points = 4*n+1: 2*4*n
%         
%     if points == 4*n+1
%         x = 540;
%         y = ys / 2;
%         z = 316;
%         condition = 1;
%     end
% 
%     if points == 4*n + 2 % x卤浠?0
%         x = 0;
%         y = y;
%         z = 316;
%         condition = 2;                
%     end
% 
%     if mod(points + 2, 4) == 1 && points > 2
%         x = 0;
%         y = y;
%         z = 316 + zstandard;
%         condition = 1;
%     elseif mod(points + 2, 4) == 2 && points > 2
%         x = 540;
%         y = y; 
%         z = 316 + zstandard;
%         condition = 3;
%     elseif mod(points + 2, 4) == 3 && points > 2
%         x = 540;
%         y = y + d + ys;
%         z = 316;
%         condition = 1;
%     elseif mod(points + 2, 4) == 0 && points > 2
%         x = 0;
%         y = y;
%         z = 316;
%         condition = 2;
%     end
% 
%     if condition == 1 % x变
%         initalp = 0;
% 
%         for nn = PointLocation:PointLocation + n1 + 1
% 
%             if nn == PointLocation + n1 + 1
% 
%                 if x == 0
%                     a(1, nn) = 540;
%                     a(2, nn) = y;
%                     a(3, nn) = z;
%                 else
%                     a(1, nn) = 0;
%                     a(2, nn) = y;
%                     a(3, nn) = z;
%                 end
% 
%                 break
%             end
% 
%             if x == 0
%                 a(1, nn) = 540 / (n1 + 1) * initalp;
%                 initalp = initalp + 1;
%                 a(2, nn) = y;
%                 a(3, nn) = z;
%             else
%                 a(1, nn) = 540 - 540 / (n1 + 1) * initalp;
%                 initalp = initalp + 1;
%                 a(2, nn) = y;
%                 a(3, nn) = z;
%             end
% 
%         end
% 
%         PointLocation = PointLocation + n1 + 1;
%     end
% 
%     if condition == 2 % z变
%         initalp = 0;
% 
%         for nn = PointLocation:PointLocation + n2 + 1
% 
%             if nn == PointLocation + n2 + 1
% 
%                 if z == 0
%                     a(1, nn) = x;
%                     a(2, nn) = y;
%                     a(3, nn) = 316 + zstandard;
%                 else
%                     a(1, nn) = x;
%                     a(2, nn) = y;
%                     a(3, nn) = 316;
%                 end
% 
%                 break
%             end
% 
%             if z == 0
%                 a(1, nn) = x;
%                 a(2, nn) = y;
%                 a(3, nn) = 316 + zstandard / (n2 + 1) * initalp;
%                 initalp = initalp + 1;
%             else
%                 a(1, nn) = x;
%                 a(2, nn) = y;
%                 a(3, nn) = 316 + zstandard - zstandard / (n2 + 1) * initalp;
%                 initalp = initalp + 1;
%             end
% 
%         end
%     PointLocation = PointLocation + n2 + 1;
%     end
% 	
% 	if condition == 3
% 		initalp = 0;
% 		
% 		for nn = PointLocation:PointLocation + n3 + 1
% 			if nn == PointLocation + n3 + 1
% 				a(1,nn) = x;
% 				a(2,nn) = y + d + ys;
% 				a(3,nn) = 316;
% 				break
% 			end
% 			
% 			a(1,nn) = x;
% 			a(2,nn) = y + (d+ys)/(n3+1) * initalp;
% 			a(3,nn) = 316 + zstandard - zstandard / (n3 + 1) * initalp;
% 			initalp = initalp + 1;
% 		
% 		end
% 	PointLocation = PointLocation + n3 + 1;
% 	end
%     end