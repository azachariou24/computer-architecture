############################################################################
#Program Name		: This program prints the results of the Taylor series ln(1+ x) for 20 iterations
#					: Taylor series ln(1+ x) for 20 iterations 
#				
#Programmer			: Anastasis Zachariou	Stud. ID:1107556
#Date Last Modif.	: 26 Sep. 2024
#############################################################################
# Comments: 		  The Taylor series is the representation of a function as a sum of infinite terms 
#					  calculated from the values of its derivatives at a given point.
#############################################################################
	.data			# The start of the data segment	

message1:	.asciiz "terms["
message2:	.asciiz "] : ln("
message3:	.asciiz "]R: ln("
message4:	.asciiz ")="
newLine:	.asciiz "\n"	# New line
#############################################################################
	.text			# text segment
	.globl main

#############################################################################
											#
#############################################################################
#				  #	$f7 <= 0	     # $t0 <= 2    #			 # syscall 	#
# $s1 <= n <= 100 # $f30 <= i <= 0.0 # $f4 <= 2    # $f21 <= 0.1 # $v0, $a0 #
# 				  #					 # $f20 <= 2.0 #			 # and $f12 #
#############################################################################	
											#
#############################################################################
											# -
main:										# The label for the main function!
											# -
		ori $s1, $zero, 100					# $s1 <= n <= 100
											# -
		mtc1 $zero, $f7						# $f7 <= 0
		cvt.s.w $f30, $f7					# $f30 <= i <= 0.0 
											# -
		li $t0, 2							# $t0 <= 2
		mtc1 $t0, $f4						# $f4 <= 2
		cvt.s.w $f20, $f4					# $f20 <= 2.0
											# -
		li.s $f21, 0.1						# $f21 <= 0.1
											# -	
For_Loop_Main:								# The label for the for - loop in main function	   <-------------------------
											# -																			^
		c.lt.s $f20, $f30					# if $f20(<=2.0) <= $f30(<=i)												|
		bc1t End_For_Main					# branch to (End_For_Main) if the flag is set ----------------------------->|-->
											# -																			|	|	
		li $v0, 4 							# 4 is the code for printing strings 										|	|
		la $a0, message1 					# load address of message1													|	|
		syscall								# execute the system call, print "terms[" 									|   |
											# -																			|   |		
		li $v0, 1 							# 1 is the code for printing integers										|   |
		move $a0, $s1						# $a0 <= $s1(<=100) because move = copy in the integers numbers				|   |
		syscall 							# execute the system call, print n											|   |
											# -																			|	|		
		li $v0, 4 							# 4 is the code for printing strings										|   | 
		la $a0, message2 					# load address of message2													|   |
		syscall								# execute the system call, print "] : ln("									|   |
											# -																			|   |
		li $v0, 2							# 2 is the code for printing float number									|   |
		mov.s $f12, $f30					# $f12 <= $f30(<=i) because mov.s = copy in the floats numbers				|   |
		syscall 							# execute the system call, print i											|   |
											# -																			|   |
		li $v0, 4 							# 4 is the code for printing strings										|   |
		la $a0, message4 					# load address of message4													|   |
		syscall								# execute the system call, print ")="										|	|
											# -																			|	|
#for the Taylor_ln function					# -																			|   |
		mov.s $f14, $f30					# $f14 <= $f30(<=i) because mov.s = copy in the floats numbers				|   |
		move $a3, $s1						# $a3 <= $s1(<=100) because move = copy in the integers numbers				|   |
											# -																			|   |
		jal Taylor_ln						# jump and link => moves to the target address (Taylor_ln) AND		--------|---| --->
											# AND stores the address of the next instruction in the register $ra 		|   |	 |
											# -																			|   |	 |
		li $v0, 2							# 2 is the code for printing float number								    |   |	 |
		mov.s $f12, $f2						# $f12 <= $f2(<=result Taylor_ln) because mov.s = copy in the floats numbers|   |	 |
		syscall 							# execute the system call, print the result of the (Taylor_ln) function     |   |	 |
											# -																			|   |	 |	
		li $v0, 4 							# 4 is the code for printing strings										|   |	 |
		la $a0, newLine 					# load address of newLine													|   |	 |
		syscall								# execute the system call, print "\n"										|   |	 |
											# -																			|   |	 |	
