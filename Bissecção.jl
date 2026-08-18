# ==========================================
# MÉTODO DA BISSECÇÃO
# ==========================================

function bisseccao(f, a, b, tol, max_iter)

    # Verifica se existe mudança de sinal
    if f(a) * f(b) > 0
        println("Não há garantia de raiz no intervalo.")
        return
    end

    println("Iteração   |   a   |   b   |   x   |    f(x)")

    for i in 1:max_iter

        # Ponto médio
        x = (a + b) / 2

        println("iteração ", i, " | ", a, " | ", b, " | ", x, " | ", f(x))

        # Critério de parada
        if abs(f(x)) < tol || abs(b - a) < tol
            println("\nRaiz aproximada: ", x)
            println("Número de iterações: ", i)
            return x
        end

        # Escolhe o novo intervalo
        if f(a) * f(x) < 0
            b = x
        else
            a = x
        end
    end

    println("\nMétodo não convergiu dentro do número máximo de iterações.")

end


# ==========================================
# EXEMPLO
# ==========================================

f(x) = x*log10(x) -1

a = 1.0
b = 3.0

tol = 0.0001

max_iter = 100

bisseccao(f, a, b, tol, max_iter)