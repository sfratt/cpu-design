library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity i_cache is
    port(
        address_in      : in std_logic_vector(4 downto 0);
        -- reg_dst         : in std_logic;
        -- rs, rt          : out std_logic_vector(4 downto 0);
        -- write_address   : out std_logic_vector(4 downto 0);
        instruction_out : out std_logic_vector(31 downto 0)
    );
end i_cache;

architecture i_cache_arch of i_cache is
    signal rt_inter, rd_inter : std_logic_vector(4 downto 0);
begin
    i_cache_unit : process(address_in)
    begin
        case address_in is
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
        end case;
    end process;

    -- assign_outputs : process(instruction_out)
    -- begin
    --     rs <= instruction_out(25 downto 21);
    --     rt <= instruction_out(20 downto 16);
    --     rt_inter <= instruction_out(20 downto 16);
    --     rd_inter <= instruction_out(16 downto 11);
    -- end process ;

    -- mux2 : process(rt_inter, rd_inter, reg_dst)
    -- begin
    --     case reg_dst is
    --         when '0' =>
    --             write_address <= rt_inter;
    --         when others =>
    --             write_address <= rd_inter;
    --     end case ;
    -- end process;
end i_cache_arch;