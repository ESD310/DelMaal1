--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2024.1.2 (win64) Build 5164865 Thu Sep  5 14:37:11 MDT 2024
--Date        : Tue Nov 12 14:02:05 2024
--Host        : AxelsPC running 64-bit major release  (build 9200)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    TOF_out : out STD_LOGIC_VECTOR ( 12 downto 0 );
    TOF_ready : out STD_LOGIC;
    Vaux4_v_n : in STD_LOGIC;
    Vaux4_v_p : in STD_LOGIC;
    clk12MHz : out STD_LOGIC;
    clk_12MHz : in STD_LOGIC;
    drdy_Out : out STD_LOGIC;
    drdy_latch : out STD_LOGIC;
    start : in STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    Vaux4_v_n : in STD_LOGIC;
    Vaux4_v_p : in STD_LOGIC;
    clk_12MHz : in STD_LOGIC;
    start : in STD_LOGIC;
    TOF_out : out STD_LOGIC_VECTOR ( 12 downto 0 );
    TOF_ready : out STD_LOGIC;
    drdy_latch : out STD_LOGIC;
    drdy_Out : out STD_LOGIC;
    clk12MHz : out STD_LOGIC
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      TOF_out(12 downto 0) => TOF_out(12 downto 0),
      TOF_ready => TOF_ready,
      Vaux4_v_n => Vaux4_v_n,
      Vaux4_v_p => Vaux4_v_p,
      clk12MHz => clk12MHz,
      clk_12MHz => clk_12MHz,
      drdy_Out => drdy_Out,
      drdy_latch => drdy_latch,
      start => start
    );
end STRUCTURE;