#############################################################################											|   |	 |
											# -																			|   |	 |
		li $v0, 4 							# 4 is the code for printing strings 										|   |	 |
		la $a0, message1 					# load address of message1													|   |	 |
		syscall								# execute the system call, print "terms["									|   |	 |
											# -																			|   |	 |	
		li $v0, 1 							# 1 is the code for printing integers										|   |	 |
		move $a0, $s1						# $a0 <= $s1(<=100) because move = copy in the integers numbers				|   |	 |
		syscall 							# execute the system call, print n											|   |	 |
											# -																			|   |	 |
		li $v0, 4 							# 4 is the code for printing strings										|   |	 |
		la $a0, message3 					# load address of message3													|   |	 |
		syscall								# execute the system call, print "]R: ln("									|   |	 |
											# -																			|   |	 |
		li $v0, 2							# 2 is the code for printing float number									|   |	 |
		mov.s $f12, $f30					# $f12 <= $f30(<=i) because mov.s = copy in the floats numbers				|   |	 |
		syscall 							# execute the system call, print i											|   |	 |
											# -																			|   |	 |	
		li $v0, 4 							# 4 is the code for printing strings 										|   |	 |
		la $a0, message4 					# load address of message4													|   |	 |
		syscall								# execute the system call, print ")="										|   |	 |
#for the Taylor_lnRecursive function		# -																			|   |	 |	
		mov.s $f14, $f30					# $f14 <= $f30(<=i) because mov.s = copy in the floats numbers				|   |	 |
		move $a3, $s1						# $a3 <= $s1(<=100) because move = copy in the integers numbers				|   |	 |
											# -																			|   |	 |
		jal Taylor_lnRecursive				# jump and link => moves to the target address (Taylor_lnRecursive) AND ----|---|----|--->
											# AND stores the address of the next instruction in the register $ra 		|   |	 |	 |
											# -																			|   |	 |	 |			
		li $v0, 2							# 2 is the code for printing float number									|   |	 |	 |
		mov.s $f12, $f2						# $f12 <= $f2(<=result Taylor_lnRecursive)because mov.s = copy in the floats|   |	 |	 |
		syscall 							# execute the system call, print the result of the Taylor_lnRecursive funct.|   |	 |	 |
											# -																			|   |	 |	 |
		li $v0, 4 							# 4 is the code for printing strings										|   |	 |	 |
		la $a0, newLine 					# load address of newLine													|   |	 |	 |
		syscall								# execute the system call, print "\n"										|   |	 |	 |
											# -																			|   |	 |	 |
#############################################################################											|   |	 |	 |
											# -																			|   |	 |	 |
		add.s $f30, $f30, $f21				# $f30 <= i (=> i+=0.1;)													|   |	 |	 |
											# -																			|   |	 |	 |
		j For_Loop_Main						# jump --------------------------------------------------------------------->   |	 |	 |
											# -																				v	 |	 |
End_For_Main:								# Exit from the main loop  <-----------------------------------------------------	 |	 |
											# -																					 |	 |
		li $v0, 10 							# 10 is the code for exiting the program                                             |	 |
		syscall 							# exit syscall																		 |	 |
											# - 																				 |	 |
#############################################################################													 |   |
											# 																					 |	 |
#############################################################################													 |   |
# $f12 <= x	  #		       #                      #				            #													 |   |
#             #  $a0 <= n  # $f0 <= return value  # $t1 <= 1 => $f4 => 1.0  #												     |   |
# $f5 <= $f12 #			   #                      #				            #												     |   |
#############################################################################													 |   |
											# 																					 |	 |
#############################################################################													 |   |
											# -																					 |	 |
powerR:									    # The label for the powerR function!  <-----------------------------------			 |	 |
											# -																		 ^			 |	 |
		addi $sp, $sp, -12                  # prepare stack 														 |			 |	 |					
		sw $ra, 8($sp)						# save return address in the stack										 |			 |	 |
		swc1 $f12, 4($sp)                   # save argument $f12( <= x) in the stack								 |			 |	 |
		sw $a0, 0($sp)                      # save argument $a0( <= n) in the stack 								 |		     |	 |
		                                    # -																		 |			 |	 |
		bne $a0, $zero, greater_than_zero   # if(n != 0) go to the label => greater_than_zero --------> 			 |			 |	 |
											# -														   |			 |		 	 |	 |
		addi $t1, $zero, 1                  # else $t1 <= 0 + 1										   |			 |			 |	 |
		mtc1 $t1, $f4      				    # $f4 <= $t1 <= 1									       |			 |			 |	 |
		cvt.s.w $f0, $f4				    # $f0 <= 1.0											   |			 |			 |	 |
											# -                                                        |			 |			 |	 |
		addi $sp, $sp, 12					# restore stack	  										   |			 |	         |   |
											# -                                                        |			 |			 |	 |
		jr $ra								# jump register - back from the process                    |             |           |   |
											# -                                                        v		  	 |			 |	 |
