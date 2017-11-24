library ieee;
use ieee.std_logic_1164.all;

entity BCD_to_Decimal is
	port (
		bcdA: in std_logic_vector(12 downto 0);
		dec : out integer
	);
end BCD_to_Decimal;

architecture BCD_to_Decimal_arch of BCD_to_Decimal is

function CONV_INTEGER (X:std_logic_vector) return integer is
	variable result, p: integer;
begin
	result := 0;
	for p in X'range loop
		result := result*2;
		case X(p) is
			when '0' | 'L' => null;
			when '1' | 'H' => result := result + 1;
			when others => null;
		end case;
	end loop;
	return result;
end;

signal dec0,dec1,dec2,mag: integer;

BEGIN

dec0 <= CONV_INTEGER (bcdA(3 downto 0));
dec1 <= CONV_INTEGER (bcdA(7 downto 4));
dec2 <= CONV_INTEGER (bcdA(11 downto 8));

mag <= dec0 + (dec1 *10) + (dec2 *100);

process(mag,bcdA)
begin
if (bcdA(12) = '1') then dec <= -(mag);
else dec <= mag;
end if;	
end process;

end BCD_to_Decimal_arch;

