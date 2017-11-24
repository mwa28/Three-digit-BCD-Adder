library ieee;
use ieee.std_logic_1164.all;

entity decimal_to_digits is
	port(
		D: in integer;
		x0: out integer;
		x1: out integer;
		x2: out integer
);
end decimal_to_digits;

architecture decimal_to_digits_arch of decimal_to_digits is

signal X: integer;

BEGIN

comp : process(X,D)
	
begin
	X <= abs(D);
	x2 <= ((X-(X mod 100))/100);
	x1 <= (((X mod 100) - (X mod 10))/10);
	x0 <= (X mod 10);

end process comp;

end decimal_to_digits_arch;
