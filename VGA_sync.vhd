----------------------------------------------------------------------------------
-- 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity VGA_sync is
	generic(
		count_h : integer := 800;
		count_v : integer := 525
	);

	port(
		clk : in std_logic; -- 25 MHz
		HSync, VSync : out std_logic;
		Red, Green : out std_logic_vector(2 downto 0);
		Blue : out std_logic_vector(2 downto 1)
	);
end VGA_sync;

architecture Behavioral of VGA_sync is
	signal columna : integer range 0 to count_h - 1;
	signal linea : integer range 0 to count_v - 1;
begin
	process (clk)
	begin
		if (rising_edge(clk)) then
			-- Hsync signal
			if (columna >= 96) then
				HSync <= '1';
			else
				HSync <= '0';
			end if;
			-- Vsync signal
			if (linea >= 2) then
				VSync <= '1';
			else
				VSync <= '0';
			end if;
			-- Frame 0 - 799 (horizontal) 0 - 524 (vertical)
			if (columna = 799) then
				columna <= 0;
				linea <= linea + 1;
				if (linea = 524) then
					linea <= 0;
				end if;
			else
				columna <= columna + 1;
			end if;
			-- Imagen (parte visible del frame)
			if (linea >= 100) and (linea <= 200) and (columna >= 150) and (columna <= 250) then
				Red <= "110";
				Green <= (others => '0');
				Blue <= "00";
			else
				Red <= (others => '0');
				Green <= (others => '0');
				Blue <= (others => '0');
			end if;
		end if;
	end process;

end Behavioral;

