#--------------------------------------------------#
#--                                              --#
#--               Anderson Filho                 --#
#--                12011ECP032                   --#
#--                                              --#   
#--------------------------------------------------#

hp_ryu = int(input()) # hp inicial de ryu
hp_key = int(input()) #hp inicial de key

qnt_ryu = 0
qnt_key = 0

#laço para a sequência de golpes
while True:
    golpe = int(input())
#verificando qual lutador vai dar o golpe
    if golpe > 0:
        hp_key -= golpe
        qnt_ryu += 1
        if hp_key < 0:
            hp_key = 0
        print('RYU APLICOU UM GOLPE:', golpe)
        print("HP RYU =", hp_ryu)
        print("HP KEN =", hp_key)
    else:
        hp_ryu -= (golpe*(-1))
        qnt_key += 1
        if hp_ryu < 0:
            hp_ryu = 0
        print('KEN APLICOU UM GOLPE:', golpe*(-1))
        print("HP RYU =", hp_ryu)
        print("HP KEN =", hp_key)
#condição de saída do laço
    if hp_ryu == 0 or hp_key == 0:
        break
    
        
    
#imprimindo o resultado da luta
if hp_key == 0:
    
    print('LUTADOR VENCEDOR: RYU')
    print('GOLPES RYU =', qnt_ryu)
    print('GOLPES KEN =', qnt_key)
else:
    print('LUTADOR VENCEDOR: KEN')
    print('GOLPES RYU =', qnt_ryu)
    print('GOLPES KEN =', qnt_key)
    
    
    



    