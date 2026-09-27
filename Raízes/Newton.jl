# Dupla 16: Davi Rodrigues e Paulo Fernando P. Junior
# MÉTODO DE NEWTON-RAPHSON

function newton(f, df, x0, tol, maxiter)
    for i in 1:maxiter
        x = x0 - f(x0) / df(x0)

        erro = abs(x - x0)

        println(
            "Iteração ", i,
            " | x = ", x,
            " | f(x) = ", f(x),
            " | erro = ", erro
        )

        if erro < tol
            println("\nRaiz aproximada: ", x)
            println("Número de iterações: ", i)
            return x, i
        end

        x0 = x
    end

    println("\nMétodo não convergiu dentro do número máximo de iterações.")
    return nothing, maxiter
end

# DADOS
f(x) = x^3 - x - 2
df(x) = 3x^2 - 1

x0 = 1.5

tol = 0.0001
maxiter = 100

# EXECUÇÃO
raiz, iter = newton(f, df, x0, tol, maxiter)