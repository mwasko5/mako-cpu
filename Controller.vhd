library ieee;
use ieee.std_logic_1164.all;

entity Controller is
    port (
        INSTRUCTION : in STD_LOGIC_VECTOR(31 downto 0);
        
        REG_WRITE   : out STD_LOGIC;
        
        ALU_SELECT  : out STD_LOGIC_VECTOR(3 downto 0);
        
        MEM_WRITE   : out STD_LOGIC;
        MEM_READ    : out STD_LOGIC
    );
end Controller;

architecture Behavioral of Controller is

begin
    process(INSTRUCTION) begin
        if (INSTRUCTION(31 downto 25) = "0000000") then -- add
            ALU_SELECT <= "0000";
            REG_WRITE <= '1';
        end if;
        if (INSTRUCTION(31 downto 25) = "0110000") then -- sub
            ALU_SELECT <= "0001";
            REG_WRITE <= '1';
        end if;
        if (INSTRUCTION(31 downto 25) = "0000001") then -- mul
            ALU_SELECT <= "0010";
            REG_WRITE <= '1';
        end if;
    end process;
end Behavioral;
