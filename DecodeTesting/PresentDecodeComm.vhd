----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:01:00 06/26/2013 
-- Design Name: 
-- Module Name:    PresentComm - Behavioral 
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

entity PresentDecodeComm is
	generic (
			w_2: integer := 2;
			w_4: integer := 4;
			w_5: integer := 5;
			w_64: integer := 64;
			w_80: integer := 80
	);
	port (
		DATA_RXD : in  STD_LOGIC;
		CLK		: in  STD_LOGIC;
		RESET		: in  STD_LOGIC;
		DATA_TXD	: out STD_LOGIC
	);
end PresentDecodeComm;

architecture Behavioral of PresentDecodeComm is

component ShiftReg is
	generic (
		length_1      : integer :=  8;
		length_2      : integer :=  w_64;
		internal_data : integer :=  w_64
	);
	port ( 
		input  : in  STD_LOGIC_VECTOR(length_1 - 1 downto 0);
		output : out STD_LOGIC_VECTOR(length_2 - 1 downto 0);
		en     : in  STD_LOGIC;
		shift  : in  STD_LOGIC;
		clk    : in  STD_LOGIC;
		reset  : in  STD_LOGIC
	);
end component ShiftReg;

component Rs232RefComp is
    Port ( 
		TXD 	: out std_logic  	:= '1';
    	RXD 	: in  std_logic;					
    	CLK 	: in  std_logic;								--Master Clock
		DBIN 	: in  std_logic_vector (7 downto 0);	--Data Bus in
		DBOUT : out std_logic_vector (7 downto 0);	--Data Bus out
		RDA	: inout std_logic;						--Read Data Available
		TBE	: inout std_logic 	:= '1';			--Transfer Bus Empty
		RD		: in  std_logic;					--Read Strobe
		WR		: in  std_logic;					--Write Strobe
		PE		: out std_logic;					--Parity Error Flag
		FE		: out std_logic;					--Frame Error Flag
		OE		: out std_logic;					--Overwrite Error Flag
		RST		: in  std_logic	:= '0');	--Master Reset
end component Rs232RefComp;

component PresentFullDecoder is
	generic (
		w_64: integer := 64;
		w_80: integer := 80
	);
	port(
		ciphertext : in std_logic_vector(w_64 - 1 downto 0);
		key		  : in std_logic_vector(w_80 - 1 downto 0);
		plaintext  : out std_logic_vector(w_64 - 1 downto 0);
		start, clk, reset : in std_logic;
		ready : out std_logic			
	);
end component PresentFullDecoder;

component PresentDecodeCommSM is
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
end component PresentDecodeCommSM;

signal keyText    : STD_LOGIC_VECTOR(w_80 - 1 downto 0);
signal plaintext  : STD_LOGIC_VECTOR(w_64 - 1 downto 0);
signal ciphertext : STD_LOGIC_VECTOR(w_64 - 1 downto 0);

signal dataTXD : STD_LOGIC_VECTOR(7 downto 0);
signal dataRXD : STD_LOGIC_VECTOR(7 downto 0);
signal RDAsig  : STD_LOGIC;
signal TBEsig  : STD_LOGIC;
signal RDsig   : STD_LOGIC;
signal WRsig   : STD_LOGIC;
signal PEsig   : STD_LOGIC;
signal FEsig   : STD_LOGIC;
signal OEsig   : STD_LOGIC;

signal keyDataEn    : STD_LOGIC;
signal keyDataShift : STD_LOGIC;

signal textDataEn    : STD_LOGIC;
signal textDataShift : STD_LOGIC;

signal ciphDataEn    : STD_LOGIC;
signal ciphDataShift : STD_LOGIC;

signal startSig : STD_LOGIC;
signal readySig : STD_LOGIC;

begin

	RS232 : Rs232RefComp
		Port map( 
			TXD 	=> DATA_TXD,
			RXD 	=> DATA_RXD,
			CLK 	=> clk,
			DBIN 	=> dataTXD,
			DBOUT => dataRXD,
			RDA	=> RDAsig,
			TBE	=> TBEsig,
			RD		=> RDsig,
			WR		=> WRsig,
			PE		=> PEsig,
			FE		=> FEsig,
			OE		=> OEsig,
			RST	=> reset
		);

	textReg : ShiftReg
		generic map(
			length_1 => 8,
			length_2 => w_64,
			internal_data => w_64
		)
		port map( 
			input  => dataRXD,
			output => plaintext,
			en     => textDataEn,
			shift  => textDataShift,
			clk    => clk,
			reset  => reset
		);

	keyReg : ShiftReg
		generic map(
			length_1 => 8,
			length_2 => w_80,
			internal_data => w_80
		)
		port map( 
			input  => dataRXD,
			output => keyText,
			en     => keyDataEn,
			shift  => keyDataShift,
			clk    => clk,
			reset  => reset
		);

	present :PresentFullDecoder
		port map(
			ciphertext 	=> plaintext,
			key		 	=> keyText,
			plaintext	=> ciphertext,
			start			=> startSig,
			clk			=> clk,
			reset			=> reset,
			ready			=> readySig
		);

	outReg : ShiftReg
		generic map(
			length_1 => w_64,
			length_2 => 8,
			internal_data => w_64
		)
		port map( 
			input  => ciphertext,
			output => dataTXD,
			en     => ciphDataEn,
			shift  => ciphDataShift,
			clk    => clk,
			reset  => reset
		);

	SM : PresentDecodeCommSM 
		port map(
			clk				=> clk,
			reset				=> reset,
			RDAsig			=> RDAsig,
			TBEsig			=> TBEsig,
			RDsig				=> RDsig,
			WRsig				=> WRsig,
			textDataEn     => textDataEn,
			textDataShift	=> textDataShift,
			keyDataEn		=> keyDataEn,
			keyDataShift	=> keyDataShift,
			ciphDataEn     => ciphDataEn,
			ciphDataShift  => ciphDataShift,
			startSig			=> startSig,
			readySig			=> readySig
		);

end Behavioral;

