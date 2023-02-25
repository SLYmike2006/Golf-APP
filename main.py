



# first it checks if the person older than 18
# if they are, it checks if they're younger than 65

# if both are satisfied, then it prints("You can drive")

# if they're older than 65, print out (you're too old)

# younger than 18 too young
    #   0  1  2             6


# Function   input ---> FUNCTION (does something) ---> output 

def getMaxValue(list):
    max = 0
    for i in range(len(list)):
        for j in range(len(list[i])):
            if list[i][j] > max:
                max = list[i][j]
    
    return max



angles = [
    [3,1,4,5,6],
    [6,2,1,6,1,70],
    [9,7,4,21,7],
]

result = getMaxValue(angles)

print(result)