greater_than_zero:							# The label for the greater_than_zero. <--------------------             |			 |	 |
											# -															             |			 |	 |
		addi $a0, $a0, -1                   # $a0 <= $a0 - 1 (<= n - 1 )								             |			 |	 |
		# Retrograde step                   # jump and link => moves to the target address (powerR) AND 	         |			 |	 |
		jal powerR							# AND stores the address of the next instruction in the register $ra ---->           |   |
											# -																		 ^			 |	 |
		lw $a0, 0($sp)						# restore initial $a0,    												 |			 |	 |
		lwc1 $f12, 4($sp)					# restore initial $f12													 |		     |	 |
		lw $ra, 8($sp)						# and return address													 |			 |	 |
											# - 																	 |			 |	 |
		addi $sp, $sp, 12					# restore stack															 |			 |	 |
											# -																		 |			 |	 |		
		mov.s $f5, $f12						# $f5 <= $f12														  	 |			 |	 |
											# -															          	 |			 |	 |
		mul.s $f0, $f5, $f0				    # $f0 <= $f5 * $f0 (<= x * powerR value)							  	 |			 |	 |
											# -                                                                      |           |   |
		jr $ra								# jump register - back from the process								     |           |   |
											# -																		 |			 |	 |
#############################################################################										 |			 |   |
											# 																		 |			 |	 |
###########################################################################################################  		 |			 |   |
#        	#           #  $a1 <= i  #  $f1 <= return value  # value of the (ψ)  # $f6 <= 0   # $t3 <= -1 #	         |		     |   |
# $f13 <= x #  $a2 <= n # $f10 <= i  ######################### call to the funct.# $f7 <= 0   #	 	      #          |		     |   |
#           #	        # $f16 <=(f)i#  $t2 <= if - result   #  $f22 and $f23    # $f9 <= 0.0 # $f8 <= -1 #	         |		     |   |
###########################################################################################################          |			 |   |
											# 																		 |			 |	 |
#############################################################################										 |			 |   |
											# -																		 |			 |	 |
Taylor_lnR:									# The label for the Taylor_lnR function!  <----------------------------------	     |	 |
											# -																		 ^  ^		 |	 |
		addi $sp, $sp, -20					# prepare stack 														 |  |		 |	 |					
		sw $ra, 16($sp)						# save return address in the stack										 |  |		 |	 |
		swc1 $f22, 12($sp)					# save argument $f22( <= powerR(-1,i+1))* powerR(x,i)/i) ) in the stack  |  |		 |	 |
		swc1 $f13, 8($sp)					# save argument $f13( <= x) in the stack								 |  |		 |	 |
		sw $a1, 4($sp)						# save argument $a1( <= i) in the stack 								 |  |		 |	 |
		sw $a2, 0($sp)						# save argument $a2( <= n) in the stack 								 |  |		 |	 |
											# -																		 |  |	     |	 |
		slt $t2, $a2, $a1					# if(i > n)	=> if($a2=n < $a1=i) and the result stored in the $t2		 |  |	     |	 |
		beq $t2, $zero, Else_Taylor_lnR		# check if the result of the (if) is false and go to the label --->	     |  |		 |	 |
											# -																  |		 |  |		 |	 |
		mtc1 $zero, $f6						# else if the rerult of the (if) is true => $f6 <= 0			  |		 |  |		 |	 |
		cvt.s.w $f1, $f6   					# $f1 <= 0.0                                                      |	     |  |		 |	 |
											# -																  |		 |  |		 |	 |
		addi $sp, $sp, 20					# restore stack													  |		 |  |		 |	 |
											# -																  |      |  |		 |	 |
		jr $ra								# jump register - back from the process							  |      |  |		 |	 |
											# -																  v		 |  |		 |	 |
