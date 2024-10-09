function x = basicNewtonMethod(f,fd,x0,n)
    x = x0;
    for i = 1:n
        x = x - f(x)/fd(x)
    end
end