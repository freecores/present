--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:12:57 07/14/2013
-- Design Name:   
-- Module Name:   E:/spent i praca/OpenCores/present_opencores/trunk/Decode/PresentFullDecoderTB.vhd
-- Project Name:  PresentDecode
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PresentFullDecoder
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
 
ENTITY PresentFullDecoderTB IS
END PresentFullDecoderTB;
 
ARCHITECTURE behavior OF PresentFullDecoderTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PresentFullDecoder
    PORT(
         ciphertext : IN  std_logic_vector(63 downto 0);
         key : IN  std_logic_vector(79 downto 0);
         plaintext : OUT  std_logic_vector(63 downto 0);
         start : IN  std_logic;
         clk : IN  std_logic;
         reset : IN  std_logic;
         ready : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ciphertext : std_logic_vector(63 downto 0) := (others => '0');
   signal key : std_logic_vector(79 downto 0) := (others => '0');
   signal start : std_logic := '0';
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal plaintext : std_logic_vector(63 downto 0);
   signal ready : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PresentFullDecoder PORT MAP (
          ciphertext => ciphertext,
          key => key,
          plaintext => plaintext,
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
		ciphertext <= x"5579c1387b228445";
		key <= (others => '0');
		wait for 100 ns;	
		reset <= '0';
		
		ciphertext <= x"5579c1387b228445";
		key <= (others => '0');
		start <= '1';
      wait for clk_period*80;
		start <= '0';
		wait for clk_period;
		
		ciphertext <= x"e72c46c0f5945049";
		key <= (others => '1');
		start <= '1';
      wait for clk_period*80;
		start <= '0';
		wait for clk_period;
		
		ciphertext <= x"a112ffc72f68417b";
		key <= (others => '0');
		start <= '1';
      wait for clk_period*80;
		start <= '0';
		wait for clk_period;
		
		ciphertext <= x"3333dcd3213210d2";
		key <= (others => '1');
		start <= '1';
      wait for clk_period*80;
		start <= '0';
		wait for clk_period;
		
		assert false severity failure;

   end process;

END;
