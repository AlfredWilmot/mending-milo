def nested_conditionals(conditional_A, conditional_B, conditional_C, conditional_D):
    """
    Verbose, less readable test function
    """
    if (conditional_A):
        if (conditional_B):
            if (conditional_C) and (conditional_D):
                return True
            else:
                return False
        else:
            return False
    else:
        return False


def simple_conditionals(conditional_A, conditional_B, conditional_C, conditional_D):
    """
    Simplified, more readable test function
    """
    return (conditional_A) and (conditional_B) and (conditional_C) and (conditional_D)


def compare(function_1, function_2, bits=4, dbg=False):
    """
    An exhaustive test that determines whether two functions return the same output given all possible combinations of boolean inputs.
    The number of boolean inputs being tested corresponds to the number of bits.
    Indicates the input combination for the first detected failed test then exits, otherwise exits indicating success.
    Generate a bit table, pass each row to both functions, compare their outputs.
    """

    if dbg: print("input combinations:")

    for i in range(2**bits):
        
        list_of_bits = [bool(int(char)) for char in format(i,'0'+str(bits)+'b')]
        if dbg: print([int(i) for i in list_of_bits]) 
        
        if function_1(*list_of_bits) == function_2(*list_of_bits):
            pass
        else:
            print("function outputs are not identical for inputs:")
            print([int(i) for i in list_of_bits]) 
            return -1
        
    print("functions are identical for every set of input combinations.\nHooray!")    
    return 0




if __name__=="__main__":

    compare(nested_conditionals, simple_conditionals, dbg=True)