--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2024.1.2 (win64) Build 5164865 Thu Sep  5 14:37:11 MDT 2024
--Date        : Tue Nov 12 12:11:53 2024
--Host        : AxelsPC running 64-bit major release  (build 9200)
--Command     : generate_target design_1.bd
--Design      : design_1
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1 is
  port (
    TOF_out : out STD_LOGIC_VECTOR ( 12 downto 0 );
    TOF_ready : out STD_LOGIC;
    Vaux4_v_n : in STD_LOGIC;
    Vaux4_v_p : in STD_LOGIC;
    clk100M : out STD_LOGIC;
    clkOut : out STD_LOGIC;
    clk_12MHz : in STD_LOGIC;
    drdy_Out : out STD_LOGIC;
    drdy_latch : out STD_LOGIC;
    start : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_1 : entity is "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=7,numReposBlks=7,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=3,numPkgbdBlks=0,bdsource=USER,synth_mode=None}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of design_1 : entity is "design_1.hwdef";
end design_1;

architecture STRUCTURE of design_1 is
  component design_1_xadc_wiz_0_0 is
  port (
    di_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    daddr_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    den_in : in STD_LOGIC;
    dwe_in : in STD_LOGIC;
    drdy_out : out STD_LOGIC;
    do_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    dclk_in : in STD_LOGIC;
    vp_in : in STD_LOGIC;
    vn_in : in STD_LOGIC;
    vauxp4 : in STD_LOGIC;
    vauxn4 : in STD_LOGIC;
    channel_out : out STD_LOGIC_VECTOR ( 4 downto 0 );
    eoc_out : out STD_LOGIC;
    alarm_out : out STD_LOGIC;
    eos_out : out STD_LOGIC;
    busy_out : out STD_LOGIC
  );
  end component design_1_xadc_wiz_0_0;
  component design_1_Shifter_0_0 is
  port (
    d_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    d_out : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  end component design_1_Shifter_0_0;
  component design_1_xlconstant_0_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 6 downto 0 )
  );
  end component design_1_xlconstant_0_0;
  component design_1_clk_wiz_0_0 is
  port (
    clk_in1 : in STD_LOGIC;
    clk_out1 : out STD_LOGIC
  );
  end component design_1_clk_wiz_0_0;
  component design_1_Correlator_TOF_0_0 is
  port (
    clk : in STD_LOGIC;
    start : in STD_LOGIC;
    Sample : in STD_LOGIC_VECTOR ( 11 downto 0 );
    sample_ready : in STD_LOGIC;
    samples_to_run : in STD_LOGIC_VECTOR ( 15 downto 0 );
    TOF_out : out STD_LOGIC_VECTOR ( 12 downto 0 );
    TOF_ready : out STD_LOGIC
  );
  end component design_1_Correlator_TOF_0_0;
  component design_1_SignalLatch_0_0 is
  port (
    clk_12M : in STD_LOGIC;
    drdy_in : in STD_LOGIC;
    drdy_latch : out STD_LOGIC
  );
  end component design_1_SignalLatch_0_0;
  component design_1_xlconstant_1_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  end component design_1_xlconstant_1_0;
  signal Correlator_TOF_0_TOF_out : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal Correlator_TOF_0_TOF_ready : STD_LOGIC;
  signal Shifter_0_d_out : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal SignalLatch_0_drdy_latch : STD_LOGIC;
  signal Vaux4_1_V_N : STD_LOGIC;
  signal Vaux4_1_V_P : STD_LOGIC;
  signal clk_12MHz_1 : STD_LOGIC;
  signal clk_wiz_0_clk_out1 : STD_LOGIC;
  signal start_1 : STD_LOGIC;
  signal xadc_wiz_0_do_out : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal xadc_wiz_0_drdy_out : STD_LOGIC;
  signal xadc_wiz_0_eoc_out : STD_LOGIC;
  signal xlconstant_0_dout : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal xlconstant_1_dout : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_xadc_wiz_0_alarm_out_UNCONNECTED : STD_LOGIC;
  signal NLW_xadc_wiz_0_busy_out_UNCONNECTED : STD_LOGIC;
  signal NLW_xadc_wiz_0_eos_out_UNCONNECTED : STD_LOGIC;
  signal NLW_xadc_wiz_0_channel_out_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of Vaux4_v_n : signal is "xilinx.com:interface:diff_analog_io:1.0 Vaux4 V_N";
  attribute X_INTERFACE_INFO of Vaux4_v_p : signal is "xilinx.com:interface:diff_analog_io:1.0 Vaux4 V_P";
  attribute X_INTERFACE_INFO of clk_12MHz : signal is "xilinx.com:signal:clock:1.0 CLK.CLK_12MHZ CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk_12MHz : signal is "XIL_INTERFACENAME CLK.CLK_12MHZ, CLK_DOMAIN design_1_clk_12MHz, FREQ_HZ 12000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0";
