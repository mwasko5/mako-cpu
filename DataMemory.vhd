library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity DataMemory is
    port (
        CLK :in STD_LOGIC;
        
        ADDRESS     : in STD_LOGIC_VECTOR(31 downto 0);
        
        WRITE_DATA  : in STD_LOGIC_VECTOR(31 downto 0);
        
        MEM_WRITE   : in STD_LOGIC;
        MEM_READ    : in STD_LOGIC;
        
        READ_DATA   : out STD_LOGIC_VECTOR(31 downto 0)
    );  
end DataMemory;

architecture Behavioral of DataMemory is
    type DATA_MEMORY_ARRAY is array(0 to 1023) of STD_LOGIC_VECTOR(31 downto 0);
    signal DATA_MEMORY : DATA_MEMORY_ARRAY := (
        others => "00000000000000000000000000000000"
    );
begin
    process(CLK) begin
        if rising_edge(CLK) then
            if(MEM_READ = '1') then
                READ_DATA <= DATA_MEMORY(to_integer(unsigned(ADDRESS(11 downto 2))));
            else
                READ_DATA <= STD_LOGIC_VECTOR(to_unsigned(0, 32));
            end if;
            
            if(MEM_WRITE = '1') then
                DATA_MEMORY(to_integer(unsigned(ADDRESS(11 downto 2)))) <= WRITE_DATA;
            end if;
        end if;
    end process;
end Behavioral;
