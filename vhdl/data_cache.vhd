library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity data_cache is
    port(
        d_in       : in std_logic_vector(31 downto 0);
        address    : in std_logic_vector(4 downto 0);
        clk        : in std_logic;
        reset      : in std_logic;
        data_write : in std_logic;
        d_out      : out std_logic_vector(31 downto 0)
    );
end data_cache;

architecture d_cache_arch of data_cache is
    type locations is array(0 to 31) of std_logic_vector(31 downto 0);
    signal loc : locations;
begin
    data_cache_unit : process(reset, clk, loc, d_in, address)
    begin
        if reset = '1' then
            for i in 0 to 31 loop
                loc(i) <= (others => '0');
            end loop;
        elsif rising_edge(clk) and data_write = '0' then
            d_out <= loc(conv_integer(address));
        elsif rising_edge(clk) and data_write = '1' then
            d_out <= loc(conv_integer(address));
            loc(conv_integer(address)) <= d_in;
        end if;
    end process;
end architecture d_cache_arch;
