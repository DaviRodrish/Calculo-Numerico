# Dupla 16: Davi Rodrigues e Paulo Fernando P. Junior
# MÉTODO DA SECANTE

function secante(f, x0, x1, tol, maxiter)
    for i in 1:maxiter
        fx0 = f(x0)
        fx1 = f(x1)

        println("Iteração ", i, " | x0: ", x0, " | f(x0): ", fx0, " | x1: ", x1, " | f(x1): ", fx1)

        if fx1 == fx0
            println("Divisão por zero detectada.")
            return x1, i
        end

        x_novo = x1 - fx1 * (x1 - x0) / (fx1 - fx0)

        if abs(x_novo - x1) < tol
            println("\nRaiz aproximada: ", x_novo)
            println("Número de iterações: ", i)
            return x_novo, i
        end

        x0, x1 = x1, x_novo
    end

    println("\nMétodo não convergiu dentro do número máximo de iterações.")
    return x1, maxiter
end

# DADOS
f(x) = x^3 - x - 2

x0 = 1.0
x1 = 2.0

tol = 0.0001
maxiter = 100

# EXECUÇÃO
raiz, iter = secante(f, x0, x1, tol, maxiter)