library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.numeric_std.all;

entity de10_nano_clean is
port (
  -- Clocks
  signal FPGA_CLK1_50     : in    std_logic;
  signal FPGA_CLK2_50     : in    std_logic;
  signal FPGA_CLK3_50     : in    std_logic;
  -- HPS DDR3
  signal HPS_CONV_USB_N   : inout std_logic;
  signal HPS_DDR3_ADDR    : out   std_logic_vector(14 downto 0);
  signal HPS_DDR3_BA      : out   std_logic_vector(2 downto 0);
  signal HPS_DDR3_CAS_N   : out   std_logic;
  signal HPS_DDR3_CK_N    : out   std_logic;
  signal HPS_DDR3_CK_P    : out   std_logic;
  signal HPS_DDR3_CKE     : out   std_logic;
  signal HPS_DDR3_CS_N    : out   std_logic;
  signal HPS_DDR3_DM      : out   std_logic_vector(3 downto 0);
  signal HPS_DDR3_DQ      : inout std_logic_vector(31 downto 0);
  signal HPS_DDR3_DQS_N   : inout std_logic_vector(3 downto 0);
  signal HPS_DDR3_DQS_P   : inout std_logic_vector(3 downto 0);
  signal HPS_DDR3_ODT     : out   std_logic;
  signal HPS_DDR3_RAS_N   : out   std_logic;
  signal HPS_DDR3_RESET_N : out   std_logic;
  signal HPS_DDR3_RZQ     : in    std_logic;
  signal HPS_DDR3_WE_N    : out   std_logic;
  -- HPS Ethernet
  signal HPS_ENET_GTX_CLK : out   std_logic;
  signal HPS_ENET_INT_N   : inout std_logic;
  signal HPS_ENET_MDC     : out   std_logic;
  signal HPS_ENET_MDIO    : inout std_logic;
  signal HPS_ENET_RX_CLK  : in    std_logic;
  signal HPS_ENET_RX_DATA : in    std_logic_vector(3 downto 0);
  signal HPS_ENET_RX_DV   : in    std_logic;
  signal HPS_ENET_TX_DATA : out   std_logic_vector(3 downto 0);
  signal HPS_ENET_TX_EN   : out   std_logic;
  -- HPS SD Card interface
  signal HPS_SD_CLK       : out   std_logic;
  signal HPS_SD_CMD       : inout std_logic;
  signal HPS_SD_DATA      : inout std_logic_vector(3 downto 0);
  -- HPS UART
  signal HPS_UART_RX      : in    std_logic;
  signal HPS_UART_TX      : out   std_logic;
  -- HPS USB
  signal HPS_USB_CLKOUT   : in    std_logic;
  signal HPS_USB_DATA     : inout std_logic_vector(7 downto 0);
  signal HPS_USB_DIR      : in    std_logic;
  signal HPS_USB_NXT      : in    std_logic;
  signal HPS_USB_STP      : out   std_logic;
  -- HPS User IO
  signal HPS_KEY          : inout std_logic;
  signal HPS_LED          : inout std_logic;
  -- ADXL345 Accelerometer
  signal HPS_GSENSOR_INT  : inout std_logic;
  signal HPS_I2C0_SCLK    : inout std_logic;
  signal HPS_I2C0_SDAT    : inout std_logic;
  -- LTC connector - SPI Master
  signal HPS_SPIM_CLK     : out   std_logic;
  signal HPS_SPIM_MISO    : in    std_logic;
  signal HPS_SPIM_MOSI    : out   std_logic;
  signal HPS_SPIM_SS      : inout std_logic;
  -- LTC connector - I2C
  signal HPS_I2C1_SCLK    : inout std_logic;
  signal HPS_I2C1_SDAT    : inout std_logic;
  -- LTC connector - SPI / I2C MUX select
  signal HPS_LTC_GPIO     : inout std_logic;
  -- FPGA HDMI
  signal HDMI_I2C_SCL     : inout std_logic;
  signal HDMI_I2C_SDA     : inout std_logic;
  signal HDMI_I2S         : inout std_logic;
  signal HDMI_LRCLK       : inout std_logic;
  signal HDMI_MCLK        : inout std_logic;
  signal HDMI_SCLK        : inout std_logic;
  signal HDMI_TX_CLK      : out   std_logic;
  signal HDMI_TX_D        : out   std_logic_vector(23 downto 0);
  signal HDMI_TX_DE       : out   std_logic;
  signal HDMI_TX_HS       : out   std_logic;
  signal HDMI_TX_INT      : in    std_logic;
  signal HDMI_TX_VS       : out   std_logic;
  -- FPGA Keys
  signal KEY              : in    std_logic_vector(1 downto 0);
  -- FPGA LEDs
  signal LED              : out   std_logic_vector(7 downto 0);
  -- FPGA Switches
  signal SW               : in    std_logic_vector(3 downto 0)

);
end de10_nano_clean;


