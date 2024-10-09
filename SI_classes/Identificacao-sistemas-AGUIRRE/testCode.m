clc;clear;close

% using Newton Method
x0 = 10;
n = 10;
func = @(x) x^3 - 5;
dfunc = @(x) 3*x^2;
basicNewtonMethod(func,dfunc,x0,n)