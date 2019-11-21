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
    signal out_a          : std_logic_vector(31 downto 0);
    signal out_b          : std_logic_vector(31 downto 0);
    signal pc             : std_logic_vector(31 downto 0);
    signal target_address : std_logic_vector(25 downto 0);
    signal next_pc        : std_logic_vector(31 downto 0);

begin
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

    pc_unit : entity work.pc
    port map(
        next_pc => next_pc,
        clk => clk,
        reset => reset,
        pc => pc
    );