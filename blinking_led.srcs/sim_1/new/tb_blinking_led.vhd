----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2026 01:34:51 AM
-- Design Name: 
-- Module Name: tb_blinking_led - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_blinking_led is
end tb_blinking_led;

architecture Behavioral of tb_blinking_led is
    component blinking_led is 
   generic (
    CLK_CYCLES_PER_TOGGLE: natural := 62500000
   );
   
  Port (
    sys_clk : in STD_LOGIC;
    rst: in STD_LOGIC;
    led_en : in STD_LOGIC;
    led_out : out STD_LOGIC := '0'
   );
    end component;
    
    constant CLK_CYCLES : natural := 10;
    constant CLK_PERIOD : time := 10ns;
    signal sys_clk : STD_LOGIC := '1';
    signal led_en, rst, led_out : STD_LOGIC := '0';
    
    begin
        
        clk:process
        begin
            sys_clk <= '0';
            wait for CLK_PERIOD/2;
            sys_clk <= '1';
            wait for CLK_PERIOD/2;
        end process;
        
        DUT : blinking_led 
        generic map(CLK_CYCLES_PER_TOGGLE => CLK_CYCLES)
        port map( sys_clk => sys_clk, rst => rst, led_en => led_en, led_out => led_out);
        
        test: process
        begin   
            rst <= '1';
            wait for 4*CLK_PERIOD;
            rst <= '0';
            led_en <= '1';
            wait for 2*CLK_PERIOD;
            
            rst <= '1'; --TEST CASE 1
            led_en <= '0';
            wait for 4*CLK_PERIOD;
            
            rst <= '0'; --TEST CASE 2
            led_en <= '0';
            wait for 4*CLK_PERIOD;
            
            
            
            rst <= '0';
            led_en <= '1';
            wait;
        end process;
        

end Behavioral;
