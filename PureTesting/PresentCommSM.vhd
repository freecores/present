----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:49:35 06/26/2013 
-- Design Name: 
-- Module Name:    PresentCommSM - Behavioral 
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
use work.kody.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PresentCommSM is
	port (
		clk				: in STD_LOGIC;
		reset				: in STD_LOGIC;
		RDAsig			: in STD_LOGIC;
		TBEsig			: in STD_LOGIC;
		RDsig				: out STD_LOGIC;
		WRsig				: out STD_LOGIC;
		textDataEn     : out STD_LOGIC;
		textDataShift	: out STD_LOGIC;
		keyDataEn		: out STD_LOGIC;
		keyDataShift	: out STD_LOGIC;
		ciphDataEn     : out STD_LOGIC;
		ciphDataShift  : out STD_LOGIC;
		startSig			: out STD_LOGIC;
		readySig			: in STD_LOGIC
	);
end PresentCommSM;

architecture Behavioral of PresentCommSM is

component counter is
	generic (
		w_5 : integer := 5
	);
	port (
		clk, reset, cnt_res : in std_logic;
		num : out std_logic_vector (w_5-1 downto 0)
	);
end component counter;

signal state      : stany_comm := NOP;
signal next_state : stany_comm := NOP;

-- modify for variable key size
signal serialDataCtrCt    : STD_LOGIC;
signal serialDataCtrOut   : STD_LOGIC_VECTOR(3 downto 0);
signal serialDataCtrReset : STD_LOGIC;
signal ctrReset			  : STD_LOGIC;
-- DO NOT MODIFY!!!
signal shiftDataCtrCt    : STD_LOGIC;
signal shiftDataCtrOut   : STD_LOGIC_VECTOR(2 downto 0);

