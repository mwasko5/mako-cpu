library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity RegisterFile is
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
end RegisterFile;

architecture Behavioral of RegisterFile is
    type REGISTER_FILE_ARRAY is array(0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
    signal REGISTER_FILE : REGISTER_FILE_ARRAY := (
        0 => STD_LOGIC_VECTOR(to_unsigned(5, 32)),
        1 => STD_LOGIC_VECTOR(to_unsigned(10, 32)),
        2 => STD_LOGIC_VECTOR(to_unsigned(15, 32)),
        3 => STD_LOGIC_VECTOR(to_unsigned(20, 32)),
        others => "00000000000000000000000000000000"
    );
begin
    process(CLK) begin
        if (rising_edge(CLK)) then
            READ_DATA_1 <= REGISTER_FILE(to_integer(unsigned(READ_REGISTER_1))); 
            READ_DATA_2 <= REGISTER_FILE(to_integer(unsigned(READ_REGISTER_2)));
        end if;
        if (falling_edge(CLK)) then
            if(REG_WRITE = '1') then
                REGISTER_FILE(to_integer(unsigned(WRITE_REGISTER))) <= WRITE_DATA;
            end if;
        end if;
    end process;
end Behavioral;