Else_Taylor_lnR:							# The label for the Else_Taylor_lnR	  <----------------------------		 |  |		 |	 |
											# -																		 |  |		 |	 |
		li $t3, -1							# $t3 <= -1 															 |  |		 |	 |
		mtc1 $t3, $f8      					# $f8 <= $t3 <= -1														 |  |		 |	 |
		cvt.s.w $f12, $f8					# $f12 (<= x in the powerR function) <= -1.0                             |  |		 |	 |
											# -																		 |  |		 |	 |
		add $t3, $a1, $zero					# $t3 <= $a1 (<= i) + 0	/ $t3 <= i										 |  |		 |	 |
		addi $t3, $t3, 1					# $t3 <= $t3 + 1 (<= i + 1)                                              |  |		 |	 |
		or $a0, $zero, $t3					# $a0 (<= n in the powerR function) <= i + 1							 |  |		 |	 |
											# -																		 |  |		 |	 |
											# jump and link => moves to the target address (powerR) AND 	         |  |		 |	 |
		jal powerR							# AND stores the address of the next instruction in the register $ra ---->  |		 |	 |
											# -                                                                      ^  |		 |	 |
		mtc1 $zero, $f7						# $f7 <= 0																 |  |		 |	 |
		cvt.s.w $f9, $f7					# $f9 <= 0.0                                                             |  |		 |	 |
											# -                                                                      |  |		 |	 |
		add.s $f22, $f0 , $f9				# $f22 <= $f0 (<= The value of the first call to the function powerR)    |  |		 |	 |
############################################# -                                                                      |  |		 |	 |
		add.s $f12, $f13, $f9				# $f12 (<= x in the powerR function) <= $f13(<= x in the Taylor_lnR fun.)|  |		 |	 |
											# -                                                                      |  |		 |	 |
		move $a0, $a1						# $a0 <= $a1(<= i in the Taylor_lnR fun.)                                |  |		 |	 |
											# -																		 |  |		 |	 |
											# jump and link => moves to the target address (powerR) AND 	         |  |		 |	 |
		jal powerR							# AND stores the address of the next instruction in the register $ra ---->  |		 |	 |
											# -																		 ^	|		 |	 |
		add.s $f23, $f0 , $f9				# $f23 <= $f0 (<= The value of the second call to the function powerR)	 |  |        |	 |
############################################# -                                                                      |	|		 |	 |
		mtc1 $a1, $f10						# $f10 <= $a1 <= i														 |	|		 |	 |
		cvt.s.w $f16, $f10					# $f16 <= $f10 <= (float) i												 |  |		 |	 |
											# -																		 |	|		 |	 |		
		div.s $f23, $f23, $f16 				# $f23 <= powerR(x,i)/i													 |	|		 |	 |
											# -																		 |	|		 |	 |
		mul.s $f22, $f22, $f23				# $f22 <= $f22 (<= powerR(-1,i+1)) * $f23(<= powerR(x,i)/i)  			 |  |		 |	 |
											# -																		 |	|		 |	 |
		addi $a1, $a1, 1					# $a1 <= $a1 + 1 <= ++i;												 |	|		 |	 |
											# -																		 |  |		 |	 |
		# Retrograde step					# jump and link => moves to the target address (Taylor_lnR) AND 	     |  |		 |	 |
		jal Taylor_lnR						# AND stores the address of the next instruction in the register $ra ------->  		 |	 |
											# -																		 ^	^		 |	 |
		lw $a2, 0($sp)						# restore initial $a2,													 |	|	     |	 |
		lw $a1, 4($sp)						# restore initial $a1,													 |	|	     |	 |
		lwc1 $f13, 8($sp)            		# restore initial $f13,													 |	|	     |	 |
		lwc1 $f22, 12($sp)            		# restore initial $f22													 |	|	     |	 |
		lw $ra, 16($sp)						# and return address													 |	|		 |	 |
											# -																		 |	|		 |	 |
		addi $sp, $sp, 20					# restore stack															 |	|		 |	 |
											# -																		 |	|		 |	 |
		add.s $f1, $f22, $f1				# $f1 <= $f22 ( powerR(-1,i+1))* powerR(x,i)/i) ) + $f1(<= return value) |  |        |	 |
											# -																		 |	|		 |	 |
		jr $ra								# jump register - back from the process									 |	|		 |	 |
											# -																		 |	|		 |	 |
#############################################################################										 |	|		 |   |
											# 																		 |	|		 |	 |
