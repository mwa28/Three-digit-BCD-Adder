library ieee;
use ieee.std_logic_1164.all;

entity two_compl is
	port(
		X: in std_logic_vector (3 downto 0);
		F: in std_logic;
		Y: out std_logic_vector (3 downto 0)
);
end two_compl;

architecture two_compl_arch of two_compl is
signal n: std_logic := '0';
signal temp, inv ,ad, temp2 : std_logic_vector (3 downto 0);

component adder_4b is
port(
	A: in std_logic_vector(3 downto 0);
	B: in std_logic_vector(3 downto 0);
	C0: in std_logic;
	S4: out std_logic_vector(3 downto 0);
	C4: out std_logic
);
end component;

BEGIN

ad <= "0001" when F = '1' else "0000";

process (X, ad, temp)
begin
temp <= X;
inv <= NOT X;
end process;

U1: adder_4b port map ( A => inv, B => ad, C0 => '0', S4 => temp2, C4 => n);

Y <= temp when F = '0' else temp2;

end two_compl_arch;

