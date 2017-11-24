library ieee;
use ieee.std_logic_1164.all;

entity decimal3_to_bcd4 is
	port (
		dc : in integer;
		bcd: out std_logic_vector(11 downto 0);
		a0,a1,a2: out integer
);
end decimal3_to_bcd4;
---------------------------------------------------------------------------------------
architecture decimal3_to_bcd4_arch of decimal3_to_bcd4 is
---------------------------------------------------------------------------------------
function CONV_STD_LOGIC_VECTOR(arg: integer; size: integer)
	return std_logic_vector is
	variable result : std_logic_vector (size-1 downto 0);
	variable temp : integer;
	
begin
	temp := arg;
	for k in 0 to size-1 loop
	if (temp mod 2) = 1 then
		result(k) := '1';
	else 
		result(k) := '0';
	end if;
	temp := temp/2;
	end loop;
	return result;
end;
-------------------------------------------------------------------------------------------
signal a : std_logic_vector(11 downto 0);
signal s0,s1,s2 : integer;
--------------------------------------------------------------------------------------------
component decimal_to_digits is
	port(
		D: in integer;
		x0: out integer;
		x1: out integer;
		x2: out integer
);
end component;

BEGIN

U1: decimal_to_digits port map ( D => dc, x0 => s0, x1 => s1, x2 => s2);

process(a,s0,s1,s2)
begin

a(3 downto 0) <= CONV_STD_LOGIC_VECTOR(s0, 4);
a(7 downto 4) <= CONV_STD_LOGIC_VECTOR(s1, 4);
a(11 downto 8) <= CONV_STD_LOGIC_VECTOR(s2, 4);

end process;
----------------------------------------------------------------------------------------
bcd <= a;
a0 <= s0;
a1 <= s1;
a2 <= s2;

--------------------------------------------------------------------------------------------

end decimal3_to_bcd4_arch;






