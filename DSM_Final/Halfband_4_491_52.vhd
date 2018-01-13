-- -------------------------------------------------------------
--
-- Module: Halfband_4_491_52
-- Generated by MATLAB(R) 9.3 and Filter Design HDL Coder 3.1.2.
-- Generated on: 2017-12-28 03:32:23
-- -------------------------------------------------------------

-- -------------------------------------------------------------
-- HDL Code Generation Options:
--
-- TargetLanguage: VHDL
-- FIRAdderStyle: tree
-- HDLSynthTool: ISE
-- HDLSynthCmd: xfile add $src_dir/%s\n
-- HDLSynthFilePostfix: _ise.tcl
-- HDLSynthInit: set src_dir [pwd]\nset prj_dir "synprj"\nfile mkdir ../$prj_dir\ncd ../$prj_dir\nproject new %s.xise\nproject set family Virtex4\nproject set device xc4vsx35\nproject set package ff668\nproject set speed -10\n
-- HDLSynthTerm: process run "Synthesize - XST"
-- AddPipelineRegisters: on
-- Name: Halfband_4_491_52
-- TestBenchStimulus: step ramp chirp noise 
-- GenerateHDLTestBench: off

-- -------------------------------------------------------------
-- HDL Implementation    : Fully parallel
-- Folding Factor        : 1
-- -------------------------------------------------------------
-- Filter Settings:
--
-- Discrete-Time FIR Multirate Filter (real)
-- -----------------------------------------
-- Filter Structure      : Direct-Form FIR Polyphase Interpolator
-- Interpolation Factor  : 2
-- Polyphase Length      : 4
-- Filter Length         : 7
-- Stable                : Yes
-- Linear Phase          : Yes (Type 1)
--
-- Arithmetic            : fixed
-- Numerator             : s35,34 -> [-1 1)
-- Input                 : s34,30 -> [-8 8)
-- Filter Internals      : Specify Precision
--   Output              : s36,32 -> [-8 8)
--   Product             : s36,32 -> [-8 8)
--   Accumulator         : s36,32 -> [-8 8)
--   Round Mode          : floor
--   Overflow Mode       : saturate
-- -------------------------------------------------------------



LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.ALL;

ENTITY Halfband_4_491_52 IS
   PORT( clk                             :   IN    std_logic; 
         clk_enable                      :   IN    std_logic; 
         reset                           :   IN    std_logic; 
         filter_in                       :   IN    std_logic_vector(33 DOWNTO 0); -- sfix34_En30
         filter_out                      :   OUT   std_logic_vector(35 DOWNTO 0); -- sfix36_En32
         ce_out                          :   OUT   std_logic  
         );

END Halfband_4_491_52;


