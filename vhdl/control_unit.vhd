library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity control_unit is
    port(
        op_code : in std_logic_vector(4 downto 0);
        func_code : in std_logic_vector(4 downto 0);
        reg_write          : in std_logic;
        reg_dst            : in std_logic;
        reg_in_src : in std_logic;
        alu_src         : out std_logic_vector(3 downto 0);
        overflow, zero : out std_logic -- will not be constrained in Xilinx since not enough LEDs
    );
end control_unit;

architecture control_arch of control_unit is
    signal control_signal : std_logic_vector(13 downto 0);
begin
    control_unit : process(op_code, func_code)
    begin
        case op_code is
            when "000000" =>
                if (func_code = "100000") then
                    control_signal <= "11100000100000"; -- add
                elsif (func_code = "100010") then
                    control_signal <= "11101000100000"; -- sub
                elsif (func_code = "101010") then
                    control_signal <= "11100000010000"; -- slt
                elsif (func_code = "100100") then
                    control_signal <= "11100000110000"; -- and
                elsif (func_code = "100101") then
                    control_signal <= "11100001110000"; -- or
                elsif (func_code = "100110") then
                    control_signal <= "11100010110000"; -- xor
                elsif (func_code = "100111") then
                    control_signal <= "11100011110000"; -- nor
                elsif (func_code = "001000") then
                    control_signal <= "00000000000010"; -- jr
                else end if;
            when "000001" => 
                control_signal <= "00000000001100"; -- bltz
            when "000010" => 
                control_signal <= "00000000000001"; -- j
            when "000100" => 
                control_signal <= "00000000000100"; -- beq
            when "000101" => 
                control_signal <= "00000000001000"; -- bne
            when "001000" => 
                control_signal <= "10110000100000"; -- addi
            when "001010" => 
                control_signal <= "10110000010000"; -- slti
            when "001100" => 
                control_signal <= "10110000110000"; -- andi
            when "001101" => 
                control_signal <= "10110001110000"; -- ori
            when "001110" => 
                control_signal <= "10110010110000"; -- xori
            when "001111" => 
                control_signal <= "10110000000000"; -- lui
            when "100011" => 
                control_signal <= "10010000100000"; -- lw
            when "101011" => 
                control_signal <= "00010100100000"; -- sw
            when others =>
        end case;
    end process;
end architecture control_arch;