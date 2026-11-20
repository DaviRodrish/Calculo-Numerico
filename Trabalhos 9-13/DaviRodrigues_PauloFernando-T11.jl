# ---------------------------------------------------------
# 1. Métodos para integração de uma função f em [a, b]
# ---------------------------------------------------------

function ponto_medio(f::Function, a::Real, b::Real, m::Int)
    if m < 1
        throw(ArgumentError("O número de subintervalos m deve ser >= 1."))
    end
    h = (b - a) / m
    soma = sum(f(a + (i - 0.5) * h) for i in 1:m)
    return h * soma
end

function trapezios(f::Function, a::Real, b::Real, m::Int)
    if m < 1
        throw(ArgumentError("O número de subintervalos m deve ser >= 1."))
    end
    h = (b - a) / m
    soma = 0.5 * (f(a) + f(b)) + sum(f(a + i * h) for i in 1:(m - 1); init=0.0)
    return h * soma
end

function simpson(f::Function, a::Real, b::Real, m::Int)
    if m < 2 || isodd(m)
        throw(ArgumentError("Para a regra de Simpson, m deve ser um inteiro par >= 2."))
    end
    h = (b - a) / m
    soma_impares = sum(f(a + i * h) for i in 1:2:(m - 1))
    soma_pares   = sum(f(a + i * h) for i in 2:2:(m - 2); init=0.0)
    return (h / 3) * (f(a) + f(b) + 4 * soma_impares + 2 * soma_pares)
end

# ---------------------------------------------------------
# 2. Métodos via despacho múltiplo para valores tabelados y
# ---------------------------------------------------------

function trapezios(y::Vector{<:Real}, h::Real)
    n = length(y)
    if n < 2
        throw(ArgumentError("O vetor y deve conter pelo menos 2 pontos (m >= 1)."))
    end
    soma = 0.5 * (y[1] + y[end]) + sum(y[2:(end - 1)]; init=0.0)
    return h * soma
end

function simpson(y::Vector{<:Real}, h::Real)
    n = length(y)
    m = n - 1 # n pontos equivalem a m = n - 1 subintervalos
    if m < 2 || isodd(m)
        throw(ArgumentError("O vetor y deve ter um número ímpar de pontos >= 3 (m = length(y) - 1 par)."))
    end
    soma_impares = sum(y[2:2:(end - 1)])      # índices pares em 1-based correspondem a x_1, x_3, ...
    soma_pares   = sum(y[3:2:(end - 2)]; init=0.0) # índices ímpares internos correspondem a x_2, x_4, ...
    return (h / 3) * (y[1] + y[end] + 4 * soma_impares + 2 * soma_pares)
end

using Printf

f(x) = 1 / x
a, b, m = 1, 2, 4

@printf("ponto_medio(f, 1, 2, 4) ≈ %.6f\n", ponto_medio(f, a, b, m))
@printf("trapezios(f, 1, 2, 4)   ≈ %.6f\n", trapezios(f, a, b, m))
@printf("simpson(f, 1, 2, 4)     ≈ %.6f\n", simpson(f, a, b, m))
@printf("Valor exato: ln 2       ≈ %.6f\n\n", log(2))

y = [1, 1/1.25, 1/1.5, 1/1.75, 1/2]
h = 0.25

@printf("trapezios(y, h)         ≈ %.6f\n", trapezios(y, h))
@printf("simpson(y, h)           ≈ %.6f\n", simpson(y, h))