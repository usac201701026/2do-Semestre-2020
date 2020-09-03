----------------------------------------------------------------------------------
-- Este modulo se encarga de conectar el mux con las 2 intancias de uart RX
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity top is
port(
	clk_12 : in std_logic;
	uart_1,uart_2 : in std_logic; --entradas Rx
	rd_1, rd_2 : out std_logic; --salidas read data cada instancia
	sel : std_logic;
	data : out std_logic_vector(7 downto 0)
);
end top;

architecture Behavioral of top is
	signal data_1, data_2 : std_logic_vector(7 downto 0);
begin
-- Primero Etiqueta (obligatoria para crear intancias)
uart_9600:
	entity work.uart_rx
		port map(
			clk => clk_12,
			rx_in => uart_1,
			read_data => rd_1,
			rx_data => data_1
		);


uart_4800:
	entity work.uart_rx
		generic map(
			n_bits  => 8,
			contador_bits => 2500,
			contador_half_bits => 1250  
		)
		port map(
			clk => clk_12,
			rx_in => uart_2,
			read_data => rd_2,
			rx_data => data_2
		); 


mux_1:
	entity work.mux 
		port map(
		sel => sel,
		data_1 => data_1,
		data_2 => data_2,
		led => data
		);


end Behavioral;

