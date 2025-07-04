-- add = "add rd,rs1,rs2"
-- 0000000 [24:20]rs2 [19:15]rs1 000 [11:7]rd 0110011

-- sub = "sub rd,rs1,rs2"
-- 0110000 [24:20]rs2 [19:15]rs1 000 [11:7]rd 0110011

-- mul = "mul rd,rs1,rs2"
-- 0000001 [24:20]rs2 [19:15]rs1 000 [11:7]rd 0110011

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity InstructionMemory is 
    port (
        ADDRESS     : in STD_LOGIC_VECTOR(31 downto 0); -- INPUT ADDRESS
        
        INSTRUCTION : out STD_LOGIC_VECTOR(31 downto 0)    
    );
end InstructionMemory;

architecture Behavioral of InstructionMemory is
    type MEMORY_ARRAY is array(0 to 1023) of STD_LOGIC_VECTOR(31 downto 0);
    signal INSTRUCTION_MEMORY : MEMORY_ARRAY := (
        0 => "00000010000100000000000100110011",
        1 => "01100000000100000000000100110011",
        2 => "00000000000100000000000100110011",        
        others => "00000000000000000000000000000000"
    );
begin
    process(ADDRESS) begin
        INSTRUCTION <= INSTRUCTION_MEMORY(to_integer(unsigned(ADDRESS(11 downto 2))));
    end process;
end Behavioral;