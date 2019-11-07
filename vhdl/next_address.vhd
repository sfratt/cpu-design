library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity next_address is
    port(
        rt, rs : in std_logic_vector(31 downto 0); -- two register inputs
        pc : in std_logic_vector(31 downto 0);
        target_address : in std_logic_vector(25 downto 0);
        branch_type : in std_logic_vector(1 downto 0);
        pc_sel : in std_logic_vector(1 downto 0);
        next_pc : out std_logic_vector(31 downto 0)
    );
end next_address;

architecture next_address_arch of next_address is
    signal control : std_logic_vector(31 downto 0);
    signal offset : std_logic_vector(15 downto 0);
begin
    offset <= target_address(15 downto 0);

    branch_type_unit : process(rt, rs, pc, branch_type, offset)
    begin
        case branch_type is
            when "00" =>
                control <= pc + X"00000001"; -- no branch
            when "01" =>
                if (rs = rt) then
                    control <= pc + X"00000001" + std_logic_vector(resize(signed(offset), control'length));
                else
                    control <= pc + X"00000001"; -- beq resolved to false
                end if;
            when "10" =>
                if (rs /= rt) then
                    control <= pc + X"00000001" + std_logic_vector(resize(signed(offset), control'length));
                else
                    control <= pc + X"00000001"; -- bne resolved to false
                end if;
            when others =>
                if (rs < 0) then
                    control <= pc + X"00000001" + std_logic_vector(resize(signed(offset), control'length));
                else
                    control <= pc + X"00000001"; -- bltz resolved to false
                end if;
        end case;
    end process;
    
    pc_select_unit : process(pc_sel, pc, rs, target_address, control)
    begin
        case pc_sel is
            when "00" => 
                next_pc <= control;
            when "01" => 
                next_pc <= "000000" & target_address; -- jump target address
            when "10" => 
                next_pc <= rs; -- jump register
            when others => 
                next_pc <= pc + X"0000001"; -- straight-line execution
        end case;
    end process;
end next_address_arch;