architecture behavioral of de10_nano_clean is
  
  signal reset : std_logic;
  
  
  component de10_nano_clean_soc is
  port (
    clk_clk                         : in    std_logic := 'X';
    reset_reset_n                   : in    std_logic := 'X';
    memory_mem_a                    : out   std_logic_vector(14 downto 0);
    memory_mem_ba                   : out   std_logic_vector(2 downto 0);
    memory_mem_ck                   : out   std_logic;
    memory_mem_ck_n                 : out   std_logic;
    memory_mem_cke                  : out   std_logic;
    memory_mem_cs_n                 : out   std_logic;
    memory_mem_ras_n                : out   std_logic;
    memory_mem_cas_n                : out   std_logic;
    memory_mem_we_n                 : out   std_logic;
    memory_mem_reset_n              : out   std_logic;
    memory_mem_dq                   : inout std_logic_vector(31 downto 0) := (others => 'X');
    memory_mem_dqs                  : inout std_logic_vector(3 downto 0)  := (others => 'X');
    memory_mem_dqs_n                : inout std_logic_vector(3 downto 0)  := (others => 'X');
    memory_mem_odt                  : out   std_logic;
    memory_mem_dm                   : out   std_logic_vector(3 downto 0);
    memory_oct_rzqin                : in    std_logic := 'X';
    hps_io_hps_io_emac1_inst_TX_CLK : out   std_logic;
    hps_io_hps_io_emac1_inst_TXD0   : out   std_logic;
    hps_io_hps_io_emac1_inst_TXD1   : out   std_logic;
    hps_io_hps_io_emac1_inst_TXD2   : out   std_logic;
    hps_io_hps_io_emac1_inst_TXD3   : out   std_logic;
    hps_io_hps_io_emac1_inst_RXD0   : in    std_logic := 'X';
    hps_io_hps_io_emac1_inst_MDIO   : inout std_logic := 'X';
    hps_io_hps_io_emac1_inst_MDC    : out   std_logic;
    hps_io_hps_io_emac1_inst_RX_CTL : in    std_logic := 'X';
    hps_io_hps_io_emac1_inst_TX_CTL : out   std_logic;
    hps_io_hps_io_emac1_inst_RX_CLK : in    std_logic := 'X';
    hps_io_hps_io_emac1_inst_RXD1   : in    std_logic := 'X';
    hps_io_hps_io_emac1_inst_RXD2   : in    std_logic := 'X';
    hps_io_hps_io_emac1_inst_RXD3   : in    std_logic := 'X';
    hps_io_hps_io_sdio_inst_CMD     : inout std_logic := 'X';
    hps_io_hps_io_sdio_inst_D0      : inout std_logic := 'X';
    hps_io_hps_io_sdio_inst_D1      : inout std_logic := 'X';
    hps_io_hps_io_sdio_inst_CLK     : out   std_logic;
    hps_io_hps_io_sdio_inst_D2      : inout std_logic := 'X';
    hps_io_hps_io_sdio_inst_D3      : inout std_logic := 'X';
    hps_io_hps_io_usb1_inst_D0      : inout std_logic := 'X';
    hps_io_hps_io_usb1_inst_D1      : inout std_logic := 'X';
    hps_io_hps_io_usb1_inst_D2      : inout std_logic := 'X';
    hps_io_hps_io_usb1_inst_D3      : inout std_logic := 'X';
    hps_io_hps_io_usb1_inst_D4      : inout std_logic := 'X';
    hps_io_hps_io_usb1_inst_D5      : inout std_logic := 'X';
    hps_io_hps_io_usb1_inst_D6      : inout std_logic := 'X';
    hps_io_hps_io_usb1_inst_D7      : inout std_logic := 'X';
    hps_io_hps_io_usb1_inst_CLK     : in    std_logic := 'X';
    hps_io_hps_io_usb1_inst_STP     : out   std_logic;
    hps_io_hps_io_usb1_inst_DIR     : in    std_logic := 'X';
    hps_io_hps_io_usb1_inst_NXT     : in    std_logic := 'X';
    hps_io_hps_io_spim1_inst_CLK    : out   std_logic;
    hps_io_hps_io_spim1_inst_MOSI   : out   std_logic;
    hps_io_hps_io_spim1_inst_MISO   : in    std_logic := 'X';
    hps_io_hps_io_spim1_inst_SS0    : out   std_logic;
    hps_io_hps_io_uart0_inst_RX     : in    std_logic := 'X';
    hps_io_hps_io_uart0_inst_TX     : out   std_logic;
    hps_io_hps_io_i2c0_inst_SDA     : inout std_logic := 'X';
    hps_io_hps_io_i2c0_inst_SCL     : inout std_logic := 'X';
    hps_io_hps_io_i2c1_inst_SDA     : inout std_logic := 'X';
    hps_io_hps_io_i2c1_inst_SCL     : inout std_logic := 'X';
    hps_io_hps_io_gpio_inst_GPIO09  : inout std_logic := 'X';
    hps_io_hps_io_gpio_inst_GPIO35  : inout std_logic := 'X';
    hps_io_hps_io_gpio_inst_GPIO40  : inout std_logic := 'X';
    hps_io_hps_io_gpio_inst_GPIO53  : inout std_logic := 'X';
    hps_io_hps_io_gpio_inst_GPIO54  : inout std_logic := 'X';
    hps_io_hps_io_gpio_inst_GPIO61  : inout std_logic := 'X';
    hps_0_h2f_reset_reset_n         : out   std_logic
  );
  end component de10_nano_clean_soc;

