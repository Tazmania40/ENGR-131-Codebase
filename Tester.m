Var1 = 1;

Var2 = 2;

Var3 = 3;

MyVar = MyFunction (Var1, Var2, Var3)

 

function [FuncOut,FuncDone] = MyFunction(V1,V2,V3)

FuncOut = V1+V2+V3;

FuncDone = 1;

end