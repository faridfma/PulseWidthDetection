library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PulseDetect is
  port(
    clk : in std_logic; 
    reset_n : in std_logic; 
    pulse   : in std_logic; 
    pulseCnt : out std_logic_vector(31 downto 0); 
    TestValue : out std_logic_vector(31 downto 0); 
    led_0     : out std_logic
  );
end PulseDetect;

architecture RTL of PulseDetect is
--signals
signal PulseValue    : std_logic; 
signal pulseCntSig   : std_logic_vector(31 downto 0);

begin

 PulseWidthProc: process(clk, reset_n)
 variable counter: integer:=0; 
 begin
 if reset_n = '0' then
     PulseValue <=  '0'; 
  elsif rising_edge(clk) then
     if(pulse = '1') then
       pulseCntSig <= pulseCntSig + 1; 
       PulseValue <= '1'; 
      else
       PulseValue <= '0';
       pulseCntSig <= (others=>'0');
      end if; 
 end if; 
 end process PulseWidthProc; 
 
pulseCnt <= pulseCntSig; 
led_0 <= PulseValue; 
TestValue <="00000000000000000000000000000111"



end RTL ;