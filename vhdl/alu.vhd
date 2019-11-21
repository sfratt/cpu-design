library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity alu is
    port(
        x, y : in std_logic_vector(31 downto 0); -- two input operands
        add_sub : in std_logic; -- 0 = add, 1 = sub
        logic_func : in std_logic_vector(1 downto 0); -- 00 = AND, 01 = OR, 10 = XOR, 11 = NOR
        func : in std_logic_vector(1 downto 0); -- 00 = lui, 01 = setless, 10 = arith, 11 = logic
        output : out std_logic_vector(31 downto 0);
        overflow : out std_logic;
        zero : out std_logic
    );
end alu;

architecture alu_arch of alu is
    signal add, sub, adder_subtract_out, logic_unit_out : std_logic_vector(31 downto 0);
begin
    add <= signed(x) + signed(y);
    sub <= signed(x) - signed(y);

    adder_subtract_unit : process(x, y, add_sub, add, sub) -- must add and sub be passed in
    begin
        if (add_sub = '0') then
            adder_subtract_out <= add;
        else
            adder_subtract_out <= sub;
        end if;
    end process;

    logic_unit : process(x, y, logic_func)
    begin
        case logic_func is
            when "00" => 
                logic_unit_out <= x and y;
            when "01" => 
                logic_unit_out <= x or y;
            when "10" => 
                logic_unit_out <= x xor y;
            when others => 
                logic_unit_out <= x nor y;
        end case;
    end process;

    mux4_unit : process(y, sub, adder_subtract_out, logic_unit_out, func)
    begin
        case func is
            when "00" => 
                output <= y;
            when "01" => 
                output <= "0000000000000000000000000000000" & sub(31);
            when "10" => 
                output <= adder_subtract_out;
            when others => 
                output <= logic_unit_out;
        end case;
    end process;

    zero_unit : process(adder_subtract_out)
    begin
        -- zero <= '1';

        -- for item in 0 to 31 loop
        --     if (adder_subtract_out(item) = '1') then
        --         zero <= '0';
        --     end if;
        -- end loop;

        if (adder_subtract_out = (adder_subtract_out'range => '0')) then
			zero <= '1';
		else
			zero <= '0';
		end if;
    end process;

    overflow_unit : process(x, y, adder_subtract_out)
    begin
        overflow <= (x(31) and y(31) and not (adder_subtract_out(31))) or (not (x(31)) and not (y(31)) and adder_subtract_out(31));
    end process;
end architecture alu_arch;
