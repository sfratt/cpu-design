library ieee;
use ieee.std_logic_1164.all;
-- use ieee.std_logic_unsigned.all;

entity pc is
    port(
        next_pc : in std_logic_vector(31 downto 0);
        clk     : in std_logic;
        reset   : in std_logic;
        pc      : out std_logic_vector(31 downto 0)
    );
end pc;

architecture pc_arch of pc is
begin
    pc_unit : process(clk, reset)
    begin
        if reset = '1' then
            pc <= X"00000000";
        elsif rising_edge(clk) then
            pc <= next_pc;
        end if;
    end process;
end architecture pc_arch;