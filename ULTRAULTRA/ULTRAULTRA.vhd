-------Cancha de Basket, USAC, Electronica 3--------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ULTRAULTRA is
Generic(
	Resolucion: Integer  := 240000	
);
Port(
clk: in 		std_logic;
X: in std_logic;
trigger,trigger2: out 	std_logic;
echo,echo2: in 	std_logic;
distancia: out	std_logic_vector(7 downto 0);
Display: out std_logic_vector(7 downto 0);
Enable: out std_logic_vector(2 downto 0);
PWM:	out	Std_Logic 
);
end ULTRAULTRA;

architecture Behavioral of ULTRAULTRA is

signal tiempo_alto, muestra, temp, uni, dec, bandera, L: integer; ----Señal encargada de medir el tiempo que echo se mantiene en alto
signal Tt: integer range 0 to Resolucion-1;
begin

process(clk)
 ------Habilitadores--------
variable cont1,cont2,tiempoA: 	integer:=0;
variable y:		std_logic:='1'; 
begin
   if rising_edge(clk) then
-------Envio de Pulso Trigger--------
        if(cont1=0) then
            trigger<='1';
        elsif(cont1=500) then--100us
            trigger<='0';
            y:='1';
        elsif(cont1=5000000) then-- 100 ms
            cont1:=0;
            trigger<='1';
        end if;
        cont1:=cont1+1;
--------Lectura Echo -------------
        if(echo = '1') then
            cont2:=cont2+1;
        elsif(echo = '0' and y='1' ) then
            tiempo_alto<= cont2;
            cont2:=0;
            y:='0';
        end if;
-----Segun lo calculado cada 25000 de tiempo en alto son 5cm, pero creo que esta mal-------
		 
			if(tiempo_alto < 5000) then--5 cm
            distancia<="00000001";
				Uni<=5;
				dec<=0;
				L<=7;
				
			elsif(tiempo_alto > 5000 and tiempo_alto < 10000)then--10 cm
            distancia<="00000011";
				Uni<=0;
				dec<=1;
				L<=7;
				
			elsif(tiempo_alto > 10000 and tiempo_alto < 15000)then--15 cm
            distancia<="00000111";
				Uni<=5;
				dec<=1;
				L<=7;
				
			elsif(tiempo_alto > 15000 and tiempo_alto < 20000)then--20 cm
            distancia<="00001111";
				Uni<=0;
				dec<=2;
				L<=7;
				
			elsif(tiempo_alto > 20000 and tiempo_alto < 25000)then--25 cm
            distancia<="00011111";
				Uni<=5;
				dec<=2;
				L<=7;
				
			elsif(tiempo_alto > 25000 and tiempo_alto < 30000)then--30 cm
            distancia<="00111111";
				Uni<=0;
				dec<=3;
				L<=7;
	
			elsif(tiempo_alto > 30000 and tiempo_alto < 35000)then--35 cm
            distancia<="01111111";
				Uni<=5;
				dec<=3;
				L<=7;
				
				elsif(tiempo_alto > 35000 and tiempo_alto < 40000)then--40 cm
            distancia<="11111111";
				Uni<=0;
				dec<=4;
				L<=7;
				
			else-- Distancias muy largas
            distancia<="00000000";
				Uni<=6;
				dec<=6;
				L<=0;
					
		  end if; 
			if temp=90 then
				temp<=0;
				if bandera=2 then
					bandera<=0;
				else
					bandera<=bandera+1;
				end if;
				if bandera=0 then
					Enable<="101";
				end if;
				if bandera=1 then
					Enable<="011";
				end if;
				if bandera=2 then
					Enable<="110";
				end if;
			else
				temp<=temp+1;
			end if;
			if bandera=0 then
				muestra<=uni;
			elsif bandera=1 then
				muestra<=dec;
			elsif bandera=2 then
				muestra<=L;
			else
				muestra<=0;
			end if;
			if muestra=0 then
				Display<="00000011";
			end if;
			if muestra=1 then
				Display<="10011111";
			end if;
			if muestra=2 then 
				Display<="00100101";
			end if;
			if muestra=3 then 
				Display<="00001101";
			end if;
			if muestra=4 then
				Display<="10011001";
			end if;
			if muestra=5 then 
				Display<="01001001";
			end if;
			if muestra=6 then 
				Display<="01110001";
			end if;
			if muestra=7 then 
				Display<="11100011";
			end if;

			
end if; 
end process ;

end Behavioral;