library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity pc is
    port(
        d_in  : in std_logic_vector(31 downto 0);
        clk   : in std_logic;
        reset : in std_logic;
        q_out : out std_logic_vector(31 downto 0)
    );
end pc;

architecture pc_arch of pc is
begin
    pc_unit : process(clk, reset)
    begin
        if reset = '1' then
            q_out <= X"00000000";
        elsif rising_edge(clk) then
            q_out <= d_in;
        end if;
    end process;
end pc_arch;