begin

  u0 : component de10_nano_clean_soc
  port map (
    clk_clk                         => FPGA_CLK1_50,
    reset_reset_n                   => reset,
    -- HPS DDR3
    memory_mem_a                    => HPS_DDR3_ADDR,
    memory_mem_ba                   => HPS_DDR3_BA,
    memory_mem_ck                   => HPS_DDR3_CK_P,
    memory_mem_ck_n                 => HPS_DDR3_CK_N,
    memory_mem_cke                  => HPS_DDR3_CKE,
    memory_mem_cs_n                 => HPS_DDR3_CS_N,
    memory_mem_ras_n                => HPS_DDR3_RAS_N,
    memory_mem_cas_n                => HPS_DDR3_CAS_N,
    memory_mem_we_n                 => HPS_DDR3_WE_N,
    memory_mem_reset_n              => HPS_DDR3_RESET_N,
    memory_mem_dq                   => HPS_DDR3_DQ,
    memory_mem_dqs                  => HPS_DDR3_DQS_P,
    memory_mem_dqs_n                => HPS_DDR3_DQS_N,
    memory_mem_odt                  => HPS_DDR3_ODT,
    memory_mem_dm                   => HPS_DDR3_DM,
    memory_oct_rzqin                => HPS_DDR3_RZQ,
    -- HPS Ethernet
    hps_io_hps_io_emac1_inst_TX_CLK => HPS_ENET_GTX_CLK,
    hps_io_hps_io_emac1_inst_TXD0   => HPS_ENET_TX_DATA(0),
    hps_io_hps_io_emac1_inst_TXD1   => HPS_ENET_TX_DATA(1),
    hps_io_hps_io_emac1_inst_TXD2   => HPS_ENET_TX_DATA(2),
    hps_io_hps_io_emac1_inst_TXD3   => HPS_ENET_TX_DATA(3),
    hps_io_hps_io_emac1_inst_RXD0   => HPS_ENET_RX_DATA(0),
    hps_io_hps_io_emac1_inst_MDIO   => HPS_ENET_MDIO,
    hps_io_hps_io_emac1_inst_MDC    => HPS_ENET_MDC,
    hps_io_hps_io_emac1_inst_RX_CTL => HPS_ENET_RX_DV,
    hps_io_hps_io_emac1_inst_TX_CTL => HPS_ENET_TX_EN,
    hps_io_hps_io_emac1_inst_RX_CLK => HPS_ENET_RX_CLK,
    hps_io_hps_io_emac1_inst_RXD1   => HPS_ENET_RX_DATA(1),
    hps_io_hps_io_emac1_inst_RXD2   => HPS_ENET_RX_DATA(2),
    hps_io_hps_io_emac1_inst_RXD3   => HPS_ENET_RX_DATA(3),
    -- HPS SD Card
    hps_io_hps_io_sdio_inst_CMD     => HPS_SD_CMD,
    hps_io_hps_io_sdio_inst_D0      => HPS_SD_DATA(0),
    hps_io_hps_io_sdio_inst_D1      => HPS_SD_DATA(1),
    hps_io_hps_io_sdio_inst_CLK     => HPS_SD_CLK,
    hps_io_hps_io_sdio_inst_D2      => HPS_SD_DATA(2),
    hps_io_hps_io_sdio_inst_D3      => HPS_SD_DATA(3),
    -- HPS USB
    hps_io_hps_io_usb1_inst_D0      => HPS_USB_DATA(0),
    hps_io_hps_io_usb1_inst_D1      => HPS_USB_DATA(1),
    hps_io_hps_io_usb1_inst_D2      => HPS_USB_DATA(2),
    hps_io_hps_io_usb1_inst_D3      => HPS_USB_DATA(3),
    hps_io_hps_io_usb1_inst_D4      => HPS_USB_DATA(4),
    hps_io_hps_io_usb1_inst_D5      => HPS_USB_DATA(5),
    hps_io_hps_io_usb1_inst_D6      => HPS_USB_DATA(6),
    hps_io_hps_io_usb1_inst_D7      => HPS_USB_DATA(7),
    hps_io_hps_io_usb1_inst_CLK     => HPS_USB_CLKOUT,
    hps_io_hps_io_usb1_inst_STP     => HPS_USB_STP,
    hps_io_hps_io_usb1_inst_DIR     => HPS_USB_DIR,
    hps_io_hps_io_usb1_inst_NXT     => HPS_USB_NXT,
    -- HPS SPI Master
    hps_io_hps_io_spim1_inst_CLK    => HPS_SPIM_CLK,
    hps_io_hps_io_spim1_inst_MOSI   => HPS_SPIM_MOSI,
    hps_io_hps_io_spim1_inst_MISO   => HPS_SPIM_MISO,
    hps_io_hps_io_spim1_inst_SS0    => HPS_SPIM_SS,
    -- HPS UART 
    hps_io_hps_io_uart0_inst_RX     => HPS_UART_RX,
    hps_io_hps_io_uart0_inst_TX     => HPS_UART_TX,
    -- HPS I2C0
    hps_io_hps_io_i2c0_inst_SDA     => HPS_I2C0_SDAT,
    hps_io_hps_io_i2c0_inst_SCL     => HPS_I2C0_SCLK,
    -- HPS I2C1
    hps_io_hps_io_i2c1_inst_SDA     => HPS_I2C1_SDAT,
    hps_io_hps_io_i2c1_inst_SCL     => HPS_I2C1_SCLK,
    -- HPS GIO
    hps_io_hps_io_gpio_inst_GPIO09  => HPS_CONV_USB_N,
    hps_io_hps_io_gpio_inst_GPIO35  => HPS_ENET_INT_N,
    hps_io_hps_io_gpio_inst_GPIO40  => HPS_LTC_GPIO,
    hps_io_hps_io_gpio_inst_GPIO53  => HPS_LED,
    hps_io_hps_io_gpio_inst_GPIO54  => HPS_KEY,
    hps_io_hps_io_gpio_inst_GPIO61  => HPS_GSENSOR_INT,
    hps_0_h2f_reset_reset_n         => reset
  );

end behavioral;