----------------------------------------------------------------------------------

--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_clase is
	generic(
		count_h : integer := 800  ;
		count_v : integer := 525 
	);

	port(
	clk : in std_logic; --25Mhz
	HSync, VSync: out std_logic;
	Red, Green: out std_logic_vector(2 downto 0);
	Blue: out std_logic_vector(2 downto 1)
	);
	

end VGA_clase;

architecture Behavioral of VGA_clase is
	signal linea : integer range 0 to count_h - 1;
	signal columna : integer range 0 to count_v - 1;
begin
	process (clk)
	begin
		if (rising_edge(clk)) then
		--Contar la pantalla de 0 a 799 Horizontal
		--Contar la pantalla de 0 a 524 vertical
			if(linea = count_h - 1)then   --799 -1
				linea <= 0;
				columna <= columna + 1;
				if(columna = count_v -1)then --524-1
					columna <= 0;
				end if;
			else 
				linea <= linea +1;			
			end if;
		
		-- Hsync signal 
		if (linea >= 96)then  --96 se puede poner en generic
			HSync <= '1';
		else 
			HSync <= '0';
		end if;
		
		-- Vsync Signal
		if (columna >= 2)then
			VSync <= '1';
		else 
			VSync <= '0';
		end if;		
		
		-- Imagen(parte visible)
			--Rectangulo color rojo
		if (columna >= 200) and (columna <= 600) and (linea >= 150) and (linea <= 250) then 
			Red <= "110" ;
			Green <= (others => '0') ;
			Blue <= "00";
		else 
			Red <= (others => '0') ;
			Green <= (others => '0');
			Blue <= (others => '0');		
		end if;
		
		end if;
	end process;

end Behavioral;

