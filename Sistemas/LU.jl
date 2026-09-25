# ==========================================
# MÉTODO DA FATORAÇÃO LU
# ==========================================

function fatoracao_lu(A, b, pivoteamento)

    n = length(b)

    # Faz cópias para não alterar as matrizes originais
    A = copy(A)
    b = copy(b)

    L = zeros(Float64, n, n)
    U = copy(A)

    # Diagonal de L
    for i in 1:n
        L[i, i] = 1.0
    end

    # ==========================================
    # FATORAÇÃO LU
    # ==========================================

    for k in 1:n-1

        # PIVOTEAMENTO PARCIAL
        if pivoteamento

            linha = k

            for i in k+1:n
                if abs(U[i, k]) > abs(U[linha, k])
                    linha = i
                end
            end

            if linha != k

                # Troca as linhas de U
                U[[k, linha], :] = U[[linha, k], :]

                # Troca as linhas de b
                b[[k, linha]] = b[[linha, k]]

                # Troca as partes já calculadas de L
                if k > 1
                    L[[k, linha], 1:k-1] =
                        L[[linha, k], 1:k-1]
                end
            end
        end

        # Verifica se o pivô é zero
        if abs(U[k, k]) < 1e-12
            println("Erro: pivô nulo.")
            return
        end

        # Eliminação
        for i in k+1:n

            L[i, k] = U[i, k] / U[k, k]

            for j in k:n
                U[i, j] = U[i, j] - L[i, k] * U[k, j]
            end

        end
    end

    # ==========================================
    # RESOLVE L*y = b
    # ==========================================

    y = zeros(Float64, n)

    for i in 1:n

        soma = 0.0

        for j in 1:i-1
            soma += L[i, j] * y[j]
        end

        y[i] = (b[i] - soma) / L[i, i]

    end

    # ==========================================
    # RESOLVE U*x = y
    # ==========================================

    x = zeros(Float64, n)

    for i in n:-1:1

        soma = 0.0

        for j in i+1:n
            soma += U[i, j] * x[j]
        end

        x[i] = (y[i] - soma) / U[i, i]

    end

    # ==========================================
    # RESULTADOS
    # ==========================================

    println("\nMatriz L:")
    println(L)

    println("\nMatriz U:")
    println(U)

    println("\nVetor y:")
    println(y)

    println("\nSolução do sistema:")
    println(x)

    return x
end


# ==========================================
# SISTEMA
# ==========================================

A = [
    2.0  1.0  1.0
    4.0  3.0  3.0
    8.0  7.0  9.0
]

b = [
    4.0
    10.0
    28.0
]

# ==========================================
# MENU
# ==========================================

println("==========================================")
println("       MÉTODO DA FATORAÇÃO LU")
println("==========================================")
println("1 - Sem pivoteamento")
println("2 - Com pivoteamento")
println("==========================================")

print("Escolha uma opção: ")
opcao = parse(Int, readline())

if opcao == 1

    println("\nFatoração LU sem pivoteamento:\n")
    fatoracao_lu(A, b, false)

elseif opcao == 2

    println("\nFatoração LU com pivoteamento:\n")
    fatoracao_lu(A, b, true)

else

    println("Opção inválida.")

end