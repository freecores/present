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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
	generic (
		w_2 : integer := 2;
		w_5 : integer := 5
	);
	port (
		clk, reset, cnt_res : in std_logic;
		info : out std_logic_vector (w_2-1 downto 0);
		num : out std_logic_vector (w_5-1 downto 0)
	);
end counter;

architecture Behavioral of counter is
	begin
		licznik : process (clk, reset)
			variable cnt : unsigned(w_5-1 downto 0);
			begin
				if (reset = '1') then
					cnt := (others => '0');
				elsif (clk'Event and clk = '1') then
					if (cnt_res = '1') then
						cnt := cnt + 1;
						if (std_logic_vector(cnt) = "00001") then
							info <= "01";
						elsif (std_logic_vector(cnt) = "00000") then
							info <= "00";
						else
							info <= "11";
						end if;
					else 
						cnt := (others => '0');
					end if;
				end if;
				num <= std_logic_vector(cnt);
			end process licznik;
	end Behavioral;

