library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity cpu is
    port(
        reset : in std_logic;
        clk : in std_logic;
        rs_out, rt_out : out std_logic_vector(3 downto 0); -- output ports from register file
        pc_out : out std_logic_vector(3 downto 0);
        overflow, zero : out std_logic -- will not be constrained in Xilinx since not enough LEDs
    );
end cpu;

architecture cpu_arch of cpu is
begin

end architecture cpu_arch;