# ==========================================
# MÉTODO DE GAUSS-SEIDEL
# ==========================================

function gauss_seidel(A, b, x0, tol, max_iter, pivoteamento)

    n = length(b)

    # ------------------------------------------
    # PIVOTEAMENTO
    # ------------------------------------------

    if pivoteamento

        for i in 1:n

            # Encontra a maior magnitude na coluna
            linha = i

            for j in i+1:n
                if abs(A[j, i]) > abs(A[linha, i])
                    linha = j
                end
            end

            # Troca as linhas
            if linha != i
                A[[i, linha], :] = A[[linha, i], :]
                b[[i, linha]] = b[[linha, i]]
            end
        end

    end


    # ------------------------------------------
    # VERIFICAÇÃO DA DIAGONAL
    # ------------------------------------------

    for i in 1:n

        if A[i, i] == 0
            println("Erro: elemento da diagonal é zero.")
            return
        end

    end


    # ------------------------------------------
    # GAUSS-SEIDEL
    # ------------------------------------------

    x = copy(x0)

    for k in 1:max_iter

        x_antigo = copy(x)

        for i in 1:n

            soma = 0.0

            for j in 1:n

                if j != i
                    soma += A[i, j] * x[j]
                end

            end

            x[i] = (b[i] - soma) / A[i, i]

        end


        # --------------------------------------
        # CALCULA O ERRO
        # --------------------------------------

        erro = maximum(abs.(x - x_antigo))

        println(
            "Iteração ", k,
            " | x = ", x,
            " | erro = ", erro
        )


        # --------------------------------------
        # CRITÉRIO DE PARADA
        # --------------------------------------

        if erro < tol

            println("\nSolução aproximada:")
            println(x)

            println("Número de iterações: ", k)

            return x

        end

    end

    println("\nMétodo não convergiu dentro do número máximo de iterações.")

end


# ==========================================
# SISTEMA
# ==========================================

A = [
    10.0  2.0  1.0
     1.0  5.0  1.0
     2.0  3.0  10.0
]

b = [
    7.0
    -8.0
    6.0
]


# ==========================================
# CONFIGURAÇÕES
# ==========================================

# Chute inicial
x0 = [0.0, 0.0, 0.0]

# Tolerância
tol = 0.0001

# Número máximo de iterações
max_iter = 100


# ==========================================
# MENU
# ==========================================

println("==========================================")
println("       MÉTODO DE GAUSS-SEIDEL")
println("==========================================")
println("1 - Sem pivoteamento")
println("2 - Com pivoteamento")
println("==========================================")

print("Escolha uma opção: ")
opcao = parse(Int, readline())


if opcao == 1

    println("\nGauss-Seidel sem pivoteamento:\n")

    gauss_seidel(A, b, x0, tol, max_iter, false)

elseif opcao == 2

    println("\nGauss-Seidel com pivoteamento:\n")

    gauss_seidel(A, b, x0, tol, max_iter, true)

else

    println("Opção inválida.")

end