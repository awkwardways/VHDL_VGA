library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart is
  generic(
    input_bus_width : natural := 8;
    output_bus_width : natural := 8
  );
  port(
    data_in         : in std_logic_vector(input_bus_width - 1 downto 0);
    data_out        : out std_logic_vector(output_bus_width - 1 downto 0);
    tx              : out std_logic := '1';
    rx              : in std_logic;
    wrn             : in std_logic; --Write to register. Active low
    rdn             : in std_logic; --Read received data. Active low
    ctsn            : in std_logic; --Clear to send. Active low
    bauds           : in std_logic;
    msgstb          : out std_logic := '1'
  );
end entity uart;

architecture rtl of uart is
  type rx_state_t is (r_idle, r_data, r_stop_bit);
  type tx_state_t is (t_idle, t_data, t_stop_bit);
  signal rx_state : rx_state_t := r_idle;
  signal tx_state : tx_state_t := t_idle;
  signal rx_register : std_logic_vector(input_bus_width - 1 downto 0) := (others => '0');
  signal tx_register : std_logic_vector(output_bus_width - 1 downto 0) := (others => '0');
begin

  --Receiver process
  receive : process(bauds)
    variable bits_received : natural := 0;
  begin
    if rising_edge(bauds) then

      if rdn = '0' then
        data_out <= rx_register;
      else 
        data_out <= (others => '0');
      end if;

      case rx_state is

        --Check if rx line was pulled low to begin transmission
        when r_idle =>
        msgstb <= '0';
        if rx = '0' then
          rx_state <= r_data;
        end if;
        
        --Read order: LSB first
        when r_data =>
        rx_register(bits_received) <= rx;
        bits_received := bits_received + 1;
        if bits_received = input_bus_width then
          rx_state <= r_stop_bit;
          bits_received := 0;
        end if;
        
        when r_stop_bit =>
          msgstb <= '1';
          rx_state <= r_idle;
          
      end case;
    end if;
  end process receive;

  --Transmitter process
  transmit : process(bauds)
    variable sent_bits : natural := 0;
  begin
    if rising_edge(bauds) then
      if wrn = '0' then
        tx_register <= data_in;
      end if;

      case tx_state is
        --Send starting bit
        when t_idle =>
          tx <= ctsn;
          if ctsn = '0' then
            tx_state <= t_data;
          else
            tx_state <= t_idle;
          end if;

        --Send data LSB first
        when t_data =>
          tx <= tx_register(sent_bits);
          sent_bits := sent_bits + 1;
          if sent_bits = output_bus_width then
            tx_state <= t_stop_bit;
            sent_bits := 0;
          end if;
        
        when t_stop_bit =>
          tx <= '1';
          tx_state <= t_idle;  

      end case;        
    end if;
  end process transmit;

end architecture rtl;