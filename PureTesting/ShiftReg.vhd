----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:39:23 10/08/2012 
-- Design Name: 
-- Module Name:    ShiftReg - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ShiftReg is
    generic (
	     length_1      : integer :=  8;
	     length_2      : integer :=  64;
        internal_data : integer :=  64
	 );
    port ( 
	     input  : in  STD_LOGIC_VECTOR(length_1 - 1 downto 0);
        output : out STD_LOGIC_VECTOR(length_2 - 1 downto 0);
        en     : in  STD_LOGIC;
        shift  : in  STD_LOGIC;
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC
	 );
end ShiftReg;

architecture Behavioral of ShiftReg is

signal data : STD_LOGIC_VECTOR(internal_data - 1 downto 0);

begin
    reg : process (clk, reset, data)
	     begin
		      if (clk'event and clk = '1') then
				    if (reset = '1') then
				        data <= (others => '0');
				    elsif (en = '1') then 
					     data(internal_data - 1 downto internal_data - length_1) <= input;
					 else
                    if (shift = '1') then
					         data <= '0' & data(internal_data - 1 downto 1);
						  end if;
					 end if;
				end if;
				output <= data(length_2 - 1 downto 0);
		  end process reg;

end Behavioral;

