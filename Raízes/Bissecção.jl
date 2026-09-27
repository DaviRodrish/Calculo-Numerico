# Dupla 16: Davi Rodrigues e Paulo Fernando P. Junior
# MÉTODO DA BISSECÇÃO

function bissecao(f, a, b, tol, maxiter)
    if f(a) * f(b) > 0
        println("Não há garantia de raiz no intervalo.")
        return nothing, 0
    end

    for i in 1:maxiter
        x = (a + b) / 2

        println("iteração ", i, " |a: ", a, " |b: ", b, " |x: ", x, " |f(x): ", f(x))

        if (b - a) / 2 < tol
            println("\nRaiz aproximada: ", x)
            println("Número de iterações: ", i)
            return x, i
        end

        if f(a) * f(x) < 0
            b = x
        else
            a = x
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
raiz, iter = bissecao(f, a, b, tol, maxiter)