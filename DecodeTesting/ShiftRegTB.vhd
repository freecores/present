--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:11:18 10/08/2012
-- Design Name:   
-- Module Name:   E:/spent i praca/OpenCores/mRSAKeyFinalizer/ShiftRegTB.vhd
-- Project Name:  mRSAKeyFinalizer
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ShiftReg
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
use work.RSAFinalizerProperties.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ShiftRegTB IS
END ShiftRegTB;
 
ARCHITECTURE behavior OF ShiftRegTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ShiftReg
--	 generic (length_1      : integer :=  WORD_LENGTH;
--	          length_2      : integer :=  BYTE
	 GENERIC (
	     length_1      : integer :=  BYTE;
	     length_2      : integer :=  WORD_LENGTH
	 );
    PORT(
        input  : in  STD_LOGIC_VECTOR(7 downto 0);
		  --input : IN  std_logic_vector(63 downto 0);
        output : out STD_LOGIC_VECTOR(63 downto 0);
		  --output : OUT  std_logic_vector(7 downto 0);
        en     : in  STD_LOGIC;
        shift  : in  STD_LOGIC;
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC
    );
    END COMPONENT;
    

   --Inputs
   signal input : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	--signal input : std_logic_vector(63 downto 0) := (others => '0');
   signal en    : STD_LOGIC := '0';
   signal shift : STD_LOGIC := '0';
   signal clk   : STD_LOGIC := '0';
   signal reset : STD_LOGIC := '0';

 	--Outputs
   signal output : STD_LOGIC_VECTOR(63 downto 0);
	--signal output : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ShiftReg PORT MAP (
          input => input,
          output => output,
          en => en,
          shift => shift,
          clk => clk,
          reset => reset
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
      reset <= '0';
		shift <= '0';
		input <= "10101010";
		--input <= "1111000011110000111100001111000011110000111100001111000011110000";
      wait for 100 ns;	
		reset <= '1';
      wait for clk_period*10;
		en <= '1';
		wait for clk_period*1;
		en <= '0';
		wait for clk_period*1;
		shift <= '1';
		wait for clk_period*10;
      assert false severity failure;
   end process;

END;
