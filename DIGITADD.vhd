library ieee;
use ieee.std_logic_1164.all;

entity DIGITADD is
	port(
		bcdA: in std_logic_vector(3 downto 0);
		bcdB: in std_logic_vector (3 downto 0);
		Cin: in std_logic;
		Flag, M: in std_logic;
		Sum: out std_logic_vector(3 downto 0);
		Cout: out std_logic
);
end DIGITADD;

architecture DIGITADD of DIGITADD is

component adder_4b is

	port( 
		A: in std_logic_vector (3 downto 0); 
		B: in std_logic_vector (3 downto 0);
		C0: in std_logic; 
		S4: out std_logic_vector (3 downto 0);
		C4: out STD_LOGIC
);
end component;

component subtractor_4b is
port(
	A: in std_logic_vector(3 downto 0);
	B: in std_logic_vector(3 downto 0);
	B0: in std_logic;
	S4: out std_logic_vector(3 downto 0);
	B4: out std_logic
);
end component;

component two_compl is						-- this component takes X as bcdB and F as Flag, if Flag = '1', then bcdB
	port(							-- is complemented, otherwise it remains the same.
		X: in std_logic_vector (3 downto 0);
		F: in std_logic;
		Y: out std_logic_vector (3 downto 0)
);
end component;						


signal bcdA2, bcdB2: std_logic_vector(3 downto 0); 		-- bcdA2 : bcdA - borrow in case of a borrow | bcdB2 : 2's complement of B
signal sADD, sSUB1, sSUB2: std_logic_vector (3 downto 0);	-- sADD : when adding | sSUB1 : when subtracting with bcdA > bcdB | sSUB2: when subtracting with bcdA < bcdB
signal V, V2: std_logic_vector (3 downto 0);			-- V : +0110, when addition presents an overflow | V2: +1010, when the subtrahend is bigger than the minuend
signal corr, Cout2, Cout3, Cout4, NB : std_logic;		-- NB and Cout3 are ignored.
signal borrow, carry : std_logic;			

BEGIN


process (Cin, borrow, carry, Flag)
begin
	if ( Flag = '0') then 
		carry <= Cin; 
		borrow <= '0';

	elsif (Flag = '1') then 
		carry <= '0'; 
		borrow <= Cin;

	end if;
end process;


	U0 : subtractor_4b port map (A => bcdA, B => "0000", B0 => borrow, S4 => bcdA2, B4 => NB);	-- subtracting borrow from A if borrow = 1

	U1 : two_compl port map (X => bcdB, F => Flag, Y => bcdB2) ; 					-- complementing B if Flag = '1'

	U2 : adder_4b port map ( A => bcdA2, B => bcdB2, C0 => carry, S4 => sSUB1, C4 => Cout2); 	-- adding A + B

corr <= (sSUB1(3) AND sSUB1(2)) OR (sSUB1(3) AND sSUB1(1)) OR (Cout2);  		-- since we have bcd digits, overflow occurs when we have                  
											-- "1d1d", "11dd" or cout = 1 ( d: don't care). corr = '1' when we have overflow
V <= "0110" when corr = '1' else "0000";						-- and '0' if not.

	U3 : adder_4b port map ( A => V, B => sSUB1, C0 => '0', S4 => sADD, C4 => Cout3);	-- adding correction value of 0110 for addition

V2 <= "1010" when M = '1' else "0000";								-- adding correction value of 1010 for subtraction
	
	U4 : adder_4b port map ( A => V2 , B => sSUB1, C0 => '0', S4 => sSUB2, C4 => Cout4);
	


process (Flag, M, sSUB1, sSUB2, sADD)	-- choosing needed value as the final sum according to inputs
begin				
							
if (Flag = '0') then 

	Sum <= sADD; 
	Cout <= corr;

elsif (Flag = '1') then Cout <= Cout4;

	if (M = '0') then 
		Sum <= sSUB1;
	else
		Sum <= sSUB2;
	end if;

end if;
end process;


end DIGITADD;












