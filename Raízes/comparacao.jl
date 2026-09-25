# ==========================================
# INCLUSÃO DOS ARQUIVOS
# ==========================================
include("Bissecção.jl")
include("MPF.jl")
include("Newton.jl")
include("falsa_posicao.jl")
include("secante.jl")
include("intervalo.jl") 

# ==========================================
# DADOS DA QUESTÃO
# ==========================================
f(x) = exp(0.1*x) + x^2 - 10
df(x) = 0.1*exp(0.1*x) + 2*x 

g_pos(x) = sqrt(10 - exp(0.1*x))
g_neg(x) = -sqrt(10 - exp(0.1*x))

tol = 1e-5
max_iter = 100

# ==========================================
# DESCOBRINDO OS INTERVALOS [a, b]
# ==========================================

# --- RAIZ NEGATIVA ---
# Começa do 0 e anda para trás (-1.0) para achar a raiz negativa
a_neg, b_neg = achar_intervalo(f, 0.0, -1.0)
chute_neg = (a_neg + b_neg) / 2.0

# --- RAIZ POSITIVA ---
# Valores fixos dados:
a_pos, b_pos = 2.5, 3.5
chute_pos = 3.0

# Se quiser que o programa calcule sozinho, tire os '#' das linhas abaixo:
# a_pos, b_pos = achar_intervalo(f, 0.0, 1.0)
# chute_pos = (a_pos + b_pos) / 2.0


# ==========================================
# EXECUÇÃO: RAIZ POSITIVA
# ==========================================
println("\n\n>>> RAIZ POSITIVA (Intervalo: [$a_pos, $b_pos] | Chute: $chute_pos) <<<\n")

println("--- Bissecção ---")
bisseccao(f, a_pos, b_pos, tol, max_iter)

println("\n--- Falsa Posição ---")
falsa_posicao(f, a_pos, b_pos, tol, max_iter)

println("\n--- Ponto Fixo ---")
ponto_fixo(g_pos, chute_pos, tol, max_iter)

println("\n--- Newton ---")
newton(f, df, chute_pos, tol, max_iter)

println("\n--- Secante ---")
raiz_sec_pos = secante(f, a_pos, b_pos, tol, max_iter)
println("Raiz aproximada: ", raiz_sec_pos) 


# ==========================================
# EXECUÇÃO: RAIZ NEGATIVA
# ==========================================
println("\n\n>>> RAIZ NEGATIVA (Intervalo calculado: [$a_neg, $b_neg] | Chute: $chute_neg) <<<\n")

println("--- Bissecção ---")
bisseccao(f, a_neg, b_neg, tol, max_iter)

println("\n--- Falsa Posição ---")
falsa_posicao(f, a_neg, b_neg, tol, max_iter)

println("\n--- Ponto Fixo ---")
ponto_fixo(g_neg, chute_neg, tol, max_iter)

println("\n--- Newton ---")
newton(f, df, chute_neg, tol, max_iter)

println("\n--- Secante ---")
raiz_sec_neg = secante(f, a_neg, b_neg, tol, max_iter)
println("Raiz aproximada: ", raiz_sec_neg)