function lagrange(xk::Vector{<:Real}, yk::Vector{<:Real}, x::Real)
    n = length(xk)
    if n == 0 || length(yk) != n
        throw(ArgumentError("xk e yk devem ter o mesmo tamanho não vazio."))
    end
    if length(unique(xk)) != n
        throw(ArgumentError("Os nós xk devem ser distintos."))
    end


    T = float(promote_type(eltype(xk), eltype(yk), typeof(x)))
    p = zero(T)

    for i in 1:n
        Li = one(T)
        for j in 1:n
            if i != j
                Li *= (x - xk[j]) / (xk[i] - xk[j])
            end
        end
        p += yk[i] * Li
    end

    return p
end

using Printf

xk = [1, 4, 9]
yk = [1, 2, 3]
x = 2

resultado = lagrange(xk, yk, x)
println(resultado)          
println(round(resultado, digits=6)) 
@printf("Resultado: lagrange(xk, yk, x) ≈ %.6f (aproximação de √2).\n", resultado)