----------------------------------------------------------------
--Module Architecture: Halfband_4_491_52
----------------------------------------------------------------
ARCHITECTURE rtl OF Halfband_4_491_52 IS
  -- Local Functions
  -- Type Definitions
  TYPE delay_pipeline_type IS ARRAY (NATURAL range <>) OF signed(33 DOWNTO 0); -- sfix34_En30
  TYPE sumdelay_pipeline_type IS ARRAY (NATURAL range <>) OF signed(35 DOWNTO 0); -- sfix36_En32
  -- Constants
  CONSTANT coeffphase1_1                  : signed(34 DOWNTO 0) := to_signed(-542231507, 35); -- sfix35_En34
  CONSTANT coeffphase1_2                  : signed(34 DOWNTO 0) := (32 => '1', 29 => '1', 22 => '1', 20 => '1', 16 => '1', 14 => '1', 8 DOWNTO 7 => '1', 4 DOWNTO 3 => '1', 0 => '1',  OTHERS => '0'); -- sfix35_En34
  CONSTANT coeffphase1_3                  : signed(34 DOWNTO 0) := (32 => '1', 29 => '1', 22 => '1', 20 => '1', 16 => '1', 14 => '1', 8 DOWNTO 7 => '1', 4 DOWNTO 3 => '1', 0 => '1',  OTHERS => '0'); -- sfix35_En34
  CONSTANT coeffphase1_4                  : signed(34 DOWNTO 0) := to_signed(-542231507, 35); -- sfix35_En34
  CONSTANT coeffphase2_1                  : signed(34 DOWNTO 0) := to_signed(0, 35); -- sfix35_En34
  CONSTANT coeffphase2_2                  : signed(34 DOWNTO 0) := (33 => '1',  OTHERS => '0'); -- sfix35_En34
  CONSTANT coeffphase2_3                  : signed(34 DOWNTO 0) := to_signed(0, 35); -- sfix35_En34
  CONSTANT coeffphase2_4                  : signed(34 DOWNTO 0) := to_signed(0, 35); -- sfix35_En34

  -- Signals
  SIGNAL cur_count                        : unsigned(1 DOWNTO 0); -- ufix2
  SIGNAL phase_1                          : std_logic; -- boolean
  SIGNAL delay_pipeline                   : delay_pipeline_type(0 TO 3); -- sfix34_En30
  SIGNAL product                          : signed(35 DOWNTO 0); -- sfix36_En32
  SIGNAL product_mux                      : signed(34 DOWNTO 0); -- sfix35_En34
  SIGNAL mul_temp                         : signed(68 DOWNTO 0); -- sfix69_En64
  SIGNAL product_1                        : signed(35 DOWNTO 0); -- sfix36_En32
  SIGNAL product_mux_1                    : signed(34 DOWNTO 0); -- sfix35_En34
  SIGNAL mul_temp_1                       : signed(68 DOWNTO 0); -- sfix69_En64
  SIGNAL product_2                        : signed(35 DOWNTO 0); -- sfix36_En32
  SIGNAL product_mux_2                    : signed(34 DOWNTO 0); -- sfix35_En34
  SIGNAL mul_temp_2                       : signed(68 DOWNTO 0); -- sfix69_En64
  SIGNAL product_3                        : signed(35 DOWNTO 0); -- sfix36_En32
  SIGNAL product_mux_3                    : signed(34 DOWNTO 0); -- sfix35_En34
  SIGNAL mul_temp_3                       : signed(68 DOWNTO 0); -- sfix69_En64
  SIGNAL sumvector1                       : sumdelay_pipeline_type(0 TO 1); -- sfix36_En32
  SIGNAL add_temp                         : signed(36 DOWNTO 0); -- sfix37_En32
  SIGNAL add_temp_1                       : signed(36 DOWNTO 0); -- sfix37_En32
  SIGNAL sumdelay_pipeline1               : sumdelay_pipeline_type(0 TO 1); -- sfix36_En32
  SIGNAL sum2                             : signed(35 DOWNTO 0); -- sfix36_En32
  SIGNAL add_temp_2                       : signed(36 DOWNTO 0); -- sfix37_En32
  SIGNAL output_typeconvert               : signed(35 DOWNTO 0); -- sfix36_En32
  SIGNAL output_register                  : signed(35 DOWNTO 0); -- sfix36_En32