##########################################################################											 |	|		 |   |
#           #		   #                      # $t3 <= -1 => $f8 => -1.0 #											 |	|		 |   |
# $f14 <= x # $a3 <= n # $f2 <= return value  #                          #											 |	|	     |   |
#           #		   #                      # $f7 <= 0 => $f17 => 0.0  #											 |	|	     |   |
##########################################################################	  										 |	|		 |   |
											# 																		 |	|		 |	 |
#############################################################################										 |	|		 |   |
											# -																		 |	|		 |	 v
Taylor_lnRecursive:							# The label for the Taylor_lnRecursive function! <-----------------------------------|----
											# -																		 ^	^		 |
		addi $sp, $sp, -12					# prepare stack 														 |	|		 |
		sw $ra, 8($sp)						# save return address in the stack										 |	|		 |
		swc1 $f14, 4($sp)					# save argument $f14( <= x) in the stack								 |	|		 |
		sw $a3, 0($sp)						# save argument $a3( <= n) in the stack 								 |	|	     |
											# -																		 |	|		 |
		li $t3, -1							# $t3 <= -1																 |	|		 |
		mtc1 $t3, $f8      					# $f8 <= $t3 <= -1														 |	|		 |
		cvt.s.w $f13, $f8	                # $f13 = -1.0															 |	|		 |
											# -																		 |	|		 |
		add.s $f13, $f14, $f13				# $f13 <= $f14 (<= x) + (-1.0) 											 |	|		 |
		addi $a1, $zero, 1					# $a1 (<= i in the Taylor_lnR function) <= 1                             |  |		 |
		move $a2, $a3						# $a2 (<= n in the Taylor_lnR function) <= $a3							 |	|		 |
											# -																		 |  |		 |	 
											# jump and link => moves to the target address (Taylor_lnR) AND 	     |  |		 |	 
		jal Taylor_lnR						# AND stores the address of the next instruction in the register $ra ------->  		 |	 
											# -																		 ^			 |	 
		lw $a3, 0($sp)						# restore initial $a3,													 |			 |
		lwc1 $f14, 4($sp)					# restore initial $f14													 |			 |
		lw $ra, 8($sp)						# and return address													 |			 |
											# - 																	 |			 |
		addi $sp, $sp, 12					# restore stack															 |	         |
											# -																		 |			 |
		mtc1 $zero, $f7						# $f7 <= 0																 |			 |
		cvt.s.w $f17, $f7					# $f17 <= 0.0															 |			 |
											# -																		 |			 |
		add.s $f2, $f1, $f17				# $f2 <= $f1 (<= The value of the first call to the function Taylor_lnR) |			 |
											# -																		 |			 |
		jr $ra								# jump register - back from the process									 |			 |
											# -																		 |			 |
#############################################################################										 |			 |   
											# 																		 |			 |	 
#######################################################################################################			     |		     |   
# $f14 <= x   #	$a3 <= n # $f2 <= return value  # $t3 <= -1 => $f6 => -1.0        # value of the (ψ)  #				 |			 |   
# 		      #          ######################## $f8 => -1 ## $f10 and $f16 => i # call to the funct.#				 |			 |   
# $f24 <= sum #	$s2 <= i #  $t4 <= if - result  # $f7 <= 0 => $f9  => 0.0         #$f25, $f26 and $f27#				 |			 |   
#######################################################################################################				 |		     |   
											# 																		 |			 |	 
#############################################################################										 |			 |   
											# -																		 |			 v
Taylor_ln:									#  The label for the Taylor_ln function!   <------------------------------------------
											# -																		 ^
		addi $sp, $sp, -16					# prepare stack															 |
		sw $ra, 12($sp)						# save return address in the stack										 |
		sw $s2, 8($sp)						# save argument $s2( <= i) in the stack			     					 |
		swc1 $f14, 4($sp)					# save argument $f14( <= x) in the stack								 |
		sw $a3, 0($sp)						# save argument $a0( <= n) in the stack									 |
											# -																		 |
		mtc1 $zero, $f7						# $f7 <= 0																 |
		cvt.s.w $f24, $f7					# $f24 <= sum <= 0.0													 |
											# -																		 |
		li $t3, -1							# $t3 <= -1																 |
		mtc1 $t3, $f8   					# $f8 <= $t3 <= -1														 |  
		cvt.s.w $f6, $f8					# $f6 <= $f8 <= -1.0													 |
											# -																		 |
		add.s $f14, $f14, $f6				# $f14 <= $f14 + $f6 <= (x = x + (-1))									 |
											# -																		 |
		ori $s2, $zero, 1					# $s2 <= i <= 1															 |
											# -																		 |
