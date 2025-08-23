library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity top is
generic (
  RED_WIDTH   : integer := 5;
  GREEN_WIDTH : integer := 6;
  BLUE_WIDTH  : integer := 5
);
port (
  hsync      : out std_logic;
  vsync      : out std_logic;
  r          : out std_logic_vector(RED_WIDTH - 1 downto 0);
  g          : out std_logic_vector(GREEN_WIDTH - 1 downto 0);
  b          : out std_logic_vector(BLUE_WIDTH - 1 downto 0);
  system_clk : in std_logic
);
end entity top;

architecture behavioural of top is

  constant PX_RESTART_COUNT  : integer := 800;
  constant PX_COUNT_LENGTH   : integer := integer(ceil(log2(real(PX_RESTART_COUNT))));
  constant LN_RESTART_COUNT  : integer := 525;
  constant LN_COUNT_LENGTH   : integer := integer(ceil(log2(real(LN_RESTART_COUNT))));
  constant DATA_BUS_LENGTH   : integer := 16;
  constant HS_VISIBLE_AREA   : integer := 640;
  constant HS_FRONT_PORCH    : integer := 16;
  constant HS_SYNC_PULSE     : integer := 96;
  constant HS_BACK_PORCH     : integer := 48;
  constant VS_VISIBLE_AREA   : integer := 480;
  constant VS_FRONT_PORCH    : integer := 10;
  constant VS_SYNC_PULSE     : integer := 2;
  constant VS_BACK_PORCH     : integer := 33;

  signal vga_clk   : std_logic;
  signal h_visible : std_logic;
  signal v_visible : std_logic;
  signal px_count  : std_logic_vector(PX_COUNT_LENGTH - 1 downto 0);
  signal ln_count  : std_logic_vector(LN_COUNT_LENGTH - 1 downto 0);
  signal data_bus  : std_logic_vector(DATA_BUS_LENGTH - 1 downto 0); 

  component Gowin_rPLL is
  port (
    clkout: out std_logic;
    clkoutd: out std_logic;
    clkin: in std_logic
  );
  end component;

  component Gowin_pROM
  port (
    dout: out std_logic_vector(15 downto 0);
    clk: in std_logic;
    oce: in std_logic;
    ce: in std_logic;
    reset: in std_logic;
    ad: in std_logic_vector(14 downto 0)
  );
  end component;

begin
  -- Drive rgb lines
  r <= data_bus(DATA_BUS_LENGTH - 1 downto 11) and (h_visible and v_visible);
  g <= data_bus(10 downto 5) and (h_visible and v_visible);
  b <= data_bus(4 downto 0) and (h_visible and v_visible);

  rpll: Gowin_rPLL
  port map (
    clkout => open,
    clkoutd => vga_clk,
    clkin => system_clk
  );

  rom: Gowin_pROM
  port map (
    dout => data_bus,
    clk => vga_clk,
    oce => '1',
    ce => h_visible and v_visible,
    reset => '0',
    ad => ln_count(8 downto 2) & px_count(9 downto 2) 
  );

  vga: entity work.vga(behavioural)
  generic map (
    PX_RESTART_COUNT => PX_RESTART_COUNT,
    PX_COUNT_LENGTH  => PX_COUNT_LENGTH,
    LN_RESTART_COUNT => LN_RESTART_COUNT,
    LN_COUNT_LENGTH  => LN_COUNT_LENGTH,
    HS_VISIBLE_AREA  => HS_VISIBLE_AREA,
    HS_FRONT_PORCH   => HS_FRONT_PORCH,
    HS_SYNC_PULSE    => HS_SYNC_PULSE,
    HS_BACK_PORCH    => HS_BACK_PORCH,
    VS_VISIBLE_AREA  => VS_VISIBLE_AREA,
    VS_FRONT_PORCH   => VS_FRONT_PORCH,
    VS_SYNC_PULSE    => VS_SYNC_PULSE,
    VS_BACK_PORCH    => VS_BACK_PORCH
  )
  port map (
    h_visible => h_visible,
    v_visible => v_visible,
    px_count  => px_count,
    ln_count  => ln_count,
    hsync     => hsync,
    vsync     => vsync,
    vga_clk   => vga_clk
  );

end architecture behavioural;