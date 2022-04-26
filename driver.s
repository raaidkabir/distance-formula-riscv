.data
welcome: .asciiz "A distance between 2 points will be outputted in hexadecimal:\n"
newline: .asciiz "\n"
px1: .float 3.2
px2: .float 3.3
py1: .float 3.2
py2: .float 3.3
tolerance: .float 0.001
zero: .word 0
half: .float 0.5
.text
#stored of values needed during the program; points on graph, tolerance, zero, and a 0.5 value
main:
    li a0, 4
    la a1, welcome
    ecall
    #prints welcome message
    la t0, px1
    la t1, px2
    la t2, py1
    la t3, py2
    la t4, zero
    la t5, half
    la t6, tolerance
    flw f0, 0(t0)
    flw f1, 0(t1)
    flw f2, 0(t2)
    flw f3, 0(t3)
    #loads memory addresses into registers, and then loads values from the memory addresses into FP registers
    fsub.s f0, f1, f0
    fsub.s f1, f3, f2
    fmul.s f0, f0, f0
    fmul.s f1, f1, f1
    fadd.s f0, f1, f0
    #subtract points from each other, square them, and lastly add them together
    flw f1, 0(t4)
    flw f7, 0(t5)
    flw f6, 0(t6)
    fadd.s f2, f1, f0
newton:
    fdiv.s f3, f0, f2
    fadd.s f3, f2, f3
    fmul.s f3, f3, f7
    fsub.s f4, f3, f2
    fabs.s f4, f4
    flt.s t0, f4, f6
    fadd.s f2, f3, f1
    beqz t0, newton
    #loop for newton's method
    fmv.x.s t0, f3
    li a0, 34
    addi a1, t0, 0
    ecall
    li a0 4
    la a1 newline
    ecall
    li a0 10
    ecall
    #transfer bits of the answer into a integer register and then print the hex value
