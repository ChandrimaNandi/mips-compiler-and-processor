#assembler
import re 
#using dictionary to map the registers and their assigned numberss
registers={"$t0":"01000","$t1":"01001","$t2":"01010","$t3":"01011","$t4":"01100","$t5":"01101","$t6":"01110","$t7":"01111","$t8":"11000","$t9":"11001",
           "$s0":"10000","$s1":"10001","$s2":"10010","$s3":"10011","$s4":"10100","$s5":"10101","$s6":"10110","$s7":"10111",
           "$zero":"00000"}
#using dictionary to map the labels and their address/number of words to jump
labels={"sorting":"6","copy":"4194400","outer_loop":"-9","inner_loop":"4194464","return_here":"4194492","swap":"3","print":"17"}

#this is the assembly code we need to convert
code=["addi $t6,$t6,1",
      "addi $s6,$zero,0",
      "addi $s0,$t1,-1",
      "addu $s2,$zero,$t2",
      "addu $s3,$zero,$t3",
      "copy:",
      "slt $t0,$s0,$s6",
      "beq $t0,$t6,sorting",
      "lw $t4,0($s2)",
      "sw $t4,0($s3)",
      "addi $s2,$s2,4",
      "addi $s3,$s3,4",
      "addi $s6,$s6,1",
      "j copy",
      "sorting:",
      "addi $s6,$zero,-1",
      "addi $s0,$t1,-2",
      "outer_loop:",
      "slt $t0,$s0,$s6",
      "beq $t0,$t6,print",
      "addi $s6,$s6,1",
      "addi $s3,$zero,0",
      "addu $s2,$zero,$t3",
      "j inner_loop",
      "inner_loop:",
      "sub $s1,$s0,$s6",
      "slt $t0,$s1,$s3",
      "beq $t0,$t6,outer_loop",
      "lw $t4,0($s2)",
      "lw $t5,4($s2)",
      "slt $t0,$t5,$t4",
      "beq $t0,$t6,swap",
      "return_here:",
      "addi $s2,$s2,4",
      "addi $s3,$s3,1",
      "j inner_loop",
      "swap:",
      "sw $t5,0($s2)",
      "sw $t4,4($s2)",
      "j return_here"]

#function to convert integer to binary
def binary(n):
    if(n>=0): #if n is positive
        return (format(n,'016b'))
    else: #if n is negative
        return (format((abs(n)^((2**16)-1))+1,'016b')) #finding the 2's compliment


for line in code:
    words=re.split(r'[ ,]+',line) #to seperate instructions with ' ' and ','
    if (words[0]=="addi"): #I type
        print("001000",end="")#opcode
        print(registers[words[2]],end="")#rs
        print(registers[words[1]],end="")#rt
        print(binary(int(words[3])))#immediate value
    if (words[0]=="addu"): #R type
        print("000000",end="")#opcode
        print(registers[words[2]],end="")#rs
        print(registers[words[3]],end="")#rt
        print(registers[words[1]],end="")#rd
        print("00000",end="")#shiftamt(sa)
        print("100001")#function field
    if(words[0]=="slt"): #R type
       print("000000",end="")#opcode
       print(registers[words[2]],end="")#rs
       print(registers[words[3]],end="")#rt
       print(registers[words[1]],end="")#rd
       print("00000",end="")#shiftamt(sa)
       print("101010")#function field
    if(words[0]=="beq"): #I type
        print("000100",end="")#opcode
        print(registers[words[1]],end="")#rs
        print(registers[words[2]],end="")#rt
        print(binary(int(labels[words[3]])))#immediate value
    if(words[0]=="lw"): #I type
        print("100011",end="")#opcode
        load_word=re.split(r'[()]+',words[2])#to seperate instruction with "()"
        print(registers[load_word[1]],end="")#rs
        print(registers[words[1]],end="")#rt
        print(format(int(load_word[0]),'016b'))#immediate value
    if(words[0]=="sw"): #I type
        print("101011",end="")#opcode
        store_word=re.split(r'[()]+',words[2])#to seperate instruction with "()"
        print(registers[store_word[1]],end="")#rs
        print(registers[words[1]],end="")#rt
        print(format(int(store_word[0]),'016b'))#immediate value
    if(words[0]=="j"): #J type
        print("000010",end="")#opcode
        s=str(format(int(labels[words[1]]),'028b')) #takeing 2 extra bits because two bits from LSB will be removed in next step
        print(s[:26])#jump address (2 LSB removed as per convention)
    if(words[0]=="sub"): #R type
        print("000000",end="")#opcode
        print(registers[words[2]],end="")#rs
        print(registers[words[3]],end="")#rt
        print(registers[words[1]],end="")#rd
        print("00000",end="")#shiftamt(sa)
        print("100010")#function field