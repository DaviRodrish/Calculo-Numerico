# ==========================================
# BUSCA DE INTERVALOS (TEOREMA DE BOLZANO)
# ==========================================

function achar_intervalo(f, inicio, passo)
    x = inicio
    tentativas = 0
    max_tentativas = 1000
    
    while f(x) * f(x + passo) > 0
        x += passo
        tentativas += 1
        
        if tentativas > max_tentativas
            error("Não foi possível encontrar uma raiz nessa direção.")
        end
    end
    
    if passo > 0
        return x, x + passo
    else
        return x + passo, x 
    end
end