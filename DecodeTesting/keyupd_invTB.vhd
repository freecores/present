--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:00:18 05/16/2010
-- Design Name:   
-- Module Name:   C:/Users/gajos/Desktop/Polibuda/vhdl/projekt/szyfrator/keyupdTB.vhd
-- Project Name:  szyfrator
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: keyupd
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
 
ENTITY keyupd_invTB IS
END keyupd_invTB;
 
ARCHITECTURE behavior OF keyupd_invTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT keyupd_inv
    PORT(
         key : IN  std_logic_vector(79 downto 0);
         num : IN  std_logic_vector(4 downto 0);
         keyout : OUT  std_logic_vector(79 downto 0)--;
			--clk, reset : std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal key : std_logic_vector(79 downto 0) := (others => '0');
   signal num : std_logic_vector(4 downto 0) := (others => '0');
	signal clk : std_logic := '0';
	signal reset : std_logic := '0';

 	--Outputs
   signal keyout : std_logic_vector(79 downto 0);
	
	constant clk_period : time := 1ns;
		
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: keyupd_inv PORT MAP (
          key => key,
          num => num,
          keyout => keyout--,
			 --clk => clk,
			 --reset => reset
        );
 
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
 
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
		reset <='0';
      wait for clk_period;
		key <= "00000000000000000000000000000000000000000000000000000000000000000000000000000000";
		num <= "00001";
		wait for clk_period;
		key <= x"c0000000000000008000";
		num <= "00010";
		wait for clk_period;
		key <= x"50001800000000010000";
		num <= "00011";
		wait for clk_period;
		key <= x"8ba27a0eb8783ac96d59";
		num <= "11111";
		wait for clk_period;
		assert false severity failure;
   end process;
END;