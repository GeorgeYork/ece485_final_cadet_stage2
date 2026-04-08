
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pipeline_registers is
    Port (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        -- inputs from IF stage
        reg_write : in STD_LOGIC;
        alu_src : in STD_LOGIC;
        mem_read : in STD_LOGIC;
        mem_write : in STD_LOGIC;
        branch : in STD_LOGIC;
        jump : in STD_LOGIC;
        load_addr : in STD_LOGIC;
        instr : in  STD_LOGIC_VECTOR(31 downto 0);
        npc    : in  STD_LOGIC_VECTOR(31 downto 0);
        -- <add other IF registers?>
        
        -- IF/ID pipeline registers
        if_id_reg_write : inout STD_LOGIC;
        if_id_alu_src : inout STD_LOGIC;
        if_id_mem_read : inout STD_LOGIC;
        if_id_mem_write : inout STD_LOGIC;
        if_id_branch : inout STD_LOGIC;
        if_id_jump : inout STD_LOGIC;
        if_id_load_addr : inout STD_LOGIC;
        if_id_instr : inout  STD_LOGIC_VECTOR(31 downto 0);
        
        if_id_reg1_data  : in  STD_LOGIC_VECTOR(31 downto 0);
        if_id_reg2_data  : in  STD_LOGIC_VECTOR(31 downto 0);
        if_id_imm        : in  STD_LOGIC_VECTOR(31 downto 0);
        
        if_id_alu_op : inout STD_LOGIC_VECTOR(3 downto 0);
        -- <add other if_id registers>
        
        -- ID/EX pipeline registers
        id_ex_reg_write : inout STD_LOGIC;
        id_ex_alu_src : inout STD_LOGIC;
        id_ex_mem_read : inout STD_LOGIC;
        id_ex_mem_write : inout STD_LOGIC;
        id_ex_branch : inout STD_LOGIC;
        id_ex_jump : inout STD_LOGIC;
        id_ex_load_addr : inout STD_LOGIC;
        id_ex_instr : out STD_LOGIC_VECTOR(31 downto 0);
        id_ex_reg1_data  : inout  STD_LOGIC_VECTOR(31 downto 0);
        -- <add other id_ex registers>
        
        -- EX/MEM pipeline registers        
        ex_mem_reg_write : inout STD_LOGIC;
        ex_mem_alu_src : inout STD_LOGIC;
        ex_mem_mem_read : inout STD_LOGIC;
        ex_mem_mem_write : inout STD_LOGIC;
        ex_mem_branch : out STD_LOGIC;
        ex_mem_jump : out STD_LOGIC;
        ex_mem_load_addr : inout STD_LOGIC;
        ex_mem_reg1_data : out STD_LOGIC_VECTOR(31 downto 0);
        -- <add other ex_mem registers>
        
        -- MEM/WB pipeline registers
        mem_wb_reg_write : out STD_LOGIC;
        mem_wb_alu_src : out STD_LOGIC;
        mem_wb_mem_read : out STD_LOGIC;
        mem_wb_mem_write : out STD_LOGIC;
        mem_wb_load_addr : out STD_LOGIC;
        mem_wb_alu_result  : out STD_LOGIC_VECTOR(31 downto 0)
        -- <add other mem_wb registers>
        
    );
end pipeline_registers;

architecture Behavioral of pipeline_registers is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            if_id_reg_write <= '0';
            if_id_alu_src <= '0';
            if_id_mem_read <= '0';
            if_id_mem_write <= '0';
            if_id_branch <= '0';
            if_id_jump <= '0';
            if_id_load_addr <= '0';
            if_id_instr <= (others => '0');
            if_id_npc    <= (others => '0');
            if_id_rd   <= (others => '0');
            if_id_alu_op <= (others => '0');
            
            id_ex_reg_write <= '0';
            id_ex_alu_src <= '0';
            -- <add other registers>
            
        elsif rising_edge(clk) then
            if_id_reg_write <= reg_write;
            if_id_alu_src <= alu_src;
            if_id_mem_read <= mem_read;
            if_id_mem_write <= mem_write;
            if_id_branch <= branch;
            if_id_jump <= jump;
            if_id_load_addr <= load_addr;
            if_id_instr <= instr;
            if_id_npc <= npc;
            if_id_rd  <= rd;
            if_id_alu_op <= alu_op;
        
            id_ex_reg_write <= if_id_reg_write;
            id_ex_alu_src <= if_id_alu_src;
            id_ex_mem_read <= if_id_mem_read;
            -- <add other registers>
            ex_mem_reg_write <= id_ex_reg_write;
            ex_mem_alu_src <= id_ex_alu_src;
            -- <add other registers>
            mem_wb_reg_write <= ex_mem_reg_write;
            mem_wb_alu_src <= ex_mem_alu_src;
            -- <add other registers>
            
        end if;
    end process;
end Behavioral;
