#Exercise 3: Write a MIPS program that plays the first dozen or so notes of your new hit single (or if you don’t have
#your own hit single, then your favorite!) Experiment with system calls 31, 32 and 33. Put the notes to your song in
#a mips “array”

#Equivalent C Code:
#for(int i = 0; i<pitches.length(); i++) {
#  int currentPitch = pitches[i];
#  int currentDuration = durations[i];
#  midiOut(currentPitch,currentDuration,instrument,volume)
#}

#Let:
#$s0 = i
#$s1 = base address of pitches
#$s2 = base address of duration
#$s3 = currentPitch
#$s4 = currentDuration
#$s5 = length of the array

move $s0,$zero# set i to 0

la $s1,pitches #load pitches base address
la $s2,durations #load durations base address
lw $s5,array_length #load array_length to $s5

lw $a2,instrument #loads instrument as an argument
lw $a3,volume #loads volume as an argument
Loop:
sll $t0,$s0,2 #find the offset = i*4 (can be used for both arrays)

#Get currentPitch
add $t1,$s1,$t0 #find the address and store it to $t1 by adding base to offset
lw $s3,0($t1) #load pitches[i] into s3 (currPitch)

#Get currentDuration
add $t1,$s2,$t0 #Find the address and store it to $t1 by adding base to offset
lw $s4,0($t1) #load durations[i] into s4 (currDuration)

#Play the MIDI
li $v0,33 #load the system code to play MIDI sync
move $a0,$s3 #load the currPitch into the $a0 register
move $a1,$s4 #Load the currDur into the $a1 register
syscall

addi $t2,$s5,-1
beq $s0,$t2,Exit #if i == array_length-1, Exit
addi $s0,$s0,1 #increment i by one
j Loop #go back to Loop

Exit: #End of the program

.data
pitches: .word 71,62,66,67,66,62,70,61,66,67,66,61,71,62,66,67,66,62,67,66,62,67,66,62
durations: .word 250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250
array_length:  24 #length of the array
volume: 127 #volume (0-127)
instrument: 2 #instrument id (0-127)
