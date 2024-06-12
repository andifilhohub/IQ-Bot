#--------------------------------------------------#
#--                                              --#
#--               Anderson Filho                 --#
#--                12011ECP032                   --#
#--                                              --#   
#--------------------------------------------------#
def nodot(word): #function to remove punctuation from the word
    word = list(word)
    dot = [".", ",", ":", ";", "!", "?"]
    for i in range(len(word)):
        if word[i] in dot:
            (word).remove(word[i])
    return(''.join(str(i) for i in word)).lower()
def same(x8,y): #function to evaluate word equality
    if len(x8) > len(nodot(y)):
        return False
    for i in range(len(x8)):
        if x8[i] == nodot(y)[i] or x8[i] == '*':
            continue
        else: return False
    return True
def same_words(words,list_word): #function to go through the entire text and find the values
    sim, occ = 0,0
    for i in range(len(list_word)):
        for j in range(len(list_word[i])):
            word = list_word[i][j:].lower()
            if same(words,word) and len(words) == len(nodot(list_word[i])):
                occ+=1
            elif same(words,word) and len(words) < len(nodot(list_word[i])): 
                sim +=1
            else: continue
    return occ,sim
def main():
    text = []
    number_row = int(input())
    for i in range(number_row):
        text.append([str (i) for i in input().split()])
    number_words = int(input())
    words = []
    for i in range(number_words):
        words.append(input())
    for i in range(number_words):
        occ, sim = 0,0
        for j in range(number_row):
            occ += same_words(words[i].lower(),text[j])[0]
            sim += same_words(words[i].lower(),text[j])[1]
        print('Palavra buscada:', words[i])
        print('Ocorrencia:',occ)
        print('Palavras similares:',sim)
main()