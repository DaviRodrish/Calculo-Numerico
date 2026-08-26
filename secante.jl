function secante(f, a, b, tol, max_iter)
    for _ in 1:max_iter
        fa = f(a)
        fb = f(b)
        print("\na: ", a," f(a): ",fa, " b: ",b," f(b): ",fb)
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

f(x) = x^2 + x - 6
a = -5
b = 0
tol = 1e-6
max_iter = 50

raiz = secante(f, a, b, tol, max_iter)
println("\nRaiz encontrada: ", raiz)