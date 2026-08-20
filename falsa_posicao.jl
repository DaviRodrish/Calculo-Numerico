# === INSIRA AQUI ===
f(x) = x^5 - 5*x + 1
a = 0.0
b = 0.5
tolerancia = 1e-14
maximo_iteracoes = 50000000
# ===================

# --- Lógica do Método (Não alterar) ---
function falsa_posicao(f, a, b, tol, max_iter)
    fa, fb = f(a), f(b)

    if fa == 0
        return a
    elseif fb == 0
        return b
    elseif fa * fb > 0
        error("f(a) e f(b) devem ter sinais opostos.")
    end

    for _ in 1:max_iter
        x = a - fa * (b - a) / (fb - fa)
        fx = f(x)

        if abs(fx) <= tol
            return x
        elseif fa * fx < 0
            b, fb = x, fx
        else
            a, fa = x, fx
        end
    end

    return nothing 
end

# Aqui as suas variáveis entram direto na função
raiz = falsa_posicao(f, a, b, tolerancia, maximo_iteracoes)
println("Raiz aproximada: ", raiz)