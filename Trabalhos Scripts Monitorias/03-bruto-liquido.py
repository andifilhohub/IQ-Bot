#--------------------------------------------------#
#--                                              --#
#--               Anderson Filho                 --#
#--                12011ECP032                   --#
#--                                              --#   
#--------------------------------------------------#


bruto = float(input())
inss = 0 
if bruto <= 1045.00:
    inss = bruto*(7.5/100)
elif bruto >= 1045.01 and bruto <= 2089.60:
    inss = bruto*(9.0/100)
elif bruto >=2089.61 and bruto <= 3134.40:
    inss = bruto*(12.0/100)
elif bruto >= 3134.41 and bruto <= 6101.06:
    inss = bruto*(14.0/100)
else:
    inss = 6101.06*(14.0/100)

liquido = bruto - inss

if liquido <= 1903.98:
    ir = 0.00
elif liquido >= 1903.99 and liquido <= 2826.65:
    ir = (liquido*(7.5/100)) - 142.80
elif liquido >= 2826.66 and liquido <= 3751.05:
    ir = (liquido*(15.0/100)) - 354.80
elif liquido >= 3751.06 and liquido <= 4664.68:
    ir = (liquido*(22.5/100)) - 636.13
else: 
    ir = (liquido*(27.5/100)) - 869.36

liquido = liquido - ir


print("Bruto: R$", format(bruto, ".2f").replace(".", ","))
print("INSS: R$", format(inss, ".2f").replace(".", ","))
print("IR: R$", format(ir, ".2f").replace(".", ","))
print("Liquido: R$", format(liquido, ".2f").replace(".", ","))