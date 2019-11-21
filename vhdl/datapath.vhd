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
        logic_func  : in std_logic;
        func        : in std_logic;
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
    signal sign_extend_out : std_logic_vector(31 downto 0);
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

    target_address <= instruction_out(25 downto 0);
    rs_inter <= instruction_out(25 downto 21);
    rt_inter <= instruction_out(20 downto 16);
    rd_inter <= instruction_out(15 downto 11);

    write_address <= rt_inter when (reg_dst = '0') else rd_inter; -- mux2

    -- Regfile
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
    sign_extend_unit : entity work.sign_extend_unit
    port map(
        data_in => instruction_out(15 downto 0),
        func => func,
        data_out => sign_extend_out
    );

    y_in <= out_b when (alu_src = '0') else sign_extend_out;

end architecture datapath_arch;