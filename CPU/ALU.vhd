--Christos Gkoumas, p3160026
--Spyridon Pagkalos, p3150133

LIBRARY ieee, subcircuits;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
USE work.subcircuits.all;

--PACKAGE DECLARATION FOR ALU
PACKAGE ALU IS
	--COMPONENT DECLARATION FOR ALU16
	COMPONENT ALU16
		PORT(CTL : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			CIN: IN STD_LOGIC;
         A,B: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
         FO: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
			COUT: OUT STD_LOGIC);
	END COMPONENT;
END PACKAGE ALU;

LIBRARY ieee, subcircuits;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
USE work.subcircuits.all;

--ENTITY DECLARATION FOR ALU16
ENTITY ALU16 IS
   PORT (CTL : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			CIN: IN STD_LOGIC;
         A,B: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
         FO: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
			COUT: OUT STD_LOGIC);
END ALU16;

--ARCHITECTURE DECLARATION FOR ALU16
ARCHITECTURE Behavior of ALU16 IS
--SIGNAL ALL THE TEMP STD_LOGIC & STD_LOGIC_VECTORS
Signal AND_RES: std_logic_vector (15 downto 0);
Signal OR_RES: std_logic_vector (15 downto 0);
Signal NOT_RES: std_logic_vector (15 downto 0);
Signal GEQ_RES: std_logic_vector (15 downto 0);
Signal ADD_RES: std_logic_vector (15 downto 0);
Signal SUB_RES: std_logic_vector (15 downto 0);
Signal ADD_COUT: std_logic;
Signal ADD_V: std_logic;
Signal SUB_V: std_logic;
Signal SUB_COUT: std_logic;
BEGIN 
	--INSTANTATE ALL THE APPROPRIATE GATES & FUNCTIONS
	INST_AND: GATE_AND PORT MAP(A => A, B => B, O => AND_RES);
	INST_OR: GATE_OR PORT MAP(A => A, B => B, O => OR_RES);
	INST_NOT: GATE_PR_NOT PORT MAP(A => A, O => NOT_RES);
	INST_GEQ: GATE_GEQ PORT MAP(A => A, O => GEQ_RES);
	INST_ADD: FULLADDER_16 PORT MAP(A => A, B => B, CIN => CIN, O16 => ADD_RES, V => ADD_V, COUT => ADD_COUT);
	INST_SUB: SUBTRACTOR_16 PORT MAP(A => A, B => B, CIN => CIN, O16 => SUB_RES, V => SUB_V, COUT => SUB_COUT);
	--CREATE PROCESS FOR CONTROL
	Process(CTL, A, B)
	BEGIN
		--CASES FOR THE CONTROL
		case CTL Is
			--FO IS THE FINAL RESULT OF THE ALU, AND COUT IS THE CARRY OUT
			when "000" => 
				FO	<= ADD_RES;
				COUT <= ADD_COUT;
			when "001" => 
				FO <= SUB_RES;
				COUT <= SUB_COUT;
			when "010" => FO <= AND_RES;
			when "011" => FO <= OR_RES;
			when "100" => FO <= GEQ_RES;
			when "101" => FO <= NOT_RES;
			when others => FO <= "0000000000000000";
	   End Case;
	END PROCESS;
END Behavior;