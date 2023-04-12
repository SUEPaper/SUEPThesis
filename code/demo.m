%% 准备data， 表：每天 WPCR 需求和关键设备工时限制
demand = [39, 36. 38, 40, 37, 33, 40]; %WPCR
working_time = [4500, 2500, 2750, 2100, 2500, 2750, 1500]; %每天的工时限制
%% 使用Yalmip求解
yalmip('clear')
n_days = length(demand);
X = intvar(1, n_days); %每天生产WPCA的数量
Y = binvar(1, n_days); %每天是否生产WPCA

XA = intvar(1, n_days); %每天生产A的数量
YA = binvar(1, n_days); %每天是否生产A
XB = intvar(1, n_days); %每天生产B的数量
YB = binvar(1, n_days); %每天是否生产B
XC = intvar(1, n_days); %每天生产C的数量
YC = binvar(1, n_days); %每天是否生产C

% 可以使用矩阵描述A1A2A3，这里单独描述
XA1 = intvar(1, n_days); %每天生产A1的数量
YA1 = binvar(1, n_days); %每天是否生产A1
XA2 = intvar(1, n_days); %每天生产A2的数量
YA2 = binvar(1, n_days); %每天是否生产A2
XA3 = intvar(1, n_days); %每天生产A3的数量
YA3 = binvar(1, n_days); %每天是否生产A3

XB1 = intvar(1, n_days); %每天生产B1的数量
YB1 = binvar(1, n_days); %每天是否生产B1
XB2 = intvar(1, n_days); %每天生产B2的数量
YB2 = binvar(1, n_days); %每天是否生产B2

XC1 = intvar(1, n_days); %每天生产C1的数量
YC1 = binvar(1, n_days); %每天是否生产C1
XC2 = intvar(1, n_days); %每天生产C2的数量
YC2 = binvar(1, n_days); %每天是否生产C2
XC3 = intvar(1, n_days); %每天生产C3的数量
YC3 = binvar(1, n_days); %每天是否生产C3

%库存量,增加一个初始库存量为0
V = intvar(1, n_days+1);  V(1) = 0; %初始为0
VA = intvar(1, n_days+1); VA(1) = 0; %初始为0
VB = intvar(1, n_days+1); VB(1) = 0; %初始为0
VC = intvar(1, n_days+1); VC(1) = 0; %初始为0

VA1 = intvar(1, n_days+1); VA1(1) = 0; %初始为0
VA2 = intvar(1, n_days+1); VA2(1) = 0; %初始为0
VA3 = intvar(1, n_days+1); VA3(1) = 0; %初始为0
VB1 = intvar(1, n_days+1); VB1(1) = 0; %初始为0
VB2 = intvar(1, n_days+1); VB2(1) = 0; %初始为0
VC1 = intvar(1, n_days+1); VC1(1) = 0; %初始为0
VC2 = intvar(1, n_days+1); VC2(1) = 0; %初始为0
VC3 = intvar(1, n_days+1); VC3(1) = 0; %初始为0
%更新储存量
for k=1:n_days
    V(k+1) = V(k) + X(k) - demand(k);
    
    VA(k+1) = VA(k) + XA(k) - 3*X(k);
    VB(k+1) = VB(k) + XB(k) - 4*X(k);
    VC(k+1) = VC(k) + XC(k) - 5*X(k);
    
    VA1(k+1) = VA1(k) + XA1(k) - 18*X(k);
    VA2(k+1) = VA2(k) + XA2(k) - 24*X(k);
    VA3(k+1) = VA3(k) + XA3(k) - 6*X(k);
    
    VB1(k+1) = VB1(k) + XB1(k) - 8*X(k);
    VB2(k+1) = VB2(k) + XB2(k) - 16*X(k);
    
    VC1(k+1) = VC1(k) + XC1(k) - 40*X(k);
    VC2(k+1) = VC2(k) + XC2(k) - 10*X(k);
    VC3(k+1) = VC3(k) + XC3(k) - 60*X(k);
end

%成本1
C_I = 240*sum(Y)+5 * sum(V);
%成本2
C_II = 120*sum(YA)+ 2*sum(VA) +...
       160*sum(YB)+ 1.5*sum(VB)+...
       180*sum(YC)+ 1.7*sum(VC);  
%成本3
C_III = 40*sum(YA1)+ 5*sum(VA1) + 60*sum(YA2)+ 3*sum(VA2) + 50*sum(YA3)+ 6*sum(VA3) +...
       80*sum(YB1)+ 4*sum(VB1)+ 100*sum(YB2)+ 5*sum(VB2)+...
       60*sum(YC1)+ 3*sum(VC1) + 40*sum(YC2)+ 2*sum(VC2) + 70*sum(YC3)+ 3*sum(VC3);
%系统总成本
Objective = C_I + C_II + C_III;

