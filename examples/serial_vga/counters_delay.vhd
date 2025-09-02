library ieee;
use ieee.std_logic_1164.all;

entity counter_delay is
generic (
  COUNTER_WIDTH : integer := 8
);
port (
  input  : in std_logic_vector(COUNTER_WIDTH - 1 downto 0);
  output : out std_logic_vector(COUNTER_WIDTH - 1 downto 0);
  clk    : in std_logic
);
end entity counter_delay;

architecture behavioural of counter_delay is
begin

  process(input, clk)
  begin
    if rising_edge(clk) then
      output <= input;
    end if;
  end process;

end architecture behavioural;