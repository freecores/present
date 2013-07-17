--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:21:14 06/25/2013
-- Design Name:   
-- Module Name:   E:/spent i praca/OpenCores/present_opencores/trunk/Pure/PresentTB.vhd
-- Project Name:  Present_Pure
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PresentEnc
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY PresentKeyGenTB IS
END PresentKeyGenTB;
 
ARCHITECTURE behavior OF PresentKeyGenTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PresentEncKeyGen
    PORT(
         key : IN  std_logic_vector(79 downto 0);
         key_end : OUT  std_logic_vector(79 downto 0);
         start : IN  std_logic;
         clk : IN  std_logic;
         reset : IN  std_logic;
         ready : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal key : std_logic_vector(79 downto 0) := (others => '0');
   signal start : std_logic := '0';
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal key_end : std_logic_vector(79 downto 0);
   signal ready : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PresentEncKeyGen PORT MAP (
          key => key,
			 key_end => key_end,
          start => start,
          clk => clk,
          reset => reset,
          ready => ready
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

		reset <= '1';
      start <= '0';
		wait for 100 ns;	
		reset <= '0';
		
		key <= (others => '0');
		start <= '1';
      wait for clk_period*40;
		start <= '0';
		wait for clk_period;
		
		key <= (others => '1');
		start <= '1';
      wait for clk_period*40;
		start <= '0';
		wait for clk_period;
		
		key <= (others => '0');
		start <= '1';
      wait for clk_period*40;
		start <= '0';
		wait for clk_period;
		
		key <= (others => '1');
		start <= '1';
      wait for clk_period*40;
		start <= '0';
		wait for clk_period;
		
		assert false severity failure;

   end process;

END;
