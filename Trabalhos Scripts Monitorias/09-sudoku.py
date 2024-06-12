#--------------------------------------------------#
#--                                              --#
#--               Anderson Filho                 --#
#--                12011ECP032                   --#
#--                                              --#   
#--------------------------------------------------#
def main ():
    n = int(input())
    all_table = []
    for j in range(n):
        tab_sudoku = []
        for i in range(9):
            tab_sudoku.append([int (i) for i in input().split()])
        all_table.append(tab_sudoku)
    
    for i in range(n):
        print(check(all_table[i]))
    
    for j in range(n):
        if check(all_table[j]) and check_3x3(all_table[j]): #checking if the matrix is approved by the functions
            print(f'Instancia {j+1}')
            print('SIM')
        else:
            print(f'Instancia {j+1}')
            print('NAO')    
        print('')
def check(array,n = 9):#function that goes through the entire matrix 
    for i in range(n): #and checks if there is the same number in the row and column
        for j in range(n):
            num = array[i][j]
            for h in range(n):
                if h == j:
                    continue
                elif array[i][h] == array[i][j]:
                    return False
    for i in range(n):
        for j in range(n):
            num = array[j][i]
            for h in range(n):
                if h == j:
                    continue
                elif array[h][i] == array[j][i]:
                    return False
    return True
def check_3x3(array): #function that split the 9X9 matrix into 3x3 matrices and checks if it has all the numbers from 1 to 9
    one_nine = [1,2,3,4,5,6,7,8,9]
    new_array = []
    indx_row = 0
    for a in range(3):
        indx_colum = 0
        for arr in range(3):
            new_row = []
            for row  in range(3):
                new_colum = []
                for colum in range(3):
                    new_colum.append(array[row+indx_row][colum+indx_colum])
                new_row.append(new_colum)
            new_array.append(new_row)
            indx_colum+=3
        indx_row += 3
    for i in range(9):
        checked_numbers = []
        for j in range(3):
            for h in range(3):
                if new_array[i][j][h] in one_nine and new_array[i][j][h] not in checked_numbers:
                    checked_numbers.append(new_array[i][j][h])
                    continue
                else: return False
    return True
main()
