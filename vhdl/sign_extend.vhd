library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend is
	port(
		data_in  : in  std_logic_vector(15 downto 0);
		func     : in  std_logic_vector(1 downto 0);
		data_out : out std_logic_vector(31 downto 0)
	);
end entity sign_extend;

architecture sign_extend_arch of sign_extend is
	signal load_upper_immediate : std_logic_vector(31 downto 0);
	signal set_less_immediate   : std_logic_vector(31 downto 0);
	signal arithmetic           : std_logic_vector(31 downto 0);
	signal logical              : std_logic_vector(31 downto 0);
    alias data_16               : std_logic_vector(15 downto 0) is data_in;
    alias data_32               : std_logic_vector(31 downto 0) is data_out;
begin
    load_upper_immediate <= data_16 & (data_16'high downto 0 => '0');
	set_less_immediate   <= std_logic_vector(resize(signed(data_16), data_32'length));
	arithmetic           <= set_less_immediate;
	logical              <= (31 downto data_16'length => '0') & data_16;

	with func select data_32 <=
		load_upper_immediate when "00",
		set_less_immediate when "01",
        arithmetic when "10",
        logical when "11",
        (others => '0') when others;
end architecture sign_extend_arch;