begin
	ctrReset <= serialDataCtrReset or reset;
	SM : process(state, RDAsig, TBEsig, shiftDataCtrOut, serialDataCtrOut, readySig)
		begin
			case state is
				when NOP =>
					RDsig					 <= '0';
					WRsig					 <= '0';
					textDataEn			 <= '0';
					textDataShift		 <= '0';
					keyDataEn			 <= '0';
					keyDataShift		 <= '0';
					ciphDataEn			 <= '0';
					ciphDataShift		 <= '0';
					startSig				 <= '0';
					serialDataCtrCt	 <= '0';
					shiftDataCtrCt		 <= '0';
					serialDataCtrReset <= '0';
					if (RDAsig = '1') then
						next_state <= READ_DATA_TEXT;
					else
						next_state <= NOP;
					end if;
				when READ_DATA_TEXT =>
					RDsig					 <= '1';
					WRsig					 <= '0';
					textDataEn			 <= '1';
					textDataShift		 <= '0';
					keyDataEn			 <= '0';
					keyDataShift		 <= '0';
					ciphDataEn			 <= '0';
					ciphDataShift		 <= '0';
					startSig				 <= '0';
					serialDataCtrCt	 <= '1';
					shiftDataCtrCt		 <= '0';
					serialDataCtrReset <= '0';
					next_state <= DECODE_READ_TEXT;
				when DECODE_READ_TEXT =>
					RDsig					 <= '0';
					WRsig					 <= '0';
					textDataEn			 <= '0';
					textDataShift		 <= '0';
					keyDataEn			 <= '0';
					keyDataShift		 <= '0';
					ciphDataEn			 <= '0';
					ciphDataShift		 <= '0';
					startSig				 <= '0';
					serialDataCtrCt	 <= '0';
					shiftDataCtrCt		 <= '0';
					if (serialDataCtrOut(3 downto 0) = "1000") then
						next_state <= TEMP_STATE;
					else
						next_state <= MOVE_TEXT;
					end if;
				when TEMP_STATE =>
					RDsig					 <= '0';
					WRsig					 <= '0';
					textDataEn			 <= '0';
					textDataShift		 <= '0';
					keyDataEn			 <= '0';
					keyDataShift		 <= '0';
					ciphDataEn			 <= '0';
					ciphDataShift		 <= '0';
					startSig				 <= '0';
					serialDataCtrCt	 <= '0';
					shiftDataCtrCt		 <= '0';
					serialDataCtrReset <= '1';
					next_state <= NOP_FOR_KEY;
				when MOVE_TEXT =>
					RDsig					 <= '0';
					WRsig					 <= '0';
					textDataEn			 <= '0';
					textDataShift		 <= '1';
					keyDataEn			 <= '0';
					keyDataShift		 <= '0';
					ciphDataEn			 <= '0';
					ciphDataShift		 <= '0';
					startSig				 <= '0';
					serialDataCtrCt	 <= '0';
					shiftDataCtrCt 	 <= '1';
					serialDataCtrReset <= '0';
					if (shiftDataCtrOut(2 downto 0) = "111") then
						next_state <= NOP;
					else
						next_state <= MOVE_TEXT;
					end if;
				when NOP_FOR_KEY	=>
					RDsig					 <= '0';
					WRsig					 <= '0';
					textDataEn			 <= '0';
					textDataShift		 <= '0';
					keyDataEn			 <= '0';
					keyDataShift		 <= '0';
					ciphDataEn			 <= '0';
					ciphDataShift		 <= '0';
					startSig				 <= '0';
					serialDataCtrCt	 <= '0';
					shiftDataCtrCt		 <= '0';
					serialDataCtrReset <= '0';
					if (RDAsig = '1') then
						next_state <= READ_DATA_KEY;
					else
						next_state <= NOP_FOR_KEY;
					end if;
				when READ_DATA_KEY =>
					RDsig					 <= '1';
					WRsig					 <= '0';
					textDataEn			 <= '0';
					textDataShift		 <= '0';
					keyDataEn			 <= '1';
					keyDataShift		 <= '0';
					ciphDataEn			 <= '0';
					ciphDataShift		 <= '0';
					startSig				 <= '0';
					serialDataCtrCt	 <= '1';
					shiftDataCtrCt		 <= '0';
					serialDataCtrReset <= '0';
					next_state <= DECODE_READ_KEY;
				when DECODE_READ_KEY =>
					RDsig					 <= '0';
					WRsig					 <= '0';
					textDataEn			 <= '0';
					textDataShift		 <= '0';
					keyDataEn			 <= '0';
					keyDataShift		 <= '0';
					ciphDataEn			 <= '0';
					ciphDataShift		 <= '0';
					startSig				 <= '0';
					serialDataCtrCt	 <= '0';
					shiftDataCtrCt		 <= '0';
					serialDataCtrReset <= '0';
					if (serialDataCtrOut(3 downto 0) = "1010") then
						next_state <= TEMP2_STATE;
					else
						next_state <= MOVE_KEY;
					end if;
				when TEMP2_STATE =>
					RDsig					 <= '0';
					WRsig					 <= '0';
					textDataEn			 <= '0';
					textDataShift		 <= '0';
					keyDataEn			 <= '0';
					keyDataShift		 <= '0';
					ciphDataEn			 <= '0';
					ciphDataShift		 <= '0';
					startSig				 <= '0';
					serialDataCtrCt	 <= '0';
					shiftDataCtrCt		 <= '0';
					serialDataCtrReset <= '1';
					next_state <= PRESENT_ENCODE;
				when MOVE_KEY =>
					RDsig					 <= '0';
					WRsig					 <= '0';
					textDataEn			 <= '0';
					textDataShift		 <= '0';
					keyDataEn			 <= '0';
					keyDataShift		 <= '1';
					ciphDataEn			 <= '0';
					ciphDataShift		 <= '0';
					startSig				 <= '0';
					serialDataCtrCt	 <= '0';
					shiftDataCtrCt		 <= '1';
					serialDataCtrReset <= '0';
					if (shiftDataCtrOut(2 downto 0) = "111") then
						next_state <= NOP_FOR_KEY;
					else
						next_state <= MOVE_KEY;
					end if;
				when PRESENT_ENCODE =>
					RDsig					 <= '0';
					WRsig					 <= '0';
					textDataEn			 <= '0';
					textDataShift		 <= '0';
					keyDataEn			 <= '0';
					keyDataShift		 <= '0';
					ciphDataShift		 <= '0';
					startSig				 <= '1';
					serialDataCtrCt	 <= '0';
					shiftDataCtrCt		 <= '0';
					serialDataCtrReset <= '0';
					if (readySig = '1') then
						ciphDataEn			 <= '1';
						next_state <= WRITE_OUT;
					else
						ciphDataEn			 <= '0';
						next_state <= PRESENT_ENCODE;
					end if;
				when WRITE_OUT =>
					RDsig					 <= '0';
					textDataEn			 <= '0';
					textDataShift		 <= '0';
					keyDataEn			 <= '0';
					keyDataShift		 <= '0';
					ciphDataEn			 <= '0';
					ciphDataShift		 <= '0';
					startSig				 <= '1';
					serialDataCtrCt	 <= '1';
					shiftDataCtrCt		 <= '0';
					serialDataCtrReset <= '0';
					if (serialDataCtrOut = "1000") then
						WRsig					 <= '0';
						next_state <= TEMP_OUT;
					else
						WRsig					 <= '1';
						next_state <= MOVE_OUT;
					end if;
				when TEMP_OUT =>
					RDsig					 <= '0';
					WRsig					 <= '0';
					textDataEn			 <= '0';
					textDataShift		 <= '0';
					keyDataEn			 <= '0';
					keyDataShift		 <= '0';
					ciphDataEn			 <= '0';
					ciphDataShift		 <= '0';
					startSig				 <= '1';
					serialDataCtrCt	 <= '0';
					shiftDataCtrCt		 <= '0';
					serialDataCtrReset <= '1';
					next_state <= NOP;
				when MOVE_OUT =>
					if (TBEsig = '0') then
						RDsig					 <= '0';
						WRsig					 <= '0';
						textDataEn			 <= '0';
						textDataShift		 <= '0';
						keyDataEn			 <= '0';
						keyDataShift		 <= '0';
						ciphDataEn			 <= '0';
						ciphDataShift		 <= '0';
						startSig				 <= '1';
						serialDataCtrCt	 <= '0';
						shiftDataCtrCt		 <= '0';
						serialDataCtrReset <= '0';
						next_state <= MOVE_OUT;
					else
						RDsig					 <= '0';
						WRsig					 <= '0';
						textDataEn			 <= '0';
						textDataShift		 <= '0';
						keyDataEn			 <= '0';
						keyDataShift		 <= '0';
						ciphDataEn			 <= '0';
						ciphDataShift		 <= '1';
						startSig				 <= '1';
						serialDataCtrCt	 <= '0';
						shiftDataCtrCt		 <= '1';
						serialDataCtrReset <= '0';
						if (shiftDataCtrOut = "111") then
							next_state <= WRITE_OUT;
						else
							next_state <= MOVE_OUT;
						end if;
					end if;
			end case;
		end process SM;

	state_modifier : process (clk, reset)
		begin
			if (clk = '1' and clk'Event) then
				if (reset = '1') then
					state <= NOP;	
				else
					state <= next_state;
				end if;
			end if;
		end process state_modifier;
		
	dataCounter : counter 
		generic map(
			w_5 => 4
		)
		port map ( 
			cnt_res  => serialDataCtrCt, 
			num => serialDataCtrOut,
			clk    => clk, 
			reset  => ctrReset
		);

	shiftCounter : counter 
		generic map(
			w_5 => 3
		)
		port map ( 
			cnt_res  => shiftDataCtrCt, 
			num => shiftDataCtrOut,
			clk    => clk, 
			reset  => reset
		);

end Behavioral;

