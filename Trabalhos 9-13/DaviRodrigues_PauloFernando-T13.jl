function legendre(n::Int, t::Real)
    if n == 0
        return 1.0, 0.0
    elseif n == 1
        return Float64(t), 1.0
    end
    p0 = 1.0
    p1 = Float64(t)
    for k in 1:n-1
        p_next = ((2k + 1) * t * p1 - k * p0) / (k + 1)
        p0, p1 = p1, p_next
    end
    dp = (n * (t * p1 - p0)) / (t^2 - 1.0)
    return p1, dp
end

function gauss_pontos_pesos(n::Int)
    if n == 2
        return [-1.0 / sqrt(3.0), 1.0 / sqrt(3.0)], [1.0, 1.0]
    elseif n == 3
        return [-sqrt(3.0 / 5.0), 0.0, sqrt(3.0 / 5.0)], [5.0 / 9.0, 8.0 / 9.0, 5.0 / 9.0]
    end

    t = zeros(Float64, n)
    w = zeros(Float64, n)
    for i in 1:n
        ti = cos(pi * (i - 0.25) / (n + 0.5))
        for _ in 1:100
            p, dp = legendre(n, ti)
            dti = p / dp
            ti -= dti
            if abs(dti) < 1e-15
                break
            end
        end
        p, dp = legendre(n, ti)
        t[i] = ti
        w[i] = 2.0 / ((1.0 - ti^2) * dp^2)
    end
    return t, w
end

function gauss(f::Function, a::Real, b::Real, n::Int)
    t, w = gauss_pontos_pesos(n)
    s = 0.0
    h1 = (a + b) / 2.0
    h2 = (b - a) / 2.0
    for i in 1:n
        s += w[i] * f(h1 + h2 * t[i])
    end
    return h2 * s
end

f(x) = exp(x)
a = 0
b = 1
n = 5

println(gauss(f, a, b, n))
