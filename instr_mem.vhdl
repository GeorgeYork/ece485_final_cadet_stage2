library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity instr_mem is
    Port (
        addr    : in  STD_LOGIC_VECTOR(31 downto 0);
        instr   : out STD_LOGIC_VECTOR(31 downto 0)
    );
end instr_mem;

-- Note: the Real RISC-V uses the ADDI for the NOP instruction, but I'm pretending 0x0000000000000000 is a NOP
-- inserting NOPs to avoid hazards
architecture Behavioral of instr_mem is
    type memory_array is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
    signal memory : memory_array := (
        0 => x"00900293", -- addi x5, x0, 9         000000001001 00000 000 00101 0010011
                          -- load_addr x6, array (custom instruction), where array is 0x10000000
                          -- lw x7, 0(x6)           
                          -- loop: addi x6, x6, 4   
                          --       lw x10, 0(x6)    
                          --       add x7, x10, x7 
                          --       subi x5, x5, 1 (or   addi x5, x5, -1)  
                          --       bne x5, x0, loop       
        xx => x"FE7FF06F", -- done: j done            [-4; note: assumes PC is already incremented by 4]
        others => (others => '0')
    );
begin
    process(addr)
    begin
        instr <= memory(to_integer(unsigned(addr(7 downto 0))));
    end process;
end Behavioral;
