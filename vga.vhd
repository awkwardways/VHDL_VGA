library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use ieee.math_real.all;

entity vga is
generic (
  -- pixel counter 
  PX_RESTART_COUNT : integer := 800;
  PX_COUNT_LENGTH  : integer := integer(ceil(log2(real(PX_RESTART_COUNT))));

  -- line counter 
  LN_RESTART_COUNT : integer := 525;
  LN_COUNT_LENGTH  : integer := integer(ceil(log2(real(LN_RESTART_COUNT))));

  -- hsync 
  HS_VISIBLE_AREA   : integer := 640;
  HS_FRONT_PORCH    : integer := 16;
  HS_SYNC_PULSE     : integer := 96;
  HS_BACK_PORCH     : integer := 48;

  -- vsync 
  VS_VISIBLE_AREA   : integer := 480;
  VS_FRONT_PORCH    : integer := 10;
  VS_SYNC_PULSE     : integer := 2;
  VS_BACK_PORCH     : integer := 33
);
port (
  h_visible : out std_logic;
  v_visible : out std_logic;
  px_count  : out std_logic_vector(PX_COUNT_LENGTH - 1 downto 0);
  ln_count  : out std_logic_vector(LN_COUNT_LENGTH - 1 downto 0);
  hsync     : out std_logic;
  vsync     : out std_logic;
  vga_clk   : in std_logic
);
end entity vga;

architecture behavioural of vga is
begin

  pixelcounter: entity work.px_counter(behavioural)
  generic map (
    RESTART_COUNT => PX_RESTART_COUNT,
    PX_COUNT_LENGTH => PX_COUNT_LENGTH
  )
  port map (
    clk_in => vga_clk,
    px_count => px_count
  );

  linecounter: entity work.ln_counter(behavioural)
  generic map (
    LN_RESTART_COUNT => LN_RESTART_COUNT,
    PX_RESTART_COUNT => PX_RESTART_COUNT,
    PX_COUNT_LENGTH => PX_COUNT_LENGTH,
    LN_COUNT_LENGTH => LN_COUNT_LENGTH
  )
  port map (
    clk_in => vga_clk,
    ln_count => ln_count,
    px_count => px_count
  );

  hsyncgenerator: entity work.hsync_generator(behavioural)
  generic map (
    PX_COUNT_LENGTH => PX_COUNT_LENGTH,
    VISIBLE_AREA => HS_VISIBLE_AREA,
    FRONT_PORCH => HS_FRONT_PORCH,
    SYNC_PULSE => HS_SYNC_PULSE,
    BACK_PORCH => HS_BACK_PORCH 
  )
  port map (
    px_count => px_count, 
    hsync => hsync,
    h_visible => h_visible
  );

  vsyncgenerator: entity work.vsync_generator(behavioural)
  generic map (
    LN_COUNT_LENGTH => LN_COUNT_LENGTH,
    VISIBLE_AREA => VS_VISIBLE_AREA,
    FRONT_PORCH => VS_FRONT_PORCH,
    SYNC_PULSE => VS_SYNC_PULSE,
    BACK_PORCH => VS_BACK_PORCH
  )
  port map (
    vsync => vsync,
    ln_count => ln_count,
    v_visible => v_visible
  );

end architecture behavioural;