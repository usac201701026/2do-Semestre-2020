library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
	Port(
		--Señales de control; reset y señal de reloj.
		clk:		in		std_logic;
		reset:	in		std_logic;
		--Push boton para el conteo.
		Cont_up:	in		std_logic;
		--Salidas para el control de los Display's.
		Enable:	out	std_logic_vector(2 downto 0);
		Display: out 	std_logic_vector(7 downto 0)
	);
end main;

architecture Behavioral of main is


signal cont_multiplexacion:	integer range 0 to 12000000;
signal estado_enable:	std_logic_vector(2 downto 0);
signal estado_display:	integer range 0 to 9;

signal conteo: integer range 0 to 12000000;
signal flag:	std_logic;

signal unidades:	integer range 0 to 9;
signal decenas:	integer range 0 to 9;
signal centenas:	integer range 0 to 9;

begin
	
	Enable <= estado_enable;

	process(clk, reset)
		begin
		
		if(reset = '0') then
		
			conteo <= 0;
			unidades <= 0;
			decenas <= 0;
			centenas <= 0;
			estado_enable <= "111";
			
		elsif(rising_edge(clk)) then
			
			if(conteo = (10*11999)) then
				conteo <= 0;
				if(Cont_up = '0') then
					flag <= '1';
				end if;
				
				if(Cont_up = '1' and flag = '1') then
					flag <= '0';
					if(unidades <= 8) then
						unidades <= unidades + 1;
					else
						unidades <= 0;					
						if(decenas <= 8) then
							decenas <= decenas + 1;
						else
							decenas <= 0;
							
							if(centenas <= 8) then
								centenas <= centenas + 1;
							else
								unidades <= 0;
								decenas <= 0;
								centenas <= 0;
							end if;
						end if;
					end if;
				end if;
				
			else
				conteo <= conteo + 1;
			end if;
			
			if(cont_multiplexacion = 12000) then
				cont_multiplexacion <= 0;
				if(estado_enable = "110") then
					estado_enable <= "101";
					estado_display <= decenas;
				elsif(estado_enable = "101") then
					estado_enable <= "011";
					estado_display <= centenas;
				elsif(estado_enable = "011") then
					estado_enable <= "110";
					estado_display <= unidades;
				else
					estado_enable <= "110";
				end if;
			else
				cont_multiplexacion <= cont_multiplexacion + 1;
			end if;
			
			case estado_display is
				 when 0 => 
					Display <= "11000000";
				 when 1 => 
					Display <= "11111001";
				 when 2 => 
					Display <= "10100100";
				 when 3 => 
					Display <= "10110000";
				 when 4 => 
					Display <= "10011001";
				 when 5 => 
					Display <= "10010010";
				 when 6 => 
					Display <= "10000010";
				 when 7 => 
					Display <= "11111000";
				 when 8 => 
					Display <= "10000000";
				 when 9 => 
					Display <= "10011000";
				 when others => 
					Display <= "11111111";
			end case;
			
		end if;
	end process;

end Behavioral;