-- 32 x 32 register file
-- two read ports, one write port with write enable

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity regfile is 
    port(
        din : in std_logic_vector(31 downto 0);
        reset : in std_logic;
        clk : in std_logic;
        write : in std_logic;
        read_a : in std_logic_vector(4 downto 0);
        read_b : in std_logic_vector(4 downto 0);
        write_address : in std_logic_vector(4 downto 0);
        out_a : out std_logic_vector(31 downto 0);
        out_b : out std_logic_vector(31 downto 0)
    );
end regfile;

architecture reg_arch of regfile is
    type registers is array(0 to 31) of std_logic_vector(31 downto 0);
    signal reg : registers;
begin
    register_unit : process(clk, reset)
    begin
        if reset = '1' then
            for i in 0 to 31 loop
                reg(i) <= (others => '0');
            end loop;
        elsif rising_edge(clk) and write = '1' then
            reg(conv_integer(write_address)) <= din;
        end if;
    end process;

    read_out : process(read_a, read_b, reg)
    begin
        out_a <= reg(conv_integer(read_a));
        out_b <= reg(conv_integer(read_b));
    end process ;
end reg_arch;
