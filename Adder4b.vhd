library ieee;
use ieee.std_logic_1164.all;

entity adder_4b is
port(
	A: in std_logic_vector(3 downto 0);
	B: in std_logic_vector(3 downto 0);
	C0: in std_logic;
	S4: out std_logic_vector(3 downto 0);
	C4: out std_logic);
end adder_4b;

architecture adder_4b of adder_4b is
component full_adder
	port( X1: in std_logic; Y1: in std_logic; CIN1: in std_logic;
		S1: out std_logic; COUT1: out std_logic );
end component;

signal C: std_logic_vector(1 to 3);

begin

U1: full_adder port map (X1=>A(0), Y1=>B(0), CIN1=>C0, S1=>S4(0), COUT1=>C(1));
U2: full_adder port map (X1=>A(1), Y1=>B(1), CIN1=>C(1), S1=>S4(1), COUT1=>C(2));
U3: full_adder port map (X1=>A(2), Y1=>B(2), CIN1=>C(2), S1=>S4(2), COUT1=>C(3));
U4: full_adder port map (X1=>A(3), Y1=>B(3), CIN1=>C(3), S1=>S4(3), COUT1=>C4);

end adder_4b;
