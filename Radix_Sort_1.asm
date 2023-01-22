.data
arr1: .word  7, 91, 64, 3, 23, 1, 66, 12, 5             #array on which we are applying radix sort 
arr_size: .word 9

maxi_number_str : .asciiz "\nMaximum number is : "
array_str : .asciiz "\nInitial Array is : "
array_sorted_str : .asciiz "\nSorted Array is : "
arr2: .word 0:8                                         #temp array 
maximum_number_store : .word 0
counter1: .word 0           #counter which counts the digits of maximum number
m: .word 0


.text
.globl main
main:
    la	$t4, arr1                                   #get arr1 address in t4
    lw  $t0, arr_size                              #get arr1 size in t0 
    li  $t1,0                                       #setting counter to iterate through array
    li  $t3,0                                       
getMax:
    beq	$t0, $t1, maxiNumberFound           	    # if t0(size) ==t1(iterator)
    lw $t2,($t4)                                    #getting the elements of array in t2
    addi $t1,$t1,1                                  # t1++
    addi $t4,$t4,4                                  # advancing array pointer
    bgt	$t2, $t3, nono                        	# if $t2 > $t3 then getmax
    j getMax



nono:
    addi $t3,$t2,0                                  #if t2 was greater than t3(maximum number) =t2
    j getMax                                    #jump to maxiNumber to find anot



maxiNumberFound:
    # li $v0,4
    # la $a0,maxi_number_str                          #printing string Maximum number is :
    # syscall
    # # li $v0,1
    # # addi $a0,$t3,0                                  #printing the maximum number 
    # # syscall
    la $s0,maximum_number_store
    sw $t3,($s0)                                    #saving the maximum number for future use
    lw  $t0, maximum_number_store
    # li $v0,1
    # addi $a0,$t0,0
    # syscall
    li  $t1,0                                       #setting counter to iterate
    li  $t5,10


radixSort:
    div $t3,$t5
    mflo $t6
    bne $t6,$zero,again
    la $t0,counter1                 #now counter1 will be having how much digits does a maximum number has
    sw $t1,($t0)                    #we have saved it for future usage we will iterate 0-counter1
    
    la $t0,arr2                     #adress of temp array in t0
    la $t2,arr1                     #adress of main array in t2
fromarrayfill:
    lw $t3,($t2)                    #getting elements of arr1 t3
    li $t4,1                        #for power funtion t4 is set 1
    li $t7,0                        #power funtion iterator
frompower:
    beq $t7,$t1, power
    #now at this moment t4 has power which is requried
    div $t3,$t4                     # 7/1 = 7
    mflo $t6                        
    div $t6,$t5                     # t6/10
    mfhi $t6                        # t6 = t6%10
    sw $t6,($t0)
    addi $t9,$t9,1                  #t9++
    addi $t0,$t0,4                  #incrementing arrays 
    addi $t2,$t2,4                  #incrementing arrays 
    la $t8,arr_size
    lw $t4,($t8)
    beq $t4,$t9,CountSort
    # li $v0,1
    # addi $a0,$t6,0
    # syscall
    j fromarrayfill



again:
    addi $t1,$t1,1
    addi $t3,$t6,0
    j radixSort


power:
    mult	$t4, $t5			# calculating power if the t4 was greater than 0 than it came here to get multiply by 10 
    mflo	$t4
    addi    $t7,$t7,1           #t7++
    j  frompower
    

CountSort:
    la $s0,m
    sw $t1,($s0)    #saving iteration of counter m

    li $t0,1     #i=0    >> t0
    li $t1,1     #j=0    >> t1
    la $s0,arr1        #adress of temp array in s0
    la $s1,arr2     #adress of main array in s1
    la $t3,arr_size
    lw $t2,($t3) #length of array n  >>t2
    addi $t3,$t2,-1 #n-1 for j >>  t3
olx:
    lw $t4,($s0)
    lw $t5,4($s0)
    slt $s2,$t5,$t4
    bne $s2,$zero, swap
    j evo


printarray:
    la $a0,array_str
    li $v0,4                 
    syscall #printing string of array_str
    la $t3,arr_size
    lw $t2,($t3) #length of array n  >>t2
    addi $t0,$t0,0 #counter to iterate over array
    la $s7,arr1     #loading adress of arr1
samosa:
    lw $s6,($s7)
    beq $t0,$t2,jumpback
    addi $t0,$t0,1  # t0++
    addi $s7,$s7,4  #incrementing the arr[i++]
    li $v0 11  # syscall 11: print a character based on its ASCII value
    li $a0 44  # ASCII value of comma is "44"
    syscall
    li $v0,1
    addi $a0,$s6,0
    syscall
    j samosa


printData:
    la $a0,array_sorted_str
    li $v0,4                 
    syscall #printing string of array_str
    la $t3,arr_size
    lw $t2,($t3) #length of array n  >>t2
    addi $t0,$zero,0 #counter to iterate over array
    la $s7,arr1     #loading adress of arr1
gajar:
    lw $s6,($s7)
    beq $t0,$t2,exit
    addi $t0,$t0,1  # t0++
    addi $s7,$s7,4  #incrementing the arr[i++]
    li $v0 11  # syscall 11: print a character based on its ASCII value
    li $a0 44  # ASCII value of comma is "44"
    syscall
    li $v0,1
    addi $a0,$s6,0
    syscall
    j gajar

swap:
    sw $t5,($s0)
    sw $t4,4($s0)
evo:
    lw $t4,($s0)
    lw $t5,4($s0)
    beq $t1,$t3,hhh #if(j==n-1) than go to hhh
    addi $t1,$t1,1  #j++
    addi $s0,$s0,4     # array[j++]
    j olx


hhh:
    addi $t0,$t0,1     #i++
    beq $t0,$t2,ggg  # if(i==n) than go to ggg
    j ooo

ggg:
    j printData


ooo:
    li $t1,1     #j=0    >> reset j value
    la $s0,arr1        #array value reset
    j olx


exit:
    li $v0,10
    syscall