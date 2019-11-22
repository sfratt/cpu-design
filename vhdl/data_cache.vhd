library ieee;
use ieee.std_logic_1164.all;

entity data_cache is
    port(
        data_in : in std_logic_vector(31 downto 0);
        address : in std_logic_vector(4 downto 0);
        clk : in std_logic;
        rst : in std_logic;
        data_write : in std_logic;
        data_out : out std_logic_vector(31 downto 0)
    );
end data_cache;

architecture d_cache_arch of data_cache is 
begin

end architecture d_cache_arch;
