addi s7,zero,40
Loop:bge s2,s7,END
lw s4,0(s2)
sltu s5,s1,s4
beq s5,zero,ADD
add s1,s4,zero
ADD:addi s2,s2,4
jal zero, Loop
END: jal zero, END