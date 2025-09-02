library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_addu is
generic (
  ADDRESS_WIDTH : integer := 13;
  MAX_ADDRESS : integer := 256
);
port (
  clk_in : in std_logic;
  address : out std_logic_vector(ADDRESS_WIDTH - 1 downto 0);
  enable : in std_logic
);
end entity uart_addu;

architecture behavioural of uart_addu is
begin

  process(clk_in, enable)
    variable current_ln : unsigned(5 downto 0) := (others => '0');
    variable current_cl : unsigned(6 downto 0) := (others => '0');
  begin
    if rising_edge(clk_in) and enable = '1' then
      address <= std_logic_vector(current_ln & current_cl);
      current_cl := current_cl + 1;
      if current_cl >= 80 then 
        current_cl := (others => '0');
        current_ln := current_ln + 1;
        if current_ln >= 60 then
          current_ln := (others => '0');
        end if;
      end if;
    end if;
  end process;

end architecture;