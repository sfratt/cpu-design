library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity instruction_cache is
    port(
        address         : in std_logic_vector(4 downto 0);
        instruction_out : out std_logic_vector(31 downto 0)
    );
end instruction_cache;

architecture i_cache_arch of instruction_cache is
    signal rt_inter, rd_inter : std_logic_vector(4 downto 0);
begin
    i_cache_unit : process(address)
    begin
        case address is
            when "00000" => 
                instruction_out <= "00100000000000010000000000000001"; -- addi r1, r0, 1
            when "00001" => 
                instruction_out <= "00100000000000100000000000000010"; -- addi r2, r0, 2
            when "00010" => 
                instruction_out <= "00000000010000010001000000100000"; -- add r2, r2, r1
            when "00011" => 
                instruction_out <= "00001000000000000000000000000010"; -- jump 00010
            when "00100" =>              
                instruction_out <= "00000000000000000000000000000000"; -- dont care
            when others =>
        end case;
    end process;
end architecture i_cache_arch;