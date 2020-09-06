----------------------------------------------------------------------------------

--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity display is
    Port ( Clk : in  STD_LOGIC;
          Enable : out  STD_LOGIC;
          Display : out  STD_LOGIC_VECTOR (7 downto 0);
           b : in  STD_LOGIC);
end display;

architecture Behavioral of display is
begin
Enable <= '0';
process( b)
begin
if(rising_edge(Clk))then
	if(b='0')then
		Display <= "11111001";
		else 
		Display <= "10100100";
	end if;
end if;
end process;
end Behavioral;

