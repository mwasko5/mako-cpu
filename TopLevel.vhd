library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TopLevel is
    port (
        CLK     : in STD_LOGIC;
        RESET   : in STD_LOGIC
        -- RESULT  : out STD_LOGIC_VECTOR(31 downto 0)
    );
end TopLevel;

architecture Structural of TopLevel is
    signal PC_ADDER_WIRE : STD_LOGIC_VECTOR(31 downto 0);
    signal PROGRAM_COUNTER_OUT_WIRE : STD_LOGIC_VECTOR(31 downto 0);
    
    signal INSTRUCTION_OUT_WIRE : STD_LOGIC_VECTOR(31 downto 0);
    
    signal READ_DATA_1_WIRE : STD_LOGIC_VECTOR(31 downto 0);
    signal READ_DATA_2_WIRE : STD_LOGIC_VECTOR(31 downto 0);
    
    signal ALU_SELECT_WIRE : STD_LOGIC_VECTOR(3 downto 0);
    signal ALU_RESULT_WIRE : STD_LOGIC_VECTOR(31 downto 0);
    
    signal REG_WRITE_WIRE : STD_LOGIC;
    
    component Controller
        port (
            INSTRUCTION : in STD_LOGIC_VECTOR(31 downto 0);
            
            REG_WRITE : out STD_LOGIC;
            
            ALU_SELECT : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    component Adder
        port (
            INPUT_A : in STD_LOGIC_VECTOR(31 downto 0);
            INPUT_B : in STD_LOGIC_VECTOR(31 downto 0);
            
            OUTPUT : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    
    component ProgramCounter 
        port (
            CLK     : in STD_LOGIC;
            RESET   : in STD_LOGIC;
            
            INPUT   : in STD_LOGIC_VECTOR(31 downto 0);
            
            OUTPUT  : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    
    component InstructionMemory
        port (
            ADDRESS     : in STD_LOGIC_VECTOR(31 downto 0);
            
            INSTRUCTION : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    
    component RegisterFile
        port (
            CLK             : in STD_LOGIC;
        
            READ_REGISTER_1 : in STD_LOGIC_VECTOR(4 downto 0);
            READ_REGISTER_2 : in STD_LOGIC_VECTOR(4 downto 0);
            
            READ_DATA_1     : out STD_LOGIC_VECTOR(31 downto 0);
            READ_DATA_2     : out STD_LOGIC_VECTOR(31 downto 0);
            
            WRITE_REGISTER  : in STD_LOGIC_VECTOR(4 downto 0);
            
            WRITE_DATA      : in STD_LOGIC_VECTOR(31 downto 0);
            
            REG_WRITE       : in STD_LOGIC
        );
    end component;
    
    component ALU
        port (
            INPUT_A         : in STD_LOGIC_VECTOR(31 downto 0);
            INPUT_B         : in STD_LOGIC_VECTOR(31 downto 0);
            
            INPUT_SELECT    : in STD_LOGIC_VECTOR(3 downto 0);
            
            OUTPUT          : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    
begin
    CONTROLLER_1 : Controller
        port map (
            INSTRUCTION => INSTRUCTION_OUT_WIRE,
            REG_WRITE => REG_WRITE_WIRE,
            ALU_SELECT => ALU_SELECT_WIRE
        );
    
    PC_ADDER : Adder
        port map (
            INPUT_A => PROGRAM_COUNTER_OUT_WIRE,
            INPUT_B => STD_LOGIC_VECTOR(to_unsigned(4, 32)), -- add 4 to the existing PC
            OUTPUT => PC_ADDER_WIRE
        );
        
    PROGRAM_COUNTER : ProgramCounter
        port map (
            CLK => CLK,
            RESET => RESET,
            INPUT => PC_ADDER_WIRE, -- the "+4" thing
            OUTPUT => PROGRAM_COUNTER_OUT_WIRE
        );
        
    INSTRUCTION_MEMORY : InstructionMemory
        port map (
            ADDRESS => PROGRAM_COUNTER_OUT_WIRE,
            INSTRUCTION => INSTRUCTION_OUT_WIRE
        );
        
    REGISTER_FILE : RegisterFile
        port map (
            CLK => CLK,
            
            READ_REGISTER_1 => INSTRUCTION_OUT_WIRE(19 downto 15), -- rs1
            READ_REGISTER_2 => INSTRUCTION_OUT_WIRE(24 downto 20), -- rs2
            
            READ_DATA_1 => READ_DATA_1_WIRE,
            READ_DATA_2 => READ_DATA_2_WIRE,
            
            WRITE_REGISTER => INSTRUCTION_OUT_WIRE(11 downto 7), -- rd
            
            WRITE_DATA => ALU_RESULT_WIRE,
            
            REG_WRITE => REG_WRITE_WIRE
        );
        
    ALU_1 : ALU
        port map (
            INPUT_A => READ_DATA_1_WIRE,
            INPUT_B => READ_DATA_2_WIRE,
            
            INPUT_SELECT => ALU_SELECT_WIRE,
            
            OUTPUT => ALU_RESULT_WIRE
        );
end Structural;
