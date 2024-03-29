--Christos Gkoumas, p3160026
--Spyridon Pagkalos, p3150133

--Answer to question 1C.
--Because of the flip flops, the result of the operation with appear only when the clock changes and the enable signal is 1.

LIBRARY ieee, subcircuits, ALU;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
USE work.subcircuits.all;
USE work.ALU.all;

--ENTITY DECLARATION FOR THE FINAL CIRCUIT
ENTITY CPU IS
	--PORT MAPPING INs & OUTs
	PORT(OP: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		CLOCK, CIN, EN: IN STD_LOGIC;
		IN1, IN2: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		ALUOUT, FF_1, FF_2, FF_3: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		COUT: OUT STD_LOGIC);
END CPU;

--ARCHITECTURE DECLARATION FOR THE FINAL CIRCUIT
ARCHITECTURE Behavior of CPU IS
--SIGNAL ALL THE TEMP STD_LOGIC & STD_LOGIC_VECTORS
Signal FF1_OUT: std_logic_vector (15 downto 0);
Signal FF2_OUT: std_logic_vector (15 downto 0);
Signal ALU_RES: std_logic_vector (15 downto 0);
Signal FF3_OUT: std_logic_vector (15 downto 0);
BEGIN 
	--INSTANTATE ALL THE FLIP FLOPS & THE ALU
	--ALUOUT AND FF1-3 ARE THE RESULTS OF THE ALU
	FF1: REG PORT MAP(IN1, EN, CLOCK, FF1_OUT);
	FF2: REG PORT MAP(IN2, EN, CLOCK, FF2_OUT);
	INST_ALU: ALU16 PORT MAP(OP, CIN, FF1_OUT, FF2_OUT, ALU_RES, COUT);
	FF3: REG PORT MAP(ALU_RES, EN, CLOCK, FF3_OUT);
	ALUOUT <= ALU_RES;
	FF_1 <= FF1_OUT;
	FF_2 <= FF2_OUT;
	FF_3 <= FF3_OUT;
END Behavior;