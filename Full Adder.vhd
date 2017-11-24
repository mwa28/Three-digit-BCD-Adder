library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
	port (
	X1: in std_logic;
	Y1: in std_logic;
	CIN1: in std_logic;
	S1: out std_logic;
	COUT1: out std_logic);	
end full_adder;

architecture full_adder of full_adder is
begin 
S1 <= (X1 XOR Y1) XOR CIN1;
COUT1 <= (X1 AND Y1) OR (X1 AND CIN1) OR (Y1 AND CIN1);
end full_adder;
