LIBRARY ieee, subcircuits, ALU;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
USE work.subcircuits.all;
USE work.ALU.all;

LIBRARY ieee, subcircuits, ALU;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
USE work.subcircuits.all;
USE work.ALU.all;

ENTITY CPU IS
   PORT(OP: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		CLOCK, CIN, EN: IN STD_LOGIC;
		IN1, IN2: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		ALUOUT, FF_1, FF_2, FF_3: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		COUT: OUT STD_LOGIC);
END CPU;

ARCHITECTURE Behavior of CPU IS
Signal FF1_OUT: std_logic_vector (15 downto 0);
Signal FF2_OUT: std_logic_vector (15 downto 0);
Signal ALU_RES: std_logic_vector (15 downto 0);
Signal FF3_OUT: std_logic_vector (15 downto 0);
BEGIN 
	FF1: REG PORT MAP(IN1, EN, CLOCK, FF1_OUT);
	FF2: REG PORT MAP(IN2, EN, CLOCK, FF2_OUT);
	INST_ALU: ALU16 PORT MAP(OP, CIN, FF1_OUT, FF2_OUT, ALU_RES, COUT);
	--INST_ALU: ALU16 PORT MAP(OP, CIN, IN1, IN2, ALU_RES, COUT);
	FF3: REG PORT MAP(ALU_RES, EN, CLOCK, FF3_OUT);
	ALUOUT <= ALU_RES;
	FF_1 <= FF1_OUT;
	FF_2 <= FF2_OUT;
	FF_3 <= FF3_OUT;
END Behavior;