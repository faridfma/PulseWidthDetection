 library IEEE;
 use IEEE.STD_LOGIC_1164.ALL;
 use IEEE.numeric_std.all;
 
 entity GPIOs is
   Port ( 
   CLK   : in  std_logic;
   reset_n     : in std_logic; 
   led         : out std_logic_vector (2 downto 0)                          
    );
 end GPIOs;
 
 architecture RTL of GPIOs is
 
 constant max_count : natural := 100000000; --500 ms delay
 
 signal LED1_Sig    : std_logic; 
 signal LED2_Sig    : std_logic; 
 signal LED3_Sig    : std_logic;  
 signal LED4_Sig    : std_logic;
 
 begin
    counter: process(CLK, reset_n)
        variable count : natural range 0 to max_count;
    begin
        if reset_n = '0' then
            count := 0;
            LED1_Sig <= '0';
            LED2_Sig <= '0';
            LED3_Sig <= '0';
           -- LED4_Sig <= '0';
            
        elsif rising_edge(CLK) then
            if count = max_count then
                count := 0;
                LED1_Sig <= NOT LED1_Sig;
                LED2_Sig <= NOT LED2_Sig;
                LED3_Sig <= NOT LED3_Sig;
             --   LED4_Sig <= NOT LED4_Sig;
            else
                count:= count+1;       
            end if;
            
--            if(pulse ='1') then 
--            LED4_Sig <= '1';
--            else
--            LED4_Sig <= '0'; 
--            end if; 
            
        end if;
    end process counter; 

    led(0) <= LED1_Sig;
    led(1) <= LED2_Sig;
    led(2) <= LED3_Sig;
   -- led(3) <= LED4_Sig;
    
   
 end RTL;
