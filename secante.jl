function secante(f, a, b, tol, max_iter)
    for _ in 1:max_iter
        fa = f(a)
        fb = f(b)
        
        if fb == fa
            return b
        end
        
        x = b - fb * (b - a) / (fb - fa)
        
        if abs(x - b) < tol
            return x
        end
        
        a, b = b, x
    end
    return b
end

f(x) = exp(x) - 3*x
a = 0.0
b = 1.0
tol = 1e-6
max_iter = 50

raiz = secante(f, a, b, tol, max_iter)
println(raiz)