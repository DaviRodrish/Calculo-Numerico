# ==========================================
# MÉTODO DO PONTO FIXO
# ==========================================

function ponto_fixo(g, x0, tol, max_iter)

    for i in 1:max_iter

        # Calcula o próximo ponto
        x = g(x0)

        # Calcula o erro
        erro = abs(x - x0)

        println(
            "Iteração ", i,
            " | x = ", x,
            " | erro = ", erro
        )

        # Critério de parada
        if erro < tol
            println("\nRaiz aproximada: ", x)
            println("Iterações: ", i)
            return x
        end

        # Atualiza x
        x0 = x
    end

    println("\nMétodo não convergiu.")

end


# ==========================================
# DADOS DO PROBLEMA
# ==========================================

# Coloque aqui a sua função g(x)
g(x) = sqrt(6 - x)

# Chute inicial
x0 = 1.0

# Tolerância
tol = 0.0001

# Número máximo de iterações
max_iter = 100


# ==========================================
# EXECUÇÃO
# ==========================================

ponto_fixo(g, x0, tol, max_iter)