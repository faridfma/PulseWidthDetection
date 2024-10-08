library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PulseDetect is
  port(
    clk600MHz : in std_logic; 
    clk : in std_logic; 
    reset_n : in std_logic; 
    pulse   : in std_logic; 
    pulseCnt : out std_logic_vector(31 downto 0); 
    DataRequest : in std_logic_vector(31 downto 0);
    DebugPort : out std_logic_vector(31 downto 0);
    DataReady : out std_logic_vector(31 downto 0); 
    
    led_0     : out std_logic
  );
end PulseDetect;

architecture RTL of PulseDetect is


--signals
signal PulseValue    : std_logic; 
signal pulseCntSig   : std_logic_vector(31 downto 0);

signal datarequestbit : std_logic; 
signal DataReadySig : std_logic_vector(31 downto 0); 

signal Pulse_Dly0 : std_logic; 
signal Pulse_Dly1 : std_logic; 
signal PulseFallinEdge : std_logic; 
signal pulse_generated : std_logic; 
--signal fallingEdgePulse : std_logic; 

signal flag: std_logic; 
signal flagDly: std_logic;

signal RisingEdgePulse: std_logic;
signal FallingEdgePulse: std_logic;


begin


RisingEdgeDetect : process(clk600MHz, reset_n)
begin
  if(reset_n= '0') then
    Pulse_Dly0 <='0';       
    Pulse_Dly1 <='0';
  elsif rising_edge(clk600MHz) then
     Pulse_Dly0 <= pulse;
     Pulse_Dly1 <= Pulse_Dly0;
  end if;
end process RisingEdgeDetect;

RisingEdgePulse             <=  NOT  Pulse_Dly1 AND  Pulse_Dly0; 
FallingEdgePulse            <=  NOT  Pulse_Dly0 AND Pulse_Dly1; 

--/////////////////////////////////////////////////////////////////////

PulseWidthProc: process(clk600MHz, reset_n)
 variable counter: integer:=0; 
 begin
 if reset_n = '0' then
     pulseCntSig <=  (others=>'0'); 
 elsif rising_edge(clk600MHz) then
       if(RisingEdgePulse = '1') then
          pulseCntSig <= (others => '0');
       elsif ((RisingEdgePulse = '0') AND (Pulse ='1'))then
         pulseCntSig <= pulseCntSig + 1;
       elsif (FallingEdgePulse = '1')then
         pulseCnt <= pulseCntSig +1;
      end if;   
 end if; 
 end process PulseWidthProc; 

 --////////////////////////////////////////////
 LedProc: process(clk600MHz, reset_n)
 begin
 if reset_n = '0' then
      led_0 <=  '0'; 
  elsif rising_edge(clk600MHz) then
       if(pulse = '1')then
         led_0 <= '1'; 
       else
         led_0 <= '0';
       end if; 
 end if; 
 end process  LedProc;
 
 
end RTL ;