# Dupla 16: Davi Rodrigues e Paulo Fernando P. Junior
# MÉTODO DA FALSA POSIÇÃO

function falsa_posicao(f, a, b, tol, maxiter)
    fa, fb = f(a), f(b)

    if fa == 0
        return a, 0
    elseif fb == 0
        return b, 0
    elseif fa * fb > 0
        error("Não há raiz nesse intervalo. f(a) e f(b) devem ter sinais opostos.")
    end

    for i in 1:maxiter
        x = a - fa * (b - a) / (fb - fa)
        fx = f(x)

        println("Iteração ", i, " | a: ", a, " | b: ", b, " | x: ", x, " | f(x): ", fx)

        if abs(fx) < tol
            println("\nRaiz aproximada: ", x)
            println("Número de iterações: ", i)
            return x, i
        elseif fa * fx < 0
            b, fb = x, fx
        else
            a, fa = x, fx
        end
    end

    println("\nMétodo não convergiu dentro do número máximo de iterações.")
    return nothing, maxiter
end

# DADOS
f(x) = x^3 - x - 2

a = 1.0
b = 2.0

tol = 0.0001
maxiter = 100

# EXECUÇÃO
raiz, iter = falsa_posicao(f, a, b, tol, maxiter)