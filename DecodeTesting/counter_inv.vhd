----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:47:04 04/02/2011 
-- Design Name: 
-- Module Name:    counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter_inv is
	generic (
		w_5 : integer := 5
	);
	port (
		clk, reset, cnt_res : in std_logic;
		num : out std_logic_vector (w_5-1 downto 0)
	);
end counter_inv;

architecture Behavioral of counter_inv is
	signal cnt : std_logic_vector(w_5-1 downto 0) := (others => '0');
	begin
		licznik : process (clk, reset, cnt)
			begin
				if (reset = '1') then
					cnt <= (others => '1');
				elsif (clk'Event and clk = '1') then
					if (cnt_res = '1') then
						cnt <= cnt - 1;
					end if;
				end if;
			end process licznik;
			num <= cnt;
	end Behavioral;

