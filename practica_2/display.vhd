----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:38:37 09/05/2020 

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity display is
port(
	sele : in std_logic;
	CAR : out std_logic_vector(6 downto 0);
	disp : out std_logic_vector(2 downto 0)
--	sw_1, sw_2 : in std_logic
	
);
end display;

architecture Behavioral of display is

begin
	-- select = 0 dejo pasar data 1 a led
	-- si selec = 1 dejo pasar data_2 a led
process(sele)
	begin 
	if sele = '1' then
		CAR <= "1001111";
		disp <= "000";
	else 
		CAR <= "1001111";
		disp <= "000";
	end if;
end process;
		
	


end Behavioral;

