# Three-digit-BCD-Adder
Three-digit binary-coded-decimal (BCD) adder capable of adding positive and negative BCD numbers.

The BCD adder you design must be capable of adding two three-digit BCD
operands to produce a three-digit sum. Each of the two operands can be either
positive or negative, so the adder must, in effect, be capable of both addition and
subtraction.

The operands and sum are represented using 13-bit binary vectors where 12 of the bits are the three 4-bit BCD digits and the 13th bit is a sign bit (0 if the number is positive and 1 if it is negative). This is essentially a sign-plusmagnitude representation where the magnitude is represented with the BCD code.

The adder should also have a one-bit overflow output signal that is 1 if the addition results in an overflow (a magnitude that is too big to be represented with 3 BCD digits) and 0 otherwise.
