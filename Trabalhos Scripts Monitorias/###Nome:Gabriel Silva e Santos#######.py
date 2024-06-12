###Nome:Gabriel Silva e Santos#######

                ###Matrícula:12321EEL006############

                ###Trabalho 8:Vacinação astrazeneca#

n = int(input())

dose_1 = []

dose_2 = []

devolvidos =[]

vacinas = []

 

for i in range(n):

    valor = int(input())

    vacinas.append(valor)

dose_2 = vacinas[3:]



i = 0
while i < n:
    dose_2.append(0) 
    i+=1
 

for i in range(len(vacinas) - 1):

    if i >= 3:

        if i < len(vacinas) - 3:

 

            if vacinas[i] < dose_2[i]:

                dose_1.append(vacinas[i])

                devolvidos.append(0)

                vacinas[i+3] = vacinas[i+3] - vacinas[i]

                dose_2[i] = vacinas[i]
                

           

                print(f'Mes {i + 1}:')

                print(f'Vacinados com a primeira dose: {vacinas[i]}')

                print(f'Vacinados com a segunda dose: {dose_2[i]}')

                print(f'Vacinas devolvidas: {devolvidos[i]}')

       

            else:

                dose_1.append(vacinas[i+3])

                devolvidos.append(vacinas[i] - vacinas[i+3])
                dose_2[i] = vacinas[i+3]
                vacinas[i+3] = 0

               

               

                print(f'Mes {i + 1}:')

                print(f'Vacinados com a primeira dose: {vacinas[i+3]}')

                print(f'Vacinados com a segunda dose: {dose_2[i]}')

                print(f'Vacinas devolvidas: {vacinas[i] - vacinas[i+3]}')

        else:

            dose_1.append(vacinas[i])

            devolvidos.insert(0,0)
            
            

 

            print(f'Mes {i + 1}:')

            print(f'Vacinados com a primeira dose: {vacinas[i]}')
            
            print(f'Vacinados com a segunda dose: {dose_2[i]}')
            
            print(f'Vacinados com a segunda dose: {0}')

            print(f'Vacinas devolvidas: {0}')

    else:

         

            

        if  vacinas[i] > dose_2[i]:

            devolvidos.append(vacinas[i] - vacinas[i + 3])

            dose_1.append[vacinas[i+3]]

            dose_2[i] = vacinas[i]

            vacinas[i+3] = 0

            
            print(f'Mes {i + 1}:')

            print('Vacinados com a primeira dose: ',dose_1[i])

            print(f'Vacinados com a segunda dose: {0}')

            print(f'Vacinas devolvidas: {devolvidos[i]}')

 

        else:

            devolvidos.append(0)

            dose_1.append(vacinas[i])

            vacinas[i+3] = vacinas[i+3] - vacinas[i]

            #dose_2.insert(0,0)

            dose_2[i] = vacinas[i]
            

            devolvidos.insert(0,0)

            print(f'Mes {i + 1}:')

            print('Vacinados com a primeira dose: ',vacinas[i])

            print(f'Vacinados com a segunda dose: {0}')

            print(f'Vacinas devolvidas: {0}')

 

   

def soma1():

    dose_1total = 0

    for i in dose_1[-3:]:

        dose_1total = dose_1total + i

    return dose_1total

 

def soma2():

    dose_2total = 0

    for i in dose_2:

        dose_2total = dose_2total + i

    return dose_2total

 

def soma3():

    devolvidostotal = 0

    for i in devolvidos:

        devolvidostotal = devolvidostotal + i

    return devolvidostotal

 



print('Total: ')

print(f'Vacinados apenas com a primeira dose: {soma1()}')

print(f'Vacinados com as duas dose: {soma2()}')

print(f'Vacinas devolvidas: {soma3()}')