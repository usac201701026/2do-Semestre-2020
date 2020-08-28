----------------------------------------------------------------------------------
-- PRACTICA-01     
-- UART_TX
-- Autor: GRUPO_A_02
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity UART_TX is
  generic (
    Clk_X_Bit : integer := 104     -- 12MHz/115200 baud Rate
    );
  port (
    Clk       : in  std_logic;
    Start_Switch     : in  std_logic;
    Bytes   : in  std_logic_vector(7 downto 0);
    U_Tx : out std_logic
    );
end UART_TX;
 
 
architecture Behavioral of UART_TX is
 
  type fsm is (Idle, Start, Data, Stop);
  signal estado : fsm := Idle;
  signal Cont_Clk : integer range 0 to Clk_X_Bit-1 := 0;
  signal Indice : integer range 0 to 7 := 0;  
  signal Datos_TX   : std_logic_vector(7 downto 0) := (others => '0');
   
begin
 
   
process (Clk)
  begin
    if rising_edge(Clk) then
         
      case estado is
 
        when Idle =>
          U_Tx <= '1'; 
          Cont_Clk <= 0;
          Indice <= 0;
 
          if Start_Switch = '0' then
            Datos_TX <= Bytes;
            estado <= Start;
          else
            estado <= Idle;
          end if;
 
        when Start =>
          U_Tx <= '0';

          if Cont_Clk < Clk_X_Bit-1 then
            Cont_Clk <= Cont_Clk + 1;
            estado   <= Start;
          else
            Cont_Clk <= 0;
            estado   <= Data;
          end if;
 
                   
        when Data =>
          U_Tx <= Datos_TX(Indice);
           
          if Cont_Clk < Clk_X_Bit-1 then
            Cont_Clk <= Cont_Clk + 1;
            estado   <= Data;
          else
            Cont_Clk <= 0;
             
            if Indice < 7 then
              Indice <= Indice + 1;
              estado   <= Data;
            else
              Indice <= 0;
              estado   <= Stop;
            end if;
          end if;
 
        when Stop =>
          U_Tx <= '1';
          if Cont_Clk < Clk_X_Bit-1 then
            Cont_Clk <= Cont_Clk + 1;
            estado   <= Stop;
          else
            Cont_Clk <= 0;
				estado   <= Idle;
          end if;
          
        when others =>
          estado <= Idle;
 
      end case;
    end if;
  end process;   
end Behavioral;