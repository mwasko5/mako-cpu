library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ALU is
    generic ( -- parameters
        MAX_SELECT : integer := 3 -- 2^4
    );
    port ( 
        INPUT_A : in STD_LOGIC_VECTOR(31 downto 0);
        INPUT_B : in STD_LOGIC_VECTOR(31 downto 0);
        
        INPUT_SELECT : in STD_LOGIC_VECTOR(MAX_SELECT downto 0);
        
        OUTPUT : out STD_LOGIC_VECTOR(31 downto 0)
    );
end ALU;
    -- SELECT CODES:
    -- 00000 = ADD
    -- 00001 = SUB
    -- 00010 = MUL

architecture Behavioral of ALU is
begin
    process(INPUT_A, INPUT_B, INPUT_SELECT) begin
        case(INPUT_SELECT) is
            when "00000" =>
                OUTPUT <= INPUT_A + INPUT_B;
            when "00001" =>
                OUTPUT <= INPUT_A - INPUT_B;
            when "00010" =>
                OUTPUT <= INPUT_A(15 downto 0) * INPUT_B(15 downto 0);
            when others =>
                OUTPUT <= INPUT_A + INPUT_B;
        end case;
    end process;
end Behavioral;
