library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PulseTest is
  port(
    clk600MHz : in std_logic; 
    reset_n : in std_logic; 
    pulse   : in std_logic; 
    led_0     : out std_logic
  );
end PulseTest ;

architecture RTL of PulseTest is

--signals
signal PulseValue    : std_logic; 

begin

 PulseWidthProc: process(clk600MHz, reset_n)
 variable counter: integer:=0; 
 begin
 if reset_n = '0' then
     PulseValue <=  '0'; 
  elsif rising_edge(clk600MHz) then
       if(pulse = '1') then
       PulseValue <= '1'; 
       else
       PulseValue <= '0';
       end if; 
 end if; 
 end process PulseWidthProc; 
  
led_0 <= '1'; --PulseValue; 
 
  
end RTL ;