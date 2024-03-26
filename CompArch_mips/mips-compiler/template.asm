#run in linux terminal by java -jar Mars4_5.jar nc filename.asm(take inputs from console)

#system calls by MARS simulator:
#http://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html
.data
	next_line: .asciiz "\n"
	inp_statement: .asciiz "Enter No. of integers to be taken as input: "
	inp_int_statement: .asciiz "Enter starting address of inputs(in decimal format): "
	out_int_statement: .asciiz "Enter starting address of outputs (in decimal format): "
	enter_int: .asciiz "Enter the integer: "	
.text
#input: N= how many numbers to sort should be entered from terminal. 
#It is stored in $t1
jal print_inp_statement	
jal input_int 
move $t1,$t4			

#input: X=The Starting address of input numbers (each 32bits) should be entered from
# terminal in decimal format. It is stored in $t2
jal print_inp_int_statement
jal input_int
move $t2,$t4

#input:Y= The Starting address of output numbers(each 32bits) should be entered
# from terminal in decimal. It is stored in $t3
jal print_out_int_statement
jal input_int
move $t3,$t4 

#input: The numbers to be sorted are now entered from terminal.
# They are stored in memory array whose starting address is given by $t2
move $t8,$t2
move $s7,$zero	#i = 0
loop1:  beq $s7,$t1,loop1end
	jal print_enter_int
	jal input_int
	sw $t4,0($t2)
	addi $t2,$t2,4
      	addi $s7,$s7,1
        j loop1      
loop1end: move $t2,$t8       
#############################################################
#Do not change any code above this line
#Occupied registers $t1,$t2,$t3. Don't use them in your sort function.
#############################################################
#function: should be written by students(sorting function)
#The below function adds 10 to the numbers. You have to replace this with
#your code

#t1- number of inputs
#t2- starting adddress of input
#t3- starting address of output

addi $t6,$t6,1 #$t6 initialised to 1 to check if register used in slt has value 1
addi $s6,$zero,0  #s6=i=0
addi $s0,$t1,-1 #s0=n-1
addu $s2,$zero,$t2  #$s2 will have address of input
addu $s3,$zero,$t3  #$s3 will have address of output

#this section will copy the input array to the output address provided
copy: 
      slt $t0,$s0,$s6     #checks(n-1)<i, i starting from 0 to run n times
      beq $t0,$t6,sorting #when i>(n-1) i.e loop has run n times, we start sorting
      lw $t4,0($s2)  #$t4=input[i]
      sw $t4,0($s3)  #output[i]=$t4
      addi $s2,$s2,4  #moving input and output address one address ahead
      addi $s3,$s3,4
      addi $s6,$s6,1  #i++
      j copy  #looping
      
sorting:
	addi $s6,$zero,-1  #s6=i, s3=j. Starting i from -1 because it value increases before first jump to inner loop
	addi $s0,$t1,-2 #s0=n-2

outer_loop: slt $t0,$s0,$s6  #checks if i>n-2 (running loop n-1 times)
	    beq $t0,$t6,print  #when all numbers are iterated over and checked, we move on to print the result
	    addi $s6,$s6,1
	    addi $s3,$zero,0  #initializing j to 0
	    addu $s2,$zero,$t3  #s2 will be used to access elements of array, reset to starting address of output at every iteration of outer loop
	    j inner_loop
	    
inner_loop: sub $s1,$s0,$s6  #s1=n-1-i
	     slt $t0,$s1,$s3 #checks is i>n-1-i
	     beq $t0,$t6,outer_loop
	     lw $t4,0($s2)  #$t4=output[j]
	     lw $t5,4($s2)  #$t5=output[j+1]
	     slt $t0,$t5,$t4 #checks if output[j+]<output[j]
	     beq $t0,$t6,swap #if yes then the values are swapped
	     return_here: #returns to this line after values are swapped
	     		  addi $s2,$s2,4
	     		  addi $s3,$s3,1  #j++
	     		  j inner_loop  #looped back to inner_loop
	     
	     
	     
swap: sw $t5,0($s2) #output[j}=output[j+1]
      sw $t4,4($s2) #output[j+1]=output[j]
      j return_here
      	     
print:
#endfunction
#############################################################
#You need not change any code below this line

#print sorted numbers
move $s7,$zero	#i = 0
loop: beq $s7,$t1,end
      lw $t4,0($t3)
      jal print_int
      jal print_line
      addi $t3,$t3,4
      addi $s7,$s7,1
      j loop 
#end
end:  li $v0,10
      syscall
#input from command line(takes input and stores it in $t6)
input_int: li $v0,5
	   syscall
	   move $t4,$v0
	   jr $ra
#print integer(prints the value of $t6 )
print_int: li $v0,1	
	   move $a0,$t4
	   syscall
	   jr $ra
#print nextline
print_line:li $v0,4
	   la $a0,next_line
	   syscall
	   jr $ra

#print number of inputs statement
print_inp_statement: li $v0,4
		la $a0,inp_statement
		syscall 
		jr $ra
#print input address statement
print_inp_int_statement: li $v0,4
		la $a0,inp_int_statement
		syscall 
		jr $ra
#print output address statement
print_out_int_statement: li $v0,4
		la $a0,out_int_statement
		syscall 
		jr $ra
#print enter integer statement
print_enter_int: li $v0,4
		la $a0,enter_int
		syscall 
		jr $ra
