# MÉTODO DE NEWTON

function newton(f, df, x0, tol, max_iter)

    for i in 1:max_iter

        # Calcula o próximo ponto
        x = x0 - f(x0) / df(x0)

        # Calcula o erro
        erro = abs(x - x0)

        println(
            "Iteração ", i,
            " | x = ", x,
            " | f(x) = ", f(x),
            " | erro = ", erro
        )

        # Critério de parada
        if erro < tol
            println("\nRaiz aproximada: ", x)
            println("Número de iterações: ", i)
            return x
        end

        # Atualiza x
        x0 = x
    end

    println("\nMétodo não convergiu dentro do número máximo de iterações.")

end

# DADOS DO PROBLEMA ----------------------

# Função
f(x) = x^2 + x - 6

# Derivada
df(x) = 2x + 1

# Chute inicial
x0 = 1.0

# Tolerância
tol = 0.0001

# Número máximo de iterações
max_iter = 100


# EXECUÇÃO
newton(f, df, x0, tol, max_iter)