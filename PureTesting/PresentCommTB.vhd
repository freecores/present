--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:26:35 07/05/2013
-- Design Name:   
-- Module Name:   E:/spent i praca/OpenCores/present_opencores/trunk/Testing/VHDL/PresentCommTB.vhd
-- Project Name:  PresentComm
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PresentComm
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
USE std.textio.all;
USE work.txt_util.all;
USE ieee.std_logic_textio.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY PresentCommTB IS
END PresentCommTB;
 
ARCHITECTURE behavior OF PresentCommTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PresentComm
    PORT(
         DATA_RXD : IN  std_logic;
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         DATA_TXD : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal DATA_RXD : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';

 	--Outputs
   signal DATA_TXD : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PresentComm PORT MAP (
          DATA_RXD => DATA_RXD,
          CLK => CLK,
          RESET => RESET,
          DATA_TXD => DATA_TXD
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
	
	file txt :text is in "test/data.txt";
	file key  :text is in "test/key.txt";
	file txt2 :text is in "test/data2.txt";
	file key2  :text is in "test/key2.txt";
	
	variable line_in      : line;
	variable line_content : string(1 to 8);
	variable data         : STD_LOGIC;
	
   begin		
	
		DATA_RXD <= '1';
		RESET <= '1';
      wait for 1000 ns;	
		RESET <= '0';
		
      wait for CLK_period*10;

      while not (endfile(txt)) loop
			readline(txt, line_in);  -- info line
			read(line_in, line_content);
			report line_content;
			
			DATA_RXD <= '0'; -- start bit
			wait for 8.75 us;
			
			readline(txt, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(txt, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(txt, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(txt, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(txt, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(txt, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(txt, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(txt, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(txt, line_in);
			read(line_in, data);
			DATA_RXD <= data; -- parity bit
			wait for 8.75 us;
			
			report "Koniec bajtu";
			DATA_RXD <= '1'; -- stop bit
			wait for 100 us;
		end loop;

		while not (endfile(key)) loop
			readline(key, line_in);  -- info line
			read(line_in, line_content);
			report line_content;
			
			DATA_RXD <= '0'; -- start bit
			wait for 8.75 us;
			
			readline(key, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(key, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(key, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(key, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(key, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(key, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(key, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(key, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(key, line_in);
			read(line_in, data);
			DATA_RXD <= data; -- parity bit
			wait for 8.75 us;
			
			report "Koniec bajtu";
			DATA_RXD <= '1'; -- stop bit
			wait for 100 us;
		end loop;

		wait for 2000 us;
		
		while not (endfile(txt2)) loop
			readline(txt2, line_in);  -- info line
			read(line_in, line_content);
			report line_content;
			
			DATA_RXD <= '0'; -- start bit
			wait for 8.75 us;
			
			readline(txt2, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(txt2, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(txt2, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(txt2, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(txt2, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(txt2, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(txt2, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(txt2, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(txt2, line_in);
			read(line_in, data);
			DATA_RXD <= data; -- parity bit
			wait for 8.75 us;
			
			report "Koniec bajtu";
			DATA_RXD <= '1'; -- stop bit
			wait for 100 us;
		end loop;

		while not (endfile(key2)) loop
			readline(key2, line_in);  -- info line
			read(line_in, line_content);
			report line_content;
			
			DATA_RXD <= '0'; -- start bit
			wait for 8.75 us;
			
			readline(key2, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(key2, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(key2, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(key2, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(key2, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(key2, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(key2, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(key2, line_in);
			read(line_in, data);
			DATA_RXD <= data;
			wait for 8.75 us;
			
			readline(key2, line_in);
			read(line_in, data);
			DATA_RXD <= data; -- parity bit
			wait for 8.75 us;
			
			report "Koniec bajtu";
			DATA_RXD <= '1'; -- stop bit
			wait for 100 us;
		end loop;
		
		wait for 2000 us;
		
      assert false severity failure;
   end process;

END;
