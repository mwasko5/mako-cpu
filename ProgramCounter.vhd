library ieee;
use ieee.std_logic_1164.all;

entity ProgramCounter is
    generic ( -- parameters
        MAX_INSTRUCTIONS : integer := 31 -- 2^32
    );
    port ( 
        CLK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        
        INPUT : in STD_LOGIC_VECTOR(MAX_INSTRUCTIONS downto 0);
        
        OUTPUT : out STD_LOGIC_VECTOR(MAX_INSTRUCTIONS downto 0)
    );
end ProgramCounter;

architecture Behavioral of ProgramCounter is
    signal PROGRAM_COUNT : STD_LOGIC_VECTOR(MAX_INSTRUCTIONS downto 0);
begin
    process(CLK) begin
        if (rising_edge(CLK)) then
            if (RESET = '1') then
                PROGRAM_COUNT <= "00000000000000000000000000000000";
            else
                PROGRAM_COUNT <= INPUT;
            end if;
        end if;
        OUTPUT <= PROGRAM_COUNT;
    end process;
end Behavioral;
