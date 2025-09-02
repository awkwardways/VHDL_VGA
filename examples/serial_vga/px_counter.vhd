library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

entity px_counter is
generic (
  RESTART_COUNT   : integer := 800;
  PX_COUNT_LENGTH : integer := 10
);
port (
  clk_in      : in std_logic;
  px_count    : out std_logic_vector(PX_COUNT_LENGTH - 1 downto 0)
);
end entity px_counter;

architecture behavioural of px_counter is
  signal count : std_logic_vector(PX_COUNT_LENGTH - 1 downto 0) := (others => '0');
begin

  process(clk_in)
  begin
    if rising_edge(clk_in) then
      px_count <= count;
      count <= std_logic_vector(unsigned(count) + 1);
      if unsigned(count) = RESTART_COUNT - 1 then
        count <= (others => '0');
      end if;
    end if;
  end process;
end architecture behavioural;