begin
  TOF_out(12 downto 0) <= Correlator_TOF_0_TOF_out(12 downto 0);
  TOF_ready <= Correlator_TOF_0_TOF_ready;
  Vaux4_1_V_N <= Vaux4_v_n;
  Vaux4_1_V_P <= Vaux4_v_p;
  clk100M <= clk_wiz_0_clk_out1;
  clkOut <= clk_12MHz_1;
  clk_12MHz_1 <= clk_12MHz;
  drdy_Out <= xadc_wiz_0_drdy_out;
  drdy_latch <= SignalLatch_0_drdy_latch;
  start_1 <= start;
Correlator_TOF_0: component design_1_Correlator_TOF_0_0
     port map (
      Sample(11 downto 0) => Shifter_0_d_out(11 downto 0),
      TOF_out(12 downto 0) => Correlator_TOF_0_TOF_out(12 downto 0),
      TOF_ready => Correlator_TOF_0_TOF_ready,
      clk => clk_12MHz_1,
      sample_ready => SignalLatch_0_drdy_latch,
      samples_to_run(15 downto 0) => xlconstant_1_dout(15 downto 0),
      start => start_1
    );
Shifter_0: component design_1_Shifter_0_0
     port map (
      d_in(15 downto 0) => xadc_wiz_0_do_out(15 downto 0),
      d_out(11 downto 0) => Shifter_0_d_out(11 downto 0)
    );
SignalLatch_0: component design_1_SignalLatch_0_0
     port map (
      clk_12M => clk_12MHz_1,
      drdy_in => xadc_wiz_0_drdy_out,
      drdy_latch => SignalLatch_0_drdy_latch
    );
clk_wiz_0: component design_1_clk_wiz_0_0
     port map (
      clk_in1 => clk_12MHz_1,
      clk_out1 => clk_wiz_0_clk_out1
    );
xadc_wiz_0: component design_1_xadc_wiz_0_0
     port map (
      alarm_out => NLW_xadc_wiz_0_alarm_out_UNCONNECTED,
      busy_out => NLW_xadc_wiz_0_busy_out_UNCONNECTED,
      channel_out(4 downto 0) => NLW_xadc_wiz_0_channel_out_UNCONNECTED(4 downto 0),
      daddr_in(6 downto 0) => xlconstant_0_dout(6 downto 0),
      dclk_in => clk_wiz_0_clk_out1,
      den_in => xadc_wiz_0_eoc_out,
      di_in(15 downto 0) => B"0000000000000000",
      do_out(15 downto 0) => xadc_wiz_0_do_out(15 downto 0),
      drdy_out => xadc_wiz_0_drdy_out,
      dwe_in => '0',
      eoc_out => xadc_wiz_0_eoc_out,
      eos_out => NLW_xadc_wiz_0_eos_out_UNCONNECTED,
      vauxn4 => Vaux4_1_V_N,
      vauxp4 => Vaux4_1_V_P,
      vn_in => '0',
      vp_in => '0'
    );
xlconstant_0: component design_1_xlconstant_0_0
     port map (
      dout(6 downto 0) => xlconstant_0_dout(6 downto 0)
    );
xlconstant_1: component design_1_xlconstant_1_0
     port map (
      dout(15 downto 0) => xlconstant_1_dout(15 downto 0)
    );
end STRUCTURE;
