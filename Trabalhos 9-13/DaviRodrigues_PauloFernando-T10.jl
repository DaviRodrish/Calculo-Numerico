function spline_natural(xk::Vector{<:Real}, yk::Vector{<:Real})
    n = length(xk)
    if n < 2 || length(yk) != n
        throw(ArgumentError("xk e yk devem ter o mesmo tamanho com pelo menos 2 pontos."))
    end
    if !issorted(xk) || length(unique(xk)) != n
        throw(ArgumentError("Os nós xk devem ser estritamente crescentes."))
    end

    T = float(promote_type(eltype(xk), eltype(yk)))
    x = Vector{T}(xk)
    y = Vector{T}(yk)

    m = n - 1 
    h = [x[i+1] - x[i] for i in 1:m]

    
    d = copy(y[1:m])

    
    b_full = zeros(T, n)

    if n > 2
        
        A = zeros(T, n - 2, n - 2)
        rhs = zeros(T, n - 2)

        for k in 1:(n-2)
            i = k + 1 
            A[k, k] = 2 * (h[i-1] + h[i])
            if k > 1
                A[k, k-1] = h[i-1]
            end
            if k < n - 2
                A[k, k+1] = h[i]
            end
            rhs[k] = 3 * ((y[i+1] - y[i]) / h[i] - (y[i] - y[i-1]) / h[i-1])
        end

        
        b_full[2:n-1] = A \ rhs
    end

    
    a = Vector{T}(undef, m)
    b = Vector{T}(undef, m)
    c = Vector{T}(undef, m)

    for i in 1:m
        b[i] = b_full[i]
        a[i] = (b_full[i+1] - b_full[i]) / (3 * h[i])
        c[i] = (y[i+1] - y[i]) / h[i] - (h[i] / 3) * (b_full[i+1] + 2 * b_full[i])
    end

    return a, b, c, d
end

function avalia_spline(xk::Vector{<:Real}, a::Vector{<:Real}, b::Vector{<:Real},
                     c::Vector{<:Real}, d::Vector{<:Real}, x::Real)
    n = length(xk)
    m = n - 1
    if length(a) != m || length(b) != m || length(c) != m || length(d) != m
        throw(ArgumentError("Os vetores de coeficientes devem ter tamanho length(xk) - 1."))
    end

    
    if x <= xk[1]
        i = 1
    elseif x >= xk[n]
        i = m
    else
        i = searchsortedlast(xk, x)
        i = clamp(i, 1, m)
    end

    dx = x - xk[i]
    return ((a[i] * dx + b[i]) * dx + c[i]) * dx + d[i]
end

xk = [0, 1, 3]
yk = [1, 2, 0]

a, b, c, d = spline_natural(xk, yk)

@show a b c d
println("S(0.5) = ", avalia_spline(xk, a, b, c, d, 0.5))
println("S(2)   = ", avalia_spline(xk, a, b, c, d, 2))