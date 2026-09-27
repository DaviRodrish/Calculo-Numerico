# Dupla 16: Davi Rodrigues e Paulo Fernando P. Junior
# Método: Eliminação Gaussiana com Pivoteamento Parcial

using LinearAlgebra

function gauss_pivot(A, b)

    n = length(b)

    # Verifica se A é quadrada
    if size(A) != (n, n)
        error("A matriz deve ser quadrada e compatível com b.")
    end

    #Matriz aumentada [A | b]
    M = float([A b])

    # Eliminação Gaussiana
    for k in 1:n-1

        # Procura o maior pivô em módulo
        p = argmax(abs.(M[k:n, k])) + k - 1

        # Verifica se o pivô é zero
        if abs(M[p, k]) < 1e-12
            error("Sistema sem solução única.")
        end

        # Troca as linhas
        if p != k
            M[[k, p], :] = M[[p, k], :]
        end

        # Zera os elementos abaixo do pivô
        for i in k+1:n

            fator = M[i, k] / M[k, k]

            for j in k:n+1
                M[i, j] = M[i, j] - fator * M[k, j]
            end

        end
    end

    # Verifica o último pivô
    if abs(M[n, n]) < 1e-12
        error("Sistema sem solução única.")
    end

    # SUBSTITUIÇÃO REGRESSIVA

    x = zeros(Float64, n)

    for i in n:-1:1

        soma = 0.0

        for j in i+1:n
            soma += M[i, j] * x[j]
        end

        x[i] = (M[i, n+1] - soma) / M[i, i]

    end

    return x
end



# Teste
A = [
     2   1  -1
    -3  -1   2
    -2   1   2
]

b = [8, -11, -3]

x = gauss_pivot(A, b)

println("Solução:")
println(x)