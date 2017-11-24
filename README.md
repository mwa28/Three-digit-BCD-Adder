# Three-digit-BCD-Adder
Three-digit binary-coded-decimal (BCD) adder capable of adding positive and negative BCD numbers.

The BCD adder you design must be capable of adding two three-digit BCD
operands to produce a three-digit sum. Each of the two operands can be either
positive or negative, so the adder must, in effect, be capable of both addition and
subtraction.

The operands and sum are represented using 13-bit binary vectors where 12 of the bits are the three 4-bit BCD digits and the 13th bit is a sign bit (0 if the number is positive and 1 if it is negative). This is essentially a sign-plusmagnitude representation where the magnitude is represented with the BCD code.

The adder also has a one-bit overflow output signal that is 1 if the addition results in an overflow (a magnitude that is too big to be represented with 3 BCD digits) and 0 otherwise.

The adder is organized as three identical digit-adders connected in a ripplecarry
configuration. Each of the digit-adders is capable of adding two 4-bit BCD
digits and a 1-bit carry/borrow input to produce a 4-bit BCD sum and 1-bit
carry/borrow output. 

The adder implements the following general algorithm:
1. The adder checks the signs and relative magnitude of the two operands.
2. If signs are the same, the adder adds the operands and makes the sign of the
result equal the signs of the operands.
3. If the signs differ, then the adder compares the magnitudes of the operands,
subtracts the smaller from the larger, and sets the sign of the result equal to
the sign of the larger. Note that if the result is 0, the sign of the result must be
positive (0 sign bit).
