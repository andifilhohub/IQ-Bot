#--------------------------------------------------#
#--                                              --#
#--               Anderson Filho                 --#
#--                12011ECP032                   --#
#--                                              --#   
#--------------------------------------------------#
def some(lista): #add up the list items
    some = 0 
    for i in range(len(lista)):
        some+=lista[i]
    return some
def main():
    mes = int(input())
    if mes<3:
        return True
    vacinas = []
    d2_x = []
    devolvidas = []
    for i in range(mes):
        d2_x.append(0)
        devolvidas.append(0)
    for i in range(mes):
        x = int(input())
        vacinas.append(x)
    y = mes - 3
    d1 = 0
    d2 = vacinas[3:]
    for i in range(len(vacinas)):
        print(f'Mes {i+1}:')
        if i < (len(vacinas)-3): #situation before 3 months
            if vacinas[i]>vacinas[i+3]: #whether there will be a refund
                d1+=(vacinas[i+3])
                print('Vacinados com a primeira dose:',vacinas[i+3])
                d2_x[i+3] = vacinas[i+3]
                print('Vacinados com a segunda dose:', d2_x[i])
                devolvidas[i] = vacinas[i]-vacinas[i+3]
                print('Vacinas devolvidas:', devolvidas[i]) 
                vacinas[i+3] = 0
            else:#when there is no refund
                d1+=(vacinas[i])
                print('Vacinados com a primeira dose:',vacinas[i])
                vacinas[i+3] = vacinas[i+3]-vacinas[i]
                d2_x[i+3] = vacinas[i]
                print('Vacinados com a segunda dose:', d2_x[i])
                print('Vacinas devolvidas:', devolvidas[i])
        else: #last 3 months
            d1+=vacinas[i]
            print('Vacinados com a primeira dose:',vacinas[i])
            print('Vacinados com a segunda dose:', d2_x[i])
            print('Vacinas devolvidas:', devolvidas[i])
    print('Total:')
    print('Vacinados apenas com a primeira dose:',d1-some(d2_x))
    print('Vacinados com as duas doses:', some(d2_x))
    print('Vacinas devolvidas:',some(devolvidas))          
main()