%约束条件

constraints = [X>=0; 
              XA>=0; XB>=0; XC>=0;
              XA1>=0; XA2>=0; XA3>=0;
              XB1>=0; XB2>=0;
              XC1>=0; XC2>=0; XC3>=0;
              V>=0;
              VA>=0; VB>=0; VC>=0;
              VA1>=0; VA2>=0; VA3>=0;
              VB1>=0; VB2>=0;
              VC1>=0; VC2>=0; VC3>=0];%每天生产WPCA的数量大于0
BIG_M = 1e6; %分段函数引入的无穷大数
constraints = [constraints;
                X <= BIG_M * Y;
                XA <= BIG_M * YA;
                XB <= BIG_M * YB;
                XC <= BIG_M * YC;
                XA1 <= BIG_M * YA1; XA2 <= BIG_M * YA2; XA3 <= BIG_M * YA3;
                XB1 <= BIG_M * YB1; XB2 <= BIG_M * YB2;
                XC1 <= BIG_M * YC1; XC2 <= BIG_M * YC2; XC3 <= BIG_M * YC3;];
%总工时限制
constraints = [constraints;
    3 * XA+ 5*XB + 5*XC <= working_time];
   
%% solve the problem
options = sdpsettings('verbose',0,'solver','cplex','allownonconvex',0,'debug', 1);
sol = optimize(constraints, Objective, options);
solution = [];%初始化解

if sol.problem ==0
    %extract and display value
    solution_X = value(X)   %每天生产WPCR的数量
    solution_Y = value(Y)   %每天生产WPCR与否
    
    solution_XA = value(XA);   %每天生产A的数量
    solution_YA = value(YA);   %每天生产A与否
    
    solution_XB = value(XB);   %每天生产B的数量
    solution_YB = value(YB);   %每天生产B与否
    
    solution_XC = value(XC);   %每天生产C的数量
    solution_YC = value(YC);   %每天生产C与否
    
    solution_XA1 = value(XA1);   %每天生产A1的数量
    solution_YA1 = value(YA1);   %每天生产A1与否
    
    solution_XA2 = value(XA2);   %每天生产A2的数量
    solution_YA2 = value(YA2);   %每天生产A2与否
    
    solution_XA3 = value(XA3);   %每天生产A3的数量
    solution_YA3 = value(YA3);   %每天生产A3与否
    
    solution_XB1 = value(XB1);   %每天生产B1的数量
    solution_YB1 = value(YB1);   %每天生产B1与否
    
    solution_XB2 = value(XB2);   %每天生产B2的数量
    solution_YB2 = value(YB2);   %每天生产B2与否
    
    solution_XC1 = value(XC1);   %每天生产C1的数量
    solution_YC1 = value(YC1);   %每天生产C1与否
    
    solution_XC2 = value(XC2);   %每天生产C2的数量
    solution_YC2 = value(YC2);   %每天生产C2与否
    
    solution_XC3 = value(XC3);   %每天生产C3的数量
    solution_YC3 = value(YC3);   %每天生产C3与否
    
    
    COST_ALL      =   value(Objective)  %总成本
    RESULT_TABLE = [];
    for k=1:n_days
        temp_prepare = 240*(solution_Y(k) + 120*solution_YA(k)+ ...
                      160*solution_YB(k) +180*solution_YC(k)+...
                      40*solution_YA1(k)+ 60*solution_YA2(k)+ 50*solution_YA3(k) +...
                      80*solution_YB1(k))+ 100*solution_YB2(k)+...
                      60*solution_YC1(k)+ 40*solution_YC2(k)+70*solution_YC3(k);
        temp_storage = value(5 * V(k)+ 2*VA(k) + 1.5*VB(k)+ 1.7*VC(k)+...
                       5*VA1(k) +  3*VA2(k) + 6*VA3(k) +...
                       4*VB1(k)+ + 5*VB2(k)+...
                        3*VC1(k) + 2*VC2(k) +  3*VC3(k));   
        RESULT_TABLE = [RESULT_TABLE;
               solution_X(k), solution_XA(k), solution_XB(k), solution_XC(k),...
                temp_prepare, temp_storage              ];
    end
    
    result_I = [solution_X
                solution_Y
                solution_XA
                solution_YA
                solution_XB
                solution_YB
                solution_XC
                solution_YC]
    result_II = [solution_XA1
                    solution_YA1
                    solution_XA2
                    solution_YA2
                    solution_XA3
                    solution_YA2          
                      solution_XB1
                      solution_YB1
                      solution_XB2
                     solution_YB2
                      solution_XC1
                      solution_YC1
                      solution_XC2
                     solution_YC2
                      solution_XC3
                     solution_YC3]          
else
    display('Hmm, something went wrong')
end
save Problem01_result RESULT_TABLE result_I result_II