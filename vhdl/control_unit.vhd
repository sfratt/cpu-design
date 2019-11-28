library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity control_unit is
    port(
        op_code     : in std_logic_vector(5 downto 0);
        func_code   : in std_logic_vector(5 downto 0);
        reg_write   : out std_logic;
        reg_dst     : out std_logic;
        reg_in_src  : out std_logic;
        alu_src     : out std_logic;
        add_sub     : out std_logic;
        data_write  : out std_logic;
        logic_func  : out std_logic_vector(1 downto 0);
        func        : out std_logic_vector(1 downto 0);
        branch_type : out std_logic_vector(1 downto 0);
        pc_sel      : out std_logic_vector(1 downto 0)
    );
end control_unit;

architecture control_arch of control_unit is
    signal control : std_logic_vector(13 downto 0);
begin
    control_unit : process(op_code, func_code)
    begin
        case op_code is
            when "000000" =>
                if (func_code = "100000") then
                    control <= "11100000100000"; -- add
                elsif (func_code = "100010") then
                    control <= "11101000100000"; -- sub
                elsif (func_code = "101010") then
                    control <= "11100000010000"; -- slt
                elsif (func_code = "100100") then
                    control <= "11100000110000"; -- and
                elsif (func_code = "100101") then
                    control <= "11100001110000"; -- or
                elsif (func_code = "100110") then
                    control <= "11100010110000"; -- xor
                elsif (func_code = "100111") then
                    control <= "11100011110000"; -- nor
                elsif (func_code = "001000") then
                    control <= "00000000000010"; -- jr
                end if;
            when "000001" => 
                control <= "00000000001100"; -- bltz
            when "000010" => 
                control <= "00000000000001"; -- j
            when "000100" => 
                control <= "00000000000100"; -- beq
            when "000101" => 
                control <= "00000000001000"; -- bne
            when "001000" => 
                control <= "10110000100000"; -- addi
            when "001010" => 
                control <= "10110000010000"; -- slti
            when "001100" => 
                control <= "10110000110000"; -- andi
            when "001101" => 
                control <= "10110001110000"; -- ori
            when "001110" => 
                control <= "10110010110000"; -- xori
            when "001111" => 
                control <= "10110000000000"; -- lui
            when "100011" => 
                control <= "10010000100000"; -- lw
            when "101011" => 
                control <= "00010100100000"; -- sw
            when others =>
        end case;
    end process;

    reg_write <= control(13);
    reg_dst <= control(12);
    reg_in_src <= control(11);
    alu_src <= control(10);
    add_sub <= control(9);
    data_write <= control(8);
    logic_func <= control(7 downto 6);
    func <= control(5 downto 4);
    branch_type <= control(3 downto 2);
    pc_sel <= control(1 downto 0);
    
end architecture control_arch;