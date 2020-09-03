----------------------------------------------------------------------------------

--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux is
port(
	sel : in std_logic;
	data_1, data_2 : in std_logic_vector(7 downto 0);
	led : out std_logic_vector(7 downto 0)
	
);
end mux;

architecture Behavioral of mux is
begin
	-- select = 0 dejo pasar data 1 a led
	-- si selec = 1 dejo pasar data_2 a led
	
	led <= data_1 when sel = '0' else 
			 data_2 when sel = '1';


end Behavioral;