BEGIN

  -- Block Statements
  ce_output : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      cur_count <= to_unsigned(0, 2);
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        IF cur_count >= to_unsigned(1, 2) THEN
          cur_count <= to_unsigned(0, 2);
        ELSE
          cur_count <= cur_count + to_unsigned(1, 2);
        END IF;
      END IF;
    END IF; 
  END PROCESS ce_output;

  phase_1 <= '1' WHEN cur_count = to_unsigned(1, 2) AND clk_enable = '1' ELSE '0';

  --   ---------------- Delay Registers ----------------

  Delay_Pipeline_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delay_pipeline(0 TO 3) <= (OTHERS => (OTHERS => '0'));
    ELSIF clk'event AND clk = '1' THEN
      IF phase_1 = '1' THEN
        delay_pipeline(0) <= signed(filter_in);
        delay_pipeline(1 TO 3) <= delay_pipeline(0 TO 2);
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_process;

  product_mux <= coeffphase1_4 WHEN ( cur_count = to_unsigned(0, 2) ) ELSE
                      coeffphase2_4;
  mul_temp <= delay_pipeline(3) * product_mux;
  product <= (35 => '0', OTHERS => '1') WHEN mul_temp(68) = '0' AND mul_temp(67) /= '0'
      ELSE (35 => '1', OTHERS => '0') WHEN mul_temp(68) = '1' AND mul_temp(67) /= '1'
      ELSE (mul_temp(67 DOWNTO 32));

  product_mux_1 <= coeffphase1_3 WHEN ( cur_count = to_unsigned(0, 2) ) ELSE
                        coeffphase2_3;
  mul_temp_1 <= delay_pipeline(2) * product_mux_1;
  product_1 <= (35 => '0', OTHERS => '1') WHEN mul_temp_1(68) = '0' AND mul_temp_1(67) /= '0'
      ELSE (35 => '1', OTHERS => '0') WHEN mul_temp_1(68) = '1' AND mul_temp_1(67) /= '1'
      ELSE (mul_temp_1(67 DOWNTO 32));

  product_mux_2 <= coeffphase1_2 WHEN ( cur_count = to_unsigned(0, 2) ) ELSE
                        coeffphase2_2;
  mul_temp_2 <= delay_pipeline(1) * product_mux_2;
  product_2 <= (35 => '0', OTHERS => '1') WHEN mul_temp_2(68) = '0' AND mul_temp_2(67) /= '0'
      ELSE (35 => '1', OTHERS => '0') WHEN mul_temp_2(68) = '1' AND mul_temp_2(67) /= '1'
      ELSE (mul_temp_2(67 DOWNTO 32));

  product_mux_3 <= coeffphase1_1 WHEN ( cur_count = to_unsigned(0, 2) ) ELSE
                        coeffphase2_1;
  mul_temp_3 <= delay_pipeline(0) * product_mux_3;
  product_3 <= (35 => '0', OTHERS => '1') WHEN mul_temp_3(68) = '0' AND mul_temp_3(67) /= '0'
      ELSE (35 => '1', OTHERS => '0') WHEN mul_temp_3(68) = '1' AND mul_temp_3(67) /= '1'
      ELSE (mul_temp_3(67 DOWNTO 32));

  add_temp <= resize(product, 37) + resize(product_1, 37);
  sumvector1(0) <= (35 => '0', OTHERS => '1') WHEN add_temp(36) = '0' AND add_temp(35) /= '0'
      ELSE (35 => '1', OTHERS => '0') WHEN add_temp(36) = '1' AND add_temp(35) /= '1'
      ELSE (add_temp(35 DOWNTO 0));

  add_temp_1 <= resize(product_2, 37) + resize(product_3, 37);
  sumvector1(1) <= (35 => '0', OTHERS => '1') WHEN add_temp_1(36) = '0' AND add_temp_1(35) /= '0'
      ELSE (35 => '1', OTHERS => '0') WHEN add_temp_1(36) = '1' AND add_temp_1(35) /= '1'
      ELSE (add_temp_1(35 DOWNTO 0));

  sumdelay_pipeline_process1 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      sumdelay_pipeline1 <= (OTHERS => (OTHERS => '0'));
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        sumdelay_pipeline1(0 TO 1) <= sumvector1(0 TO 1);
      END IF;
    END IF; 
  END PROCESS sumdelay_pipeline_process1;

  add_temp_2 <= resize(sumdelay_pipeline1(0), 37) + resize(sumdelay_pipeline1(1), 37);
  sum2 <= (35 => '0', OTHERS => '1') WHEN add_temp_2(36) = '0' AND add_temp_2(35) /= '0'
      ELSE (35 => '1', OTHERS => '0') WHEN add_temp_2(36) = '1' AND add_temp_2(35) /= '1'
      ELSE (add_temp_2(35 DOWNTO 0));

  output_typeconvert <= sum2;

  Output_Register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      output_register <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        output_register <= output_typeconvert;
      END IF;
    END IF; 
  END PROCESS Output_Register_process;

  -- Assignment Statements
  ce_out <= phase_1;
  filter_out <= std_logic_vector(output_register);
END rtl;
