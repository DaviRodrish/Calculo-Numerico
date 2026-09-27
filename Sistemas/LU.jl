# Dupla 16: Davi Rodrigues e Paulo Fernando P. Junior
# Método: Fatoração LU


function lu_resolve(A, b)

    n = length(b)

    # Verifica se A é quadrada
    if size(A) != (n, n)
        error("A matriz deve ser quadrada e compatível com b.")
    end

    # Matriz U começa sendo uma cópia de A
    U = float(copy(A))

    # Matriz L começa com zeros
    L = zeros(Float64, n, n)

    # 1 na diagonal de L
    for i in 1:n
        L[i, i] = 1.0
    end

    # FATORAÇÃO LU
   
    for k in 1:n-1

        # Verifica se o pivô é zero
        if abs(U[k, k]) < 1e-12
            error("Pivô nulo. Não é possível realizar a fatoração LU.")
        end

        # Eliminação
        for i in k+1:n

            # Calcula o multiplicador
            L[i, k] = U[i, k] / U[k, k]

            # Atualiza U
            for j in k:n
                U[i, j] = U[i, j] - L[i, k] * U[k, j]
            end

        end
    end

    
    # RESOLVE L*y = b
    

    y = zeros(Float64, n)

    for i in 1:n

        soma = 0.0

        for j in 1:i-1
            soma += L[i, j] * y[j]
        end

        y[i] = (b[i] - soma) / L[i, i]

    end

   
    # RESOLVE U*x = y
    

    x = zeros(Float64, n)

    for i in n:-1:1

        soma = 0.0

        for j in i+1:n
            soma += U[i, j] * x[j]
        end

        x[i] = (y[i] - soma) / U[i, i]

    end

    # Retorna x, L e U
    return x, L, U
end



# Teste


A = [
    2  1  1
    4  3  3
    8  7  9
]

b = [4, 10, 24]

x, L, U = lu_resolve(A, b)

println("Matriz L:")
println(L)

println("\nMatriz U:")
println(U)

println("\nSolução x:")
println(x)