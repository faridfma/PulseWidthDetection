--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
--Date        : Wed Apr 19 16:55:55 2023
--Host        : DVANOFFICE-071 running 64-bit major release  (build 9200)
--Command     : generate_target BlockDesignArtyS7_wrapper.bd
--Design      : BlockDesignArtyS7_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity BlockDesignArtyS7_wrapper is
  port (
    CLK100MHZ : in STD_LOGIC;
    led : out STD_LOGIC_VECTOR ( 2 downto 0 );
    ledd : out STD_LOGIC;
    pulse : in STD_LOGIC;
    reset_n : in STD_LOGIC;
    uart_rxd_out : in STD_LOGIC;
    uart_txd_in : out STD_LOGIC
  );
end BlockDesignArtyS7_wrapper;

architecture STRUCTURE of BlockDesignArtyS7_wrapper is
  component BlockDesignArtyS7 is
  port (
    CLK100MHZ : in STD_LOGIC;
    reset_n : in STD_LOGIC;
    uart_rxd_out : in STD_LOGIC;
    uart_txd_in : out STD_LOGIC;
    pulse : in STD_LOGIC;
    led : out STD_LOGIC_VECTOR ( 2 downto 0 );
    ledd : out STD_LOGIC
  );
  end component BlockDesignArtyS7;
begin
BlockDesignArtyS7_i: component BlockDesignArtyS7
     port map (
      CLK100MHZ => CLK100MHZ,
      led(2 downto 0) => led(2 downto 0),
      ledd => ledd,
      pulse => pulse,
      reset_n => reset_n,
      uart_rxd_out => uart_rxd_out,
      uart_txd_in => uart_txd_in
    );
end STRUCTURE;
