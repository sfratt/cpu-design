library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity cpu is
    port(
        reset          : in std_logic;
        clk            : in std_logic;
        rs_out, rt_out : out std_logic_vector(3 downto 0); -- output ports from register file
        pc_out         : out std_logic_vector(3 downto 0);
        overflow, zero : out std_logic -- will not be constrained in Xilinx since not enough LEDs
    );
end cpu;

architecture cpu_arch of cpu is
    signal op_code     : std_logic_vector(5 downto 0);
    signal func_code   : std_logic_vector(5 downto 0);
    signal reg_write   : std_logic;
    signal reg_dst     : std_logic;
    signal reg_in_src  : std_logic;
    signal alu_src     : std_logic;
    signal add_sub     : std_logic;
    signal data_write  : std_logic;
    signal logic_func  : std_logic_vector(1 downto 0);
    signal func        : std_logic_vector(1 downto 0);
    signal branch_type : std_logic_vector(1 downto 0);
    signal pc_sel      : std_logic_vector(1 downto 0);
begin
    -- Datapath
    datapath_unit : entity work.datapath
    port map(
        pc_sel      => pc_sel,     
        branch_type => branch_type,
        reset       => reset,      
        clk         => clk,        
        reg_dst     => reg_dst,    
        alu_src     => alu_src,    
        reg_in_src  => reg_in_src, 
        reg_write   => reg_write,  
        data_write  => data_write, 
        add_sub     => add_sub,    
        logic_func  => logic_func, 
        func        => func,       
        op_code     => op_code,    
        func_code   => func_code,  
        overflow    => overflow,   
        zero        => zero       
    );

    -- Control Unit
    control_unit : entity work.control_unit
    port map(
        op_code     => op_code,     
        func_code   => func_code,   
        reg_write   => reg_write,   
        reg_dst     => reg_dst,     
        reg_in_src  => reg_in_src,  
        alu_src     => alu_src,     
        add_sub     => add_sub,     
        data_write  => data_write,  
        logic_func  => logic_func,  
        func        => func,        
        branch_type => branch_type, 
        pc_sel      => pc_sel      
    );
end architecture cpu_arch;