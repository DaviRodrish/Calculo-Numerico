# Dupla 16: Davi Rodrigues e Paulo Fernando P. Junior
# Método: Gauss-Jacobi


function jacobi(A, b, x0, tol, maxiter)

    n = length(b)

    # Verifica se A é quadrada
    if size(A) != (n, n)
        error("A matriz deve ser quadrada e compatível com b.")
    end

    # Verifica se a diagonal possui zeros
    for i in 1:n
        if A[i, i] == 0
            error("Elemento da diagonal não pode ser zero.")
        end
    end

    # Converte para Float64
    A = float(A)
    b = float(b)
    x = float(copy(x0))

    # ======================================================
    # MÉTODO DE JACOBI
    # ======================================================

    for k in 1:maxiter

        x_novo = zeros(Float64, n)

        # Calcula cada componente usando SOMENTE os
        # valores da iteração anterior
        for i in 1:n

            soma = 0.0

            for j in 1:n
                if j != i
                    soma += A[i, j] * x[j]
                end
            end

            x_novo[i] = (b[i] - soma) / A[i, i]

        end

        # Maior diferença entre duas iterações
        erro = maximum(abs.(x_novo - x))

        # Atualiza a solução
        x = x_novo

        # Critério de parada
        if erro < tol
            return x, k
        end
    end

    # Caso atinja o número máximo de iterações
    return x, maxiter
end


# ==========================================================
# TESTE
# ==========================================================

A = [
    10  -1   2
    -1  11  -1
     2  -1  10
]

b = [11, 9, 11]

x0 = [0, 0, 0]

tol = 1e-8

maxiter = 100

x, iteracoes = jacobi(A, b, x0, tol, maxiter)

println("Solução aproximada:")
println(x)

println("\nNúmero de iterações:")
println(iteracoes)