Loop_Taylor_ln:								# The label for the for - loop in the Taylor_ln function <---------------------------
											# -																		 ^			^
		slt $t4, $a3, $s2					# if(i > n)	=> if($a3=n < $s2=i) and the result stored in the $t4 		 |			|
		bne $t4, $zero, End_For				# check if the result of the (if) is false and go to the label --------->|-----	    |
											# -																		 |	  v	    |
		li $t3, -1							# $t3 <= -1																 |	  |		|
		mtc1 $t3, $f8   					# $f8 <= $t3 <= -1														 |	  |		|  
		cvt.s.w $f12, $f8					# $f12 (<= x in the powerR function) <= $f8 <= -1.0					     |	  |		|
											# -																		 |	  |		|
		add $t3, $s2, $zero					# $t3 <= $s2 <= i														 |	  |	    |
		addi $t3, $t3, 1					# $t3 <= $t3 + 1														 |	  |		|
		or $a0, $zero, $t3					# $a0 (<= n in the powerR function) <= $t3 <= (i + 1)					 |	  |		|
											# -																		 |    |		|	 
											# jump and link => moves to the target address (powerR) AND 	         |    |		|	 
		jal powerR							# AND stores the address of the next instruction in the register $ra ---->    |		|	 
											# -                                                                      ^    |		|	 
		mtc1 $zero, $f7                     # $f7 <= 0																 |	  |		|
		cvt.s.w $f9, $f7					# $f9 <= $f7 <= 0.0														 |	  |		|
											# -																		 |	  |  	|		
		add.s $f25, $f0 , $f9				# $f25 <= $f0 (<= result in the powerR function)					     |	  |		|
		#######################             # -																		 |	  |		|
		add.s $f12, $f14, $f9				# $f12(<= x in the powerR function)<=$f14(<= x in the Taylor_ln function)|	  |		|
											# -																		 |	  |		|		
		move $a0, $s2						# $a0 (<= n in the powerR function) <= $s2 <= i							 |	  |		|
											# -																		 |    |		|	 
											# jump and link => moves to the target address (powerR) AND 	         |    |		|	 
		jal powerR							# AND stores the address of the next instruction in the register $ra ---->    |		|	 
											# -                                                                        	  |		|
		add.s $f26, $f0 , $f9				# $f26 <= $f0 (<= result in the powerR function)					          |		|
											# -																			  |		|		
		mtc1 $s2, $f10						# $f10 <= $s2 <= i															  |		|
		cvt.s.w $f16, $f10					# $f16 <= $f10 <= (float) i													  |		|
		div.s $f26, $f26, $f16				# $f26 <= $f26 / $f16 <= ( powerR(x, i) / (float) i )						  |		| 
											# -																			  |		|	
		mul.s $f27, $f25, $f26				# $f27 <= $f25 * $f26 <= ( (powerR(-1,i+1))*(powerR(x,i)/i) )				  |		| 
		add.s $f24, $f24, $f27				# $f24 <= $f24 + $f27 <= sum = sum + (powerR(-1,i+1))*(powerR(x,i)/i);		  |		| 
											# -																			  |		|
		addi $s2, $s2, 1					# $s2 <= $s2 + 1 <= i++;	                                                  |  	|
											# -                                                                			  |  	|		
		j Loop_Taylor_ln					# jump ----------------------------------------------------------------------------->
											# -																			  v
End_For:									# Exit from the Taylor_ln loop  <----------------------------------------------
											# -		
		lw $a3, 0($sp)						# restore initial $a3,												
		lwc1 $f14, 4($sp)					# restore initial $f14													
		lw $s2, 8($sp)						# restore initial $s2
		lw $ra, 12($sp)						# and return address													
											# - 																	
		addi $sp, $sp, 16					# restore stack															
											# -																		
		mtc1 $zero, $f7						# $f7 <= 0
		cvt.s.w $f9, $f7					# $f9 <= $f7 <= 0.0
											# -		
		add.s $f2, $f24, $f9				# $f2 <= $f24 <= sum
											# -				
		jr $ra								# jump register - back from the process			
											# -		
#############################################################################