----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:39:23 08/19/2020 
-- Design Name: 
-- Module Name:    led1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
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

entity led1 is
    Port ( Clk : in  STD_LOGIC;
           led : out  STD_LOGIC;
           b : in  STD_LOGIC);
end led1;

architecture Behavioral of led1 is

begin

process(Clk, b)
begin
if(rising_edge(Clk))then
if(b='0')then
led <= '0';
else 
led <= '1';
end if;
end if;
end process;

end Behavioral;

