#--------------------------------------------------#
#--                                              --#
#--               Anderson Filho                 --#
#--                12011ECP032                   --#
#--                                              --#   
#--------------------------------------------------#
valor_hora = int(input())
dias_semana = int(input())
i = 0
horas_trabalhadas = 0
horas_extra = 0
horas_extra_dia = 0
while i < dias_semana: #dias da semana
  num_period = int(input())
  j = 0
  horas_nodia = 0
  while j < num_period: #periodos por dia
    hora_inicio = int(input())
    hora_final = int(input())
    horas_nodia = horas_nodia + (hora_final - hora_inicio) #quantas horas foram trabalhadas
    j += 1
  if horas_nodia > 8:
    horas_extra_dia += (horas_nodia - 8) #quantas horas extra tiveram no dia
  horas_trabalhadas = horas_trabalhadas + horas_nodia
  i += 1
horas_trabalhadas -= horas_extra_dia
if horas_trabalhadas > 44: #avaliando se teve uma carga horaria maior que 44 alem das horas extras
    horas_extra = horas_trabalhadas-44+horas_extra_dia
else:
    horas_extra = horas_extra_dia
horas_trabalhadas+=horas_extra_dia
valor_devido = (valor_hora * horas_trabalhadas) + ((valor_hora/2) * horas_extra) #valor do salario
print('Horas trabalhadas:', horas_trabalhadas)
print('Horas extras:', horas_extra)
print("Valor devido: R$ {:.2f}".format(valor_devido))