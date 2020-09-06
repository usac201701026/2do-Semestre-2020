library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cronometro is
	Port(
		--Señales de control; reset y señal de reloj.
		clk:		in		std_logic;
		reset:	in		std_logic;
		--Push boton para el conteo.
		push_1:	in		std_logic;
		push_2:	in		std_logic;
		--Salidas para el control de los Display's.
		Enable:	out	std_logic_vector(2 downto 0);
		Display: out 	std_logic_vector(7 downto 0)
	);
end cronometro;

architecture Behavioral of cronometro is


signal cont_multiplexacion:	integer range 0 to 12000000;
signal estado_enable:	std_logic_vector(2 downto 0);
signal estado_display:	integer range 0 to 9;

signal conteo: integer range 0 to 12000000;
signal flag:	std_logic;
signal señal:	std_logic;

signal seg:		integer range 0 to 9;
signal decseg:	integer range 0 to 9;
signal min:		integer range 0 to 9;

begin
	
	Enable <= estado_enable;
process(clk, reset)
		begin
		if(reset = '0') then
			conteo <= 0;
			seg <= 4;
			decseg <= 0;
			min <= 0;
			estado_enable <= "000";		
			flag <= '0';
			señal <= '0';
		elsif(rising_edge(clk)) then
			if (señal ='1')	then
				if (push_1 = '0') then
					flag <= '1';
					señal <= '0';
			end if;	
				if (push_2 = '0') then
					flag <= '0';
					señal <= '0';
				end if;	
			end if;	
			if (señal ='0')	then
				if (push_1 = '0') then
					flag <= '0';
					señal <= '1';
				end if;	
				if (push_2 = '0') then
					flag <= '1';
					señal <= '1';
				end if;	
			end if;				

			if(conteo = (3000000)) then
				conteo <= 0;
				if((push_1 = '1' or push_2 = '1' ) and flag = '0') then
					if(seg <= 8) then
						seg <= seg + 1;
					else
						seg <= 0;					
						if(decseg <= 4) then
							decseg <= decseg + 1;
						else
							decseg <= 0;							
							if(min <= 8) then
								min <= min + 1;
							else
								seg <= 0;
								decseg <= 0;
								min <= 0;
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
					estado_display <= decseg;
				elsif(estado_enable = "101") then
					estado_enable <= "011";
					estado_display <= min;
				elsif(estado_enable = "011") then
					estado_enable <= "110";
					estado_display <= seg;
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
					Display <= "10010000";
				 when others => 
					Display <= "11111111";
			end case;
			
		end if;
	end process;

end Behavioral;