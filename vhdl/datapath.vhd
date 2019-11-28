library ieee;
use ieee.std_logic_1164.all;

entity datapath is
    port(
        pc_sel      : in std_logic_vector(1 downto 0);
        branch_type : in std_logic_vector(1 downto 0);
        reset       : in std_logic; 
        clk         : in std_logic;
        reg_dst     : in std_logic;
        alu_src     : in std_logic;
        reg_in_src  : in std_logic;
        reg_write   : in std_logic;
        data_write  : in std_logic;
        add_sub     : in std_logic;
        logic_func  : in std_logic_vector(1 downto 0);
        func        : in std_logic_vector(1 downto 0);
        op_code     : out std_logic_vector(4 downto 0);
        func_code   : out std_logic_vector(4 downto 0);
        overflow    : out std_logic;
        zero        : out std_logic
    );
end datapath;

architecture datapath_arch of datapath is
    signal out_a           : std_logic_vector(31 downto 0);
    signal out_b           : std_logic_vector(31 downto 0);
    signal pc              : std_logic_vector(31 downto 0);
    signal target_address  : std_logic_vector(25 downto 0);
    signal next_pc         : std_logic_vector(31 downto 0);
    signal instruction_out : std_logic_vector(31 downto 0);
    signal rs_inter        : std_logic_vector(4 downto 0);
    signal rt_inter        : std_logic_vector(4 downto 0);
    signal rd_inter        : std_logic_vector(4 downto 0);
    signal write_address   : std_logic_vector(4 downto 0);
    signal regfile_in      : std_logic_vector(31 downto 0);
    signal y_in            : std_logic_vector(31 downto 0);
    signal alu_out         : std_logic_vector(31 downto 0);
    signal sign_extend_out : std_logic_vector(31 downto 0);
    signal d_cache_out     : std_logic_vector(31 downto 0);
begin
    -- Next Address
    next_address_unit : entity work.next_address
    port map(
        branch_type => branch_type,
        pc_sel => pc_sel,
        rs => out_a,
        rt => out_b,
        pc => pc,
        target_address => target_address,
        next_pc => next_pc
    );

    -- Program Counter
    pc_unit : entity work.pc
    port map(
        next_pc => next_pc,
        clk => clk,
        reset => reset,
        pc => pc
    );

    -- Instruction Cache
    i_cache_unit : entity work.instruction_cache
    port map(
        address_in => pc(4 downto 0),
        instruction_out => instruction_out
    );

    op_code <= instruction_out(31 downto 26); -- opcode (J-/I-/R-format)
    target_address <= instruction_out(25 downto 0); -- target address (J-format)
    rs_inter <= instruction_out(25 downto 21); -- source 1 (I-/R-format)
    rt_inter <= instruction_out(20 downto 16); -- source 2 (R-format)
    rd_inter <= instruction_out(15 downto 11); -- destination (R-format)
    func_code <= instruction_out(5 downto 0); -- function (R-format)

    -- I-format when '0' else R-format when '1'
    write_address <= rt_inter when (reg_dst = '0') else rd_inter; -- reg_dst_mux2

    -- Register File
    regfile_unit : entity work.regfile
    port map(
        d_in => regfile_in,
        reset => reset,
        clk => clk,
        write => reg_write,
        read_a => rs_inter,
        read_b => rt_inter,
        write_address => write_address,
        out_a => out_a,
        out_b => out_b
    );

    -- Sign Extend
    sign_extend_unit : entity work.sign_extend
    port map(
        d_in => instruction_out(15 downto 0),
        func => func,
        d_out => sign_extend_out
    );

    y_in <= out_b when (alu_src = '0') else sign_extend_out; -- alu_src_mux2

    -- Arithmetic Logic Unit
    alu_unit : entity work.alu
    port map(
        x => out_a,
        y => y_in,
        add_sub => add_sub,
        logic_func => logic_func,
        func => func,
        output => alu_out,
        overflow => overflow,
        zero => zero
    );

    -- Data Cache
    data_cache_unit : entity work.data_cache
    port map(
        d_in => out_b,
        address => alu_out(4 downto 0),
        clk => clk,
        reset => reset,
        data_write => data_write,
        d_out => d_cache_out
    );

    regfile_in <= d_cache_out when (reg_in_src = '0') else alu_out; -- reg_in_src_mux2

end architecture datapath_arch;
