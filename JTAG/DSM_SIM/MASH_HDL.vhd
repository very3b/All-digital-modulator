-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\MASH_HDL\MASH_HDL.vhd
-- Created: 2018-01-07 05:13:35
-- 
-- Generated by MATLAB 8.2 and HDL Coder 3.3
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 3.33333e-07
-- Target subsystem base rate: 3.33333e-07
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        3.33333e-07
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- Modulator_output              ce_out        3.33333e-07
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: MASH_HDL
-- Source Path: MASH_HDL
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY MASH_HDL IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        In1                               :   IN    std_logic_vector(35 DOWNTO 0);  -- sfix36_En25
        ce_out                            :   OUT   std_logic;
        Modulator_output                  :   OUT   std_logic_vector(35 DOWNTO 0)  -- sfix36_En25
        );
END MASH_HDL;


ARCHITECTURE rtl OF MASH_HDL IS

  -- Component Declarations
  COMPONENT MATLAB_Function
    PORT( quant_in                        :   IN    std_logic_vector(35 DOWNTO 0);  -- sfix36_En25
          quant_out                       :   OUT   std_logic_vector(35 DOWNTO 0)  -- sfix36_En25
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : MATLAB_Function
    USE ENTITY work.MATLAB_Function(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL Digital_PCM_signal               : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Delay_out1                       : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Gain_cast                        : signed(71 DOWNTO 0);  -- sfix72_En58
  SIGNAL Gain_out1                        : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Modulator_output_stage_1_signed  : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Sigma                            : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Sum2_out1                        : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Delay1_out1                      : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Sum1_out1                        : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Add_add_temp                     : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Modulator_input                  : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Modulator_output_stage_1         : std_logic_vector(35 DOWNTO 0);  -- ufix36
  SIGNAL Delay4_out1                      : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Gain3_mul_temp                   : signed(71 DOWNTO 0);  -- sfix72_En61
  SIGNAL Gain3_out1                       : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Gain2_cast                       : signed(71 DOWNTO 0);  -- sfix72_En58
  SIGNAL Gain2_out1                       : signed(33 DOWNTO 0);  -- sfix34_En23
  SIGNAL Sum6_sub_cast                    : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Stage_1_output                   : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Delay2_out1                      : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Gain1_cast                       : signed(71 DOWNTO 0);  -- sfix72_En58
  SIGNAL Gain1_out1                       : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Quantizer_signed                 : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Sigma_1                          : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Sum5_out1                        : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Delay3_out1                      : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Sum4_out1                        : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Add1_add_temp                    : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Modulator_input_1                : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Quantizer                        : std_logic_vector(35 DOWNTO 0);  -- ufix36
  SIGNAL Delay6_out1                      : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Gain7_cast                       : signed(71 DOWNTO 0);  -- sfix72_En58
  SIGNAL Gain7_out1                       : signed(33 DOWNTO 0);  -- sfix34_En23
  SIGNAL Sum8_sub_cast                    : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Sum8_out1                        : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Gain4_cast                       : signed(71 DOWNTO 0);  -- sfix72_En50
  SIGNAL Gain4_out1                       : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Delay5_out1                      : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Gain5_cast                       : signed(71 DOWNTO 0);  -- sfix72_En50
  SIGNAL Gain5_out1                       : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Sum7_out1                        : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Gain6_cast                       : signed(71 DOWNTO 0);  -- sfix72_En58
  SIGNAL Error_cancellation_filter        : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Delay7_out1                      : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Sum9_out1                        : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Gain8_cast                       : signed(71 DOWNTO 0);  -- sfix72_En50
  SIGNAL Gain8_out1                       : signed(35 DOWNTO 0);  -- sfix36_En25
  SIGNAL Bitstream                        : signed(35 DOWNTO 0);  -- sfix36_En25

BEGIN
  u_MATLAB_Function : MATLAB_Function
    PORT MAP( quant_in => std_logic_vector(Modulator_input),  -- sfix36_En25
              quant_out => Modulator_output_stage_1  -- sfix36_En25
              );

  Digital_PCM_signal <= signed(In1);

  enb <= clk_enable;
  
  Gain_cast <= resize(Delay_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 72);
  Gain_out1 <= Gain_cast(68 DOWNTO 33);

  Sigma <= Digital_PCM_signal - Modulator_output_stage_1_signed;

  Sum2_out1 <= Sigma + Delay_out1;

  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_out1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_out1 <= Sum2_out1;
      END IF;
    END IF;
  END PROCESS Delay_process;


  Sum1_out1 <= Delay_out1 + Delay1_out1;

  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay1_out1 <= Sum1_out1;
      END IF;
    END IF;
  END PROCESS Delay1_process;


  Add_add_temp <= Digital_PCM_signal + Delay1_out1;
  Modulator_input <= Add_add_temp + Gain_out1;

  Modulator_output_stage_1_signed <= signed(Modulator_output_stage_1);

  Delay4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay4_out1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay4_out1 <= Modulator_output_stage_1_signed;
      END IF;
    END IF;
  END PROCESS Delay4_process;


  Gain3_mul_temp <= signed'(X"4CCCCCCCD") * Modulator_output_stage_1_signed;
  Gain3_out1 <= Gain3_mul_temp(71 DOWNTO 36);

  Gain2_cast <= resize(Delay1_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 72);
  Gain2_out1 <= Gain2_cast(68 DOWNTO 35);

  Sum6_sub_cast <= Gain2_out1 & '0' & '0';
  Stage_1_output <= Gain3_out1 - Sum6_sub_cast;
  

  Gain1_cast <= resize(Delay2_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 72);
  Gain1_out1 <= Gain1_cast(68 DOWNTO 33);

  Sigma_1 <= Stage_1_output - Quantizer_signed;

  Sum5_out1 <= Sigma_1 + Delay2_out1;

  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_out1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay2_out1 <= Sum5_out1;
      END IF;
    END IF;
  END PROCESS Delay2_process;


  Sum4_out1 <= Delay2_out1 + Delay3_out1;

  Delay3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_out1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay3_out1 <= Sum4_out1;
      END IF;
    END IF;
  END PROCESS Delay3_process;


  Add1_add_temp <= Stage_1_output + Delay3_out1;
  Modulator_input_1 <= Add1_add_temp + Gain1_out1;

  Quantizer_signed <= signed(Quantizer);

  Delay6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay6_out1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay6_out1 <= Quantizer_signed;
      END IF;
    END IF;
  END PROCESS Delay6_process;


  Gain7_cast <= resize(Delay6_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 72);
  Gain7_out1 <= Gain7_cast(68 DOWNTO 35);

  Sum8_sub_cast <= Gain7_out1 & '0' & '0';
  Sum8_out1 <= Quantizer_signed - Sum8_sub_cast;

  Gain4_cast <= resize(Delay4_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 72);
  Gain4_out1 <= Gain4_cast(60 DOWNTO 25);

  Delay5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay5_out1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay5_out1 <= Delay4_out1;
      END IF;
    END IF;
  END PROCESS Delay5_process;


  Gain5_cast <= resize(Delay5_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 72);
  Gain5_out1 <= Gain5_cast(60 DOWNTO 25);

  Sum7_out1 <= Gain4_out1 + Gain5_out1;

  Gain6_cast <= resize(Sum7_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 72);
  Error_cancellation_filter <= Gain6_cast(68 DOWNTO 33);

  Delay7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay7_out1 <= to_signed(0, 36);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay7_out1 <= Delay6_out1;
      END IF;
    END IF;
  END PROCESS Delay7_process;


  Sum9_out1 <= Sum8_out1 + Delay7_out1;

  Gain8_cast <= resize(Sum9_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 72);
  Gain8_out1 <= Gain8_cast(60 DOWNTO 25);

  Bitstream <= Error_cancellation_filter - Gain8_out1;

  Modulator_output <= std_logic_vector(Bitstream);

  ce_out <= clk_enable;

END rtl;

