def x(x,y):
    h = 0
    for i in range(len(y)):
        if h == len(x):
            if len(x) == len(y):
                return True
            elif len(y) > len(x): return False
        if x[h] == y[i] or x[h] =='*':
            h += 1
        else: h = 0
    if h == len(x):
        if len(x) == len(y):
            return True
        elif len(y)> len(x): return False
    



def GeraPal(palavra):
    # Função para gerar palavras substituindo cada letra por um "*"
    palavras = []
    for i in range(len(palavra)):
        novapalavra = list(palavra)
        novapalavra[i] = '*'
        palavras.append(''.join(novapalavra))
    return palavras

def BuscarPalavras(texto, palavras):
    # Função para buscar palavras no texto
    ocorrencias = []
    for palavra in palavras:
        palavras_geradas = GeraPal(palavra)
        
        Ce = OCORRENCIAS(texto, palavra)
        similar = Similares(texto, palavras_geradas)
        
        ocorrencias.append((palavra, Ce, similar))
    return ocorrencias

def OCORRENCIAS(texto, palavra):
    # Conta o número de ocorrências exatas da palavra no texto
    count = 0
    x = 0
    while x < len(texto):
        x = texto.lower().find(palavra.lower(), x)
        if x == -1:
            break
        if x == 0 or not texto[x - 1].isalpha():
            if x + len(palavra) == len(texto) or not texto[x + len(palavra)].isalpha():
                count += 1
        x += 1
    return count

def Similares(texto, palavras_geradas):
    # Conta o número de ocorrências similares da palavra no texto
    count = 0
    for palavra in palavras_geradas:
        count += OCORRENCIAS(texto, palavra)
    return count

# Leitura do texto
L = int(input())
texto = ""
for _ in range(L):
    texto += input().strip() + " "

# Leitura do número de palavras a serem buscadas
N = int(input())

# Leitura das palavras
palavras = []
for _ in range(N):
    palavras.append(input().strip())
# Busca e contagem de ocorrências
ocorrencias = BuscarPalavras(texto, palavras)
lista_texto = []
Palavra = []
for i in range(len(texto)):
    if texto[i] == ' ':
        lista_texto.append(''.join(Palavra))
        Palavra = []
    else:
        Palavra.append(texto[i])

# Saída das ocorrências encontradas
for i in range(N):
    occ = 0
    s = 0
    for j in range(len(lista_texto)):
        if x(palavras[i],lista_texto[j]):
            occ+=1
        elif x(palavras[i],lista_texto[j]) == False: s +=1

    print(f"Palavra buscada: {palavras[i]}")
    print(f"Ocorrencia: {occ}")
    print(f"Palavras similares: {s}")
    
    