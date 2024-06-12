#--------------------------------------------------#
#--                                              --#
#--               Anderson Filho                 --#
#--                12011ECP032                   --#
#--                                              --#   
#--------------------------------------------------#
def main():
  def showlist(x1,x2,x3,x4,x5,x6): # function to print the list equal to the sqtpm output examples
    return ("{:02} - {:02} - {:02} - {:02} - {:02} - {:02}".format(x1, x2, x3, x4, x5, x6))
# The following are the variables for the input of the user
  n1 = int(input())
  n3 = int(input())
  n4 = int(input())
  n6 = int(input())
  print("Primeiro:", "{:02}".format(n1))
  print("Terceiro:", "{:02}".format(n3))
  print("Quarto:", "{:02}".format(n4))
  print("Sexto:", "{:02}".format(n6))
#then the function that finds the numbers that comply with the rules of the problem
  def sortition(n1,n3,n4,n6):
    n2 = n1 + 1
    while n2 < n3:
      n5 = n4 + 1 
      while n5 < n6:
        soma = n1+n3+n4+n6+n2+n5
        if soma % 7 != 0 and soma % 13 != 0:
          print(showlist(n1,n2,n3,n4,n5,n6))
        n5 += 2
      n2 +=  2
  print("Lista de apostas:")
  sortition(n1,n3,n4,n6) #calling the sortition function
main() #calling the main functiona