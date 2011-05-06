--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:29:45 05/16/2010
-- Design Name:   
-- Module Name:   C:/Users/gajos/Desktop/Polibuda/vhdl/projekt/szyfrator/PresentEncTB.vhd
-- Project Name:  szyfrator
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
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
USE std.textio.all;
USE work.txt_util.all;
USE ieee.std_logic_textio.all;
use work.kody.ALL;
 
ENTITY PresentEncTB IS
END PresentEncTB;
 
ARCHITECTURE behavior OF PresentEncTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PresentEnc
    PORT(
         input : IN  std_logic_vector(31 downto 0);
         output : OUT  std_logic_vector(31 downto 0);
         ctrl : IN  std_logic_vector(3 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         ready : out  std_logic
        );
    END COMPONENT;
    
	-- Clock period definitions
   constant clk_period : time := 1ns;
	constant p10 : time := clk_period/10;
	constant edge : time := clk_period-p10;

   --Inputs
   signal input : std_logic_vector(31 downto 0) := (others => '0');
   signal ctrl : std_logic_vector(3 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
	signal strobe : std_logic;

 	--Outputs
   signal output : std_logic_vector(31 downto 0);
	signal ready : std_logic := '0';
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PresentEnc PORT MAP (
          input => input,
          output => output,
          ctrl => ctrl,
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
	
	file infile :text is in "wejscie.txt";
	variable line_in :line;
	variable bytes : std_logic_vector(32 downto 0);
	variable bytes2 : std_logic_vector(3 downto 0);
	variable xbit : std_logic;
	
		
   begin		
      -- hold reset state for 100ms.
      wait for 100ns;	
		reset <= '1';
		wait for 10ns;
		reset <= '0';
		wait for 10ns;
      -- insert stimulus here 
			while not (endfile(infile)) loop
				readline(infile, line_in);		--2
				hread(line_in, bytes2);
				ctrl <= bytes2;
				wait for clk_period;
				readline(infile, line_in);		-- 1
				hread(line_in, bytes2);
				ctrl <= bytes2;
				readline(infile, line_in);
				read(line_in, xbit);
				input <= (others => xbit);
				wait for clk_period;
				readline(infile, line_in);
				hread(line_in, bytes2);
				ctrl <= bytes2;
				readline(infile, line_in);
				read(line_in, xbit);
				input <= (others => xbit);
				wait for clk_period;
				readline(infile, line_in);
				hread(line_in, bytes2);
				ctrl <= bytes2;
				readline(infile, line_in);
				read(line_in, xbit);
				input <= (others => xbit);
				wait for clk_period;
				readline(infile, line_in);
				hread(line_in, bytes2);
				ctrl <= bytes2;
				readline(infile, line_in);
				read(line_in, xbit);
				input <= (others => xbit);
				wait for clk_period;
				readline(infile, line_in);
				hread(line_in, bytes2);
				ctrl <= bytes2;
				readline(infile, line_in);
				read(line_in, xbit);
				input <= (others => xbit);
				wait for clk_period;
				readline(infile, line_in);
				hread(line_in, bytes2);
				ctrl <= bytes2;			
				wait for clk_period*33;
				readline(infile, line_in);
				hread(line_in, bytes2);
				ctrl <= bytes2;			
				wait for clk_period;
				readline(infile, line_in);
				hread(line_in, bytes2);
				ctrl <= bytes2;			
				wait for clk_period*2;
			end loop;
		assert false severity failure;
   end process;
	
	strobe <= TRANSPORT clk AFTER edge;
	
	outs: PROCESS (strobe)
		variable str :string(1 to 29);
		variable lineout :line;
		variable init_file :std_logic := '1';
		file outfile :text is out "wyjscie.txt";
		
		-------- funkcja konwersji: std_logic_vector => character --------
		function conv_to_hex_char (sig: std_logic_vector(3 downto 0)) RETURN character IS
			begin
			case sig is
				when "0000" => return '0';
				when "0001" => return '1';
				when "0010" => return '2';
				when "0011" => return '3';
				when "0100" => return '4';
				when "0101" => return '5';
				when "0110" => return '6';
				when "0111" => return '7';
				when "1000" => return '8';
				when "1001" => return '9';
				when "1010" => return 'A';
				when "1011" => return 'B';
				when "1100" => return 'C';
				when "1101" => return 'D';
				when "1110" => return 'E';								
				when others => return 'F';
			end case;
		end conv_to_hex_char;
		
		-------- funkcja konwersji: std_logic => character --------
		function conv_to_char (sig: std_logic) RETURN character IS
			begin
			case sig is
				when '1' => return '1';
				when '0' => return '0';
				when 'Z' => return 'Z';
				when others => return 'X';
			end case;
		end conv_to_char;
		
		-------- funkcja konwersji: std_logic_vector => string --------
		function conv_to_string (inp: std_logic_vector; length: integer) RETURN string IS
			variable x : integer := length/4;
			variable s : string(1 to x);
			begin				
				for i in 0 to (x-1) loop
				s(x-i) := conv_to_hex_char(inp(4*i+3 downto 4*i));
				end loop;
			return s;
		end conv_to_string;
		
		-------------------------------------
		begin
		-------- nag³ówek pliku wyjœciowego (podzia³ kolumn) --------
			if init_file = '1' then
				str:="clk                          ";
				write(lineout,str); writeline(outfile,lineout);
				str:="| reset                      ";
				write(lineout,str); writeline(outfile,lineout);
				str:="| | ready                    ";
				write(lineout,str); writeline(outfile,lineout);
				str:="| | | ctrl                   ";
				write(lineout,str); writeline(outfile,lineout);
				str:="| | | | input                ";
				write(lineout,str); writeline(outfile,lineout);
				str:="| | | | |        output      ";
				write(lineout,str); writeline(outfile,lineout);
				str:="| | | | |        |           ";
				write(lineout,str); writeline(outfile,lineout);
				init_file := '0';
			end if;
		
		-------- zapis danych do pliku wyjsciowego „wyjscie” --------
			if (strobe'EVENT and strobe='0') then
				str := (others => ' ');
				str(1) := conv_to_char(clk);
				str(2) := '|';
				str(3) := conv_to_char(reset);
				str(4) := '|';
				str(5) := conv_to_char(ready);
				str(6) := '|';
				str(7) := conv_to_hex_char(ctrl);
				str(8) := '|';
				str(9 to 16) := conv_to_string(input,32);
				str(17) := '|';
				str(18 to 25) := conv_to_string(output,32);
				str(26) := '|';				
				write(lineout,str);
				writeline(outfile,lineout);
			end if;
	end process outs;
end;