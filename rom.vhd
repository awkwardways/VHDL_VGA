library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity ROM is
generic(
  ADDRESS_BUS_WIDTH : natural := 8;
  DATA_BUS_WIDTH : natural := 8;
  ROM_IMAGE : string := ""
);
port(
  address_bus : in std_logic_vector(ADDRESS_BUS_WIDTH - 1 downto 0);
  data_bus : out std_logic_vector(DATA_BUS_WIDTH - 1 downto 0);
  chip_select : in std_logic;
  clock_in : in std_logic
);
end entity ROM;

architecture rtl of ROM is
  type t_ROM is array(2 ** ADDRESS_BUS_WIDTH - 1 downto 0) of std_logic_vector(DATA_BUS_WIDTH - 1 downto 0);

impure function init_rom return t_ROM is
  variable temp_memory : t_ROM;
  file image_file : text open read_mode is ROM_IMAGE;
  variable current_line : line;
  variable i : natural := 0;
  variable temp : bit_vector(DATA_BUS_WIDTH - 1 downto 0);
begin
  if ROM_IMAGE'length = 0 then
    temp_memory := (others => (others => '1'));
    return temp_memory;
  end if;
  
  for i in 0 to 2 ** ADDRESS_BUS_WIDTH - 1 loop
    if endfile(image_file) then
      return temp_memory;
    end if;
    readline(image_file, current_line);
    hread(current_line, temp_memory(i));
  end loop;
  return temp_memory;
end function;

begin

process(clock_in, chip_select)
  constant memory : t_ROM := init_rom;
begin
  if rising_edge(clock_in) and chip_select = '1' then
    data_bus <= memory(to_integer(unsigned(address_bus)));
  end if;
end process;

end architecture rtl;