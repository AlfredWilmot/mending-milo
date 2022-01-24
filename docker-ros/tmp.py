#!/usr/bin/env python3 

def main():

    raw_txt = \
    ''' 
    S6 4GF (165K) 
    S6 4LS (192K)
    S6 4QE (233K)
    S6 4FP (191K)
    S6 4QP (160K)
    S6 4JB (121K)
    S6 4QE (236K)
    S6 4JL (158K)
    S6 4FS (172K)
    S6 4GL (152K)
    '''

    print(raw_txt)
    postcodes_and_prices = [s.strip() for s in raw_txt.split("\n")][1:-1]
    print("\n".join(sorted(postcodes_and_prices)))
    
if __name__ == "__main__":
    main()