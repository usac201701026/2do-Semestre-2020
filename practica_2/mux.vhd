----------------------------------------------------------------------------------

--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux is
port(
--	sel : in std_logic;
	data_1, data_2 : in std_logic_vector(7 downto 0);
	led : out std_logic_vector(7 downto 0);
	sw_1, sw_2 : in std_logic
	
);
end mux;

architecture Behavioral of mux is
begin
	-- select = 0 dejo pasar data 1 a led
	-- si selec = 1 dejo pasar data_2 a led
	led <= data_1 when sw_1 = '0' else 
			 data_2 when sw_2 = '0' else 
			 "11111111" when sw_1 = '1' and sw_2 = '1';			 
end Behavioral;