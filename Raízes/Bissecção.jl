# ==========================================
# MÉTODO DA BISSECÇÃO
# ==========================================

function bisseccao(f, a, b, tol, max_iter)

    # Verifica se existe mudança de sinal
    if f(a) * f(b) > 0
        println("Não há garantia de raiz no intervalo.")
        return
    end


    for i in 1:max_iter

        # Ponto médio
        x = (a + b) / 2

        println("iteração", i, " |a: ", a, " |b: ", b, " |x: ", x, " |f(x): ", f(x))

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
# Esse método acha somente uma raiz por vez. 
# ==========================================

#Função
f(x) = x^2 + x - 6                 

#Ranges
a = -5
b = 0

#tolerancia
tol = 0.0001

#iterações maximas
max_iter = 100


bisseccao(f, a, b, tol, max_iter)