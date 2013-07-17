--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 


library IEEE;
use IEEE.STD_LOGIC_1164.all;
package kody is
	-- type for PresentStateMachine to control the datapath & circuit -- 
	type stany is (NOP, SM_START, SM_READY);
	type stany_comm is (NOP, READ_DATA_KEY, DECODE_READ_KEY, MOVE_KEY, TEMP_STATE, TEMP2_STATE, TEMP_OUT,
								NOP_FOR_KEY, READ_DATA_TEXT, DECODE_READ_TEXT, MOVE_TEXT,
								PRESENT_ENCODE, WRITE_OUT, MOVE_OUT);
end kody;