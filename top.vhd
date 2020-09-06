----------------------------------------------------------------------------------
--Este modulo se encarga de conectar el mux con las 2 intancias de uart RX
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity top is
port(
	clk_12 : in std_logic;
--	uart_1,uart_2 : in std_logic; --entradas Rx
	rd_1, rd_2 : out std_logic; --salidas read data cada instancia
	sel : std_logic;
	data : out std_logic_vector(7 downto 0);
	
	sw1,sw2 : in std_logic;
	bytes :  in  std_logic_vector(7 downto 0); 
--	tx_1,tx_2 : out std_logic

	CAR : out std_logic_vector(6 downto 0);
	display : out std_logic_vector(2 downto 0)

);
end top;

architecture Behavioral of top is
	signal data_1, data_2 : std_logic_vector(7 downto 0);
	signal tx1, tx2 : std_logic;
begin
-- Primero Etiqueta (obligatoria para crear intancias)
RX_1:
	entity work.uart_rx
		generic map(
			n_bits  => 8,
			contador_bits => 312,
			contador_half_bits => 156  
		)
		port map(
			clk => clk_12,
			rx_in => tx1,
			read_data => rd_1,
			rx_data => data_1
		);


RX_2:
	entity work.uart_rx
		generic map(
			n_bits  => 8,
			contador_bits => 625,
			contador_half_bits => 325  
		)
		port map(
			clk => clk_12,
			rx_in => tx2,
			read_data => rd_2,
			rx_data => data_2
		);

TXX_1:
	entity work.uart_tx
		generic map(
			Clk_X_Bit => 312  )   -- 12MHz/38400 baud Rate
		port map(
			Clk => clk_12,
			Start_Switch => sw1,
			Bytes => bytes,
			U_Tx => tx1
		); 
			
TXX_2:
	entity work.uart_tx
		generic map( Clk_X_Bit => 625 )   -- 12MHz/19200 baud Rate
		port map(
			Clk => clk_12,
			Start_Switch => sw2,
			Bytes => bytes,
			U_Tx => tx2
			
			); 

MUX_1:
	entity work.mux 
		port map(
--		sel => sel,
		sw_1 => sw1,
		sw_2 => sw2,
		data_1 => data_1,
		data_2 => data_2,
		led => data
		);

CONTROL_DISPLAY_1:
	entity work.display 
		port map(
		sele => sel,
	--	sw_1 => sw1,
	--	sw_2 => sw2,
		CAR  => CAR,
		disp  => display		
		);


end Behavioral;
