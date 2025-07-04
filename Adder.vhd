library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Adder is
    generic ( -- parameters
        BIT_WIDTH : integer := 31 -- 2^32
    );
    port (
        INPUT_A : in STD_LOGIC_VECTOR(BIT_WIDTH downto 0);
        INPUT_B : in STD_LOGIC_VECTOR(BIT_WIDTH downto 0);
        
        OUTPUT : out STD_LOGIC_VECTOR(BIT_WIDTH downto 0)
    );
end Adder;

architecture Behavioral of Adder is
begin
    process(INPUT_A, INPUT_B) begin
        OUTPUT <= INPUT_A + INPUT_B;
    end process;
end Behavioral;
