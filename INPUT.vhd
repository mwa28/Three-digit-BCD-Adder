library ieee;
use ieee.std_logic_1164.all;

entity INPUT is
	port ( i1, i2: in integer;
		CLK: in std_logic;
		bcdf: out std_logic_vector(3 downto 0);
		x0,x1,x2,y0,y1,y2: out integer
);
end INPUT;

architecture input_arch of INPUT is

component decimal3_to_bcd4 is
	port (
		dc : in integer;
		bcd:out std_logic_vector(11 downto 0);
		a0,a1,a2: out integer
);
end component;

component pipo is
 port(
 clk : in std_logic;
 D: in std_logic_vector(3 downto 0);
 Q: out std_logic_vector(3 downto 0)
 );
end component;

signal shifter: std_logic_vector(23 downto 0);

begin


U1: decimal3_to_bcd4 port map(dc => i1, bcd => shifter(11 downto 0), a0 => x0, a1 => x1, a2 => x2);	-- converting to BCD
U2: decimal3_to_bcd4 port map(dc => i2, bcd => shifter(23 downto 12), a0 => y0, a1 => y1, a2 => y2);


end input_arch;


