# Test file for "Lab4_stateMachines"


# commands.gdb provides the following functions for ease:
#   test "<message>"
#       Where <message> is the message to print. Must call this at the beginning of every test
#       Example: test "PINA: 0x00 => expect PORTC: 0x01"
#   checkResult
#       Verify if the test passed or failed. Prints "passed." or "failed." accordingly, 
#       Must call this at the end of every test.
#   expectPORTx <val>
#       With x as the port (A,B,C,D)
#       The value the port is epected to have. If not it will print the erroneous actual value
#   setPINx <val>
#       With x as the port or pin (A,B,C,D)
#       The value to set the pin to (can be decimal or hexidecimal
#       Example: setPINA 0x01
#   printPORTx f OR printPINx f 
#       With x as the port or pin (A,B,C,D)
#       With f as a format option which can be: [d] decimal, [x] hexadecmial (default), [t] binary 
#       Example: printPORTC d
#   printDDRx
#       With x as the DDR (A,B,C,D)
#       Example: printDDRB

echo ======================================================\n
echo Running all tests..."\n\n
#test sequeence from init: A0 & !A1, !A0 & !A1,  A0 & !A1,!A0 and !A1, A0 & !A1,!A0 AND !A1, !A0 & A1, => PORTC: 8
test "Add, Add, Add, subtract\nPINA: 0x01, 0x11, 0x01,0x11, 0x01, 0x11, 0x10, 0x11, => PC = 0x08  state:interphase"
set addsm = init 
setPINA 0x01
continue 2
setPINA 0x11
continue 2
setPINA 0x01
continue 2
setPINA 0x11
continue 2
setPINA 0x01
continue 2
setPINA 0x11
continue 2
setPINA 0x02
continue 2
setPINA 0x11
continue 2
expectPORTC 0x08
expect addsm interphase
checkResult

#test sequeence from init: !A0 & A1, !A0 & A1, !A0 & A1, !A0 & A1,... !A0 & A1 => PORTC: 0
test "Reset, subtract, subtract, subtract, subtract, subtract\nPINA: 0x00, 0x02, 0x11, 0x02, 0x11, 0x02, 0x11, 0x02, 0x11 => PC = 0x08  state:interphase"
set addsm = init
continue 5
setPINA 0x00
continue 2
setPINA 0x02
continue 2
setPINA 0x11
continue 2
setPINA 0x02
continue 2
setPINA 0x11
continue 2
setPINA 0x02
continue 2
setPINA 0x11
continue 2
setPINA 0x02
continue 2
setPINA 0x11
continue 2
expectPORTC 0x03
expect addsm interphase
checkResult

#test sequeence from init: A0 & !A1, A0 & !A1, A0 & !A1, !A0 & A1, => PORTC: 8
test "Reset, subtract, subtract, reset, subtract\n PINA: 0x00, 0x02, 0x11, 0x02, 0x11, 0x00, 0x02, 0x11 => PC = 0x06  state:interphae"
set addsm = init
setPINA 0x00
continue 2
setPINA 0x02
continue 2
setPINA 0x11
continue 2
setPINA 0x02
continue 2
setPINA 0x00
continue 2
setPINA 0x02
continue 2
setPINA 0x11
continue 2
expectPORTC 0x06
expect addsm interphase
checkResult

# Report on how many tests passed/tests ran
set $passed=$tests-$failed
eval "shell echo Passed %d/%d tests.\n",$passed,$tests
cho ======================================================\n
