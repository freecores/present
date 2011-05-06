--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:11:33 05/16/2010
-- Design Name:   
-- Module Name:   C:/Users/gajos/Desktop/Polibuda/vhdl/projekt/szyfrator/sLayerTB.vhd
-- Project Name:  szyfrator
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: slayer
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY sLayerTB IS
END sLayerTB;
 
ARCHITECTURE behavior OF sLayerTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT slayer
    PORT(
         input : IN  std_logic_vector(3 downto 0);
         output : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

	--BiDirs
   signal input : std_logic_vector(3 downto 0);
   signal output : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: slayer PORT MAP (
          input => input,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100ms.
		reset <= '1';
      wait for 100ns;	
		reset <= '0';
      wait for clk_period;
		input <= x"0";
      wait for clk_period;
		input <= x"A";
      wait for clk_period;
		input <= x"F";
      wait for clk_period;
      -- insert stimulus here 
		assert false severity failure;
   end process;

END;