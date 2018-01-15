-- -------------------------------------------------------------
-- 
-- File Name: hdlsrc\dsm_fpga_mod4\MATLAB_Function.vhd
-- Created: 2017-12-27 18:43:17
-- 
-- Generated by MATLAB 9.3 and HDL Coder 3.11
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: MATLAB_Function
-- Source Path: dsm_fpga_mod4/Fourth_order_delta_sigma_modulator/MATLAB Function
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY MATLAB_Function IS
  PORT( u                                 :   IN    std_logic_vector(35 DOWNTO 0);  -- sfix36_En32
        y                                 :   OUT   std_logic_vector(35 DOWNTO 0)  -- sfix36_En32
        );
END MATLAB_Function;


ARCHITECTURE rtl OF MATLAB_Function IS

  -- Signals
  SIGNAL u_signed                         : signed(35 DOWNTO 0);  -- sfix36_En32
  SIGNAL y_tmp                            : signed(35 DOWNTO 0);  -- sfix36_En32

BEGIN
  u_signed <= signed(u);

  -- nLev=64;
  -- st=fi(nLev-2,1,36,28);
  -- y=fi(1,1,36,28);
  -- for n=1:nLev-2
  --     k=fi(n,1,36,28);
  --     if u < -st
  --         y=fi(-nLev+1,1,36,28);
  --         break;
  --     elseif u > st
  --         y=fi(nLev-1,1,36,28);
  --         break;
  --     elseif u >= -nLev + 2*k && u <= -nLev + 2*(k+1)
  --         y=fi(2*k-1-nLev,1,36,28);
  --         break;
  --     end
  -- end
  -- 2-level
  --y = -1;
  --y = 1;
  
  y_tmp <= signed'(X"F00000000") WHEN u_signed < to_signed(0, 36) ELSE
      signed'(X"100000000");
  -- 4-level
  -- if u < -2
  --     y = fi(-3,1,36,28);
  -- elseif u > -2 && u < 0
  --     y = fi(-1,1,36,28);
  -- elseif u >= 0 && u < 2
  --     y = fi(1,1,36,28);
  -- else
  --     y = fi(3,1,36,28);
  -- end
  -- 64-level
  -- if u < -62
  --     y = fi(-63,1,36,28);
  -- elseif u >= -62 && u < -60
  --     y = fi(-61,1,36,28);
  -- elseif u >= -60 && u < -58
  --     y = fi(-59,1,36,28);
  -- elseif u >= -58 && u < -56
  --     y = fi(-57,1,36,28);
  -- elseif u >= -56 && u < -54
  --     y = fi(-55,1,36,28);
  -- elseif u >= -54 && u < -52
  --     y = fi(-53,1,36,28);
  -- elseif u >= -52 && u < -50
  --     y = fi(-51,1,36,28);
  -- elseif u >= -50 && u < -48
  --     y = fi(-49,1,36,28);
  -- elseif u >= -48 && u < -46
  --     y = fi(-47,1,36,28);
  -- elseif u >= -46 && u < -44
  --     y = fi(-45,1,36,28);
  -- elseif u >= -44 && u < -42
  --     y = fi(-43,1,36,28);
  -- elseif u >= -42 && u < -40
  --     y = fi(-41,1,36,28);
  -- elseif u >= -40 && u < -38
  --     y = fi(-39,1,36,28);
  -- elseif u >= -38 && u < -36
  --     y = fi(-37,1,36,28);
  -- elseif u >= -36 && u < -34
  --     y = fi(-35,1,36,28);
  -- elseif u >= -34 && u < -32
  --     y = fi(-33,1,36,28);
  -- elseif u >= -32 && u < -30
  --     y = fi(-31,1,36,28);
  -- elseif u >= -30 && u < -28
  --     y = fi(-29,1,36,28);
  -- elseif u >= -28 && u < -26
  --     y = fi(-27,1,36,28);
  -- elseif u >= -26 && u < -24
  --     y = fi(-25,1,36,28);
  -- elseif u >= -24 && u < -22
  --     y = fi(-23,1,36,28);
  -- elseif u >= -22 && u < -20
  --     y = fi(-21,1,36,28);
  -- elseif u >= -20 && u < -18
  --     y = fi(-19,1,36,28);
  -- elseif u >= -18 && u < -16
  --     y = fi(-17,1,36,28);
  -- elseif u >= -16 && u < -14
  --     y = fi(-15,1,36,28);
  -- elseif u >= -14 && u < -12
  --     y = fi(-13,1,36,28);
  -- elseif u >= -12 && u < -10
  --     y = fi(-11,1,36,28);
  -- elseif u >= -10 && u < -8
  --     y = fi(-9,1,36,28);
  -- elseif u >= -8 && u < -6
  --     y = fi(-7,1,36,28);
  -- elseif u >= -6 && u < -4
  --     y = fi(-5,1,36,28);
  -- elseif u >= -4 && u < -2
  --     y = fi(-3,1,36,28);
  -- elseif u >= -2 && u < 0
  --     y = fi(-1,1,36,28);
  -- elseif u >= 0 && u < 2
  --     y = fi(1,1,36,28);
  -- elseif u >= 2 && u < 4
  --     y = fi(3,1,36,28);
  -- elseif u >= 4 && u < 6
  --     y = fi(5,1,36,28);
  -- elseif u >= 6 && u < 8
  --     y = fi(7,1,36,28);
  -- elseif u >= 8 && u < 10
  --     y = fi(9,1,36,28);
  -- elseif u >= 10 && u < 12
  --     y = fi(11,1,36,28);
  -- elseif u >= 12 && u < 14
  --     y = fi(13,1,36,28);
  -- elseif u >= 14 && u < 16
  --     y = fi(15,1,36,28);
  -- elseif u >= 16 && u < 18
  --     y = fi(17,1,36,28);
  -- elseif u >= 18 && u < 20
  --     y = fi(19,1,36,28);
  -- elseif u >= 20 && u < 22
  --     y = fi(21,1,36,28);
  -- elseif u >= 22 && u < 24
  --     y = fi(23,1,36,28);
  -- elseif u >= 24 && u < 26
  --     y = fi(25,1,36,28);
  -- elseif u >= 26 && u < 28
  --     y = fi(27,1,36,28);
  -- elseif u >= 28 && u < 30
  --     y = fi(29,1,36,28);
  -- elseif u >= 30 && u < 32
  --     y = fi(31,1,36,28);
  -- elseif u >= 32 && u < 34
  --     y = fi(33,1,36,28);
  -- elseif u >= 34 && u < 36
  --     y = fi(35,1,36,28);
  -- elseif u >= 36 && u < 38
  --     y = fi(37,1,36,28);
  -- elseif u >= 38 && u < 40
  --     y = fi(39,1,36,28);
  -- elseif u >= 40 && u < 42
  --     y = fi(41,1,36,28);
  -- elseif u >= 42 && u < 44
  --     y = fi(43,1,36,28);
  -- elseif u >= 44 && u < 46
  --     y = fi(45,1,36,28);
  -- elseif u >= 46 && u < 48
  --     y = fi(47,1,36,28);
  -- elseif u >= 48 && u < 50
  --     y = fi(49,1,36,28);
  -- elseif u >= 50 && u < 52
  --     y = fi(51,1,36,28);
  -- elseif u >= 52 && u < 54
  --     y = fi(53,1,36,28);
  -- elseif u >= 54 && u < 56
  --     y = fi(55,1,36,28);
  -- elseif u >= 56 && u < 58
  --     y = fi(57,1,36,28);
  -- elseif u >= 58 && u < 60
  --     y = fi(59,1,36,28);
  -- elseif u >= 60 && u < 62
  --     y = fi(61,1,36,28);
  -- else % u > 62
  --     y = fi(63,1,36,28);
  -- end
  -- 32-level
  -- if u < -30
  --     y = fi(-31,1,36,28);
  -- elseif u >= -30 && u < -28
  --     y = fi(-29,1,36,28);
  -- elseif u >= -28 && u < -26
  --     y = fi(-27,1,36,28);
  -- elseif u >= -26 && u < -24
  --     y = fi(-25,1,36,28);
  -- elseif u >= -24 && u < -22
  --     y = fi(-23,1,36,28);
  -- elseif u >= -22 && u < -20
  --     y = fi(-21,1,36,28);
  -- elseif u >= -20 && u < -18
  --     y = fi(-19,1,36,28);
  -- elseif u >= -18 && u < -16
  --     y = fi(-17,1,36,28);
  -- elseif u >= -16 && u < -14
  --     y = fi(-15,1,36,28);
  -- elseif u >= -14 && u < -12
  --     y = fi(-13,1,36,28);
  -- elseif u >= -12 && u < -10
  --     y = fi(-11,1,36,28);
  -- elseif u >= -10 && u < -8
  --     y = fi(-9,1,36,28);
  -- elseif u >= -8 && u < -6
  --     y = fi(-7,1,36,28);
  -- elseif u >= -6 && u < -4
  --     y = fi(-5,1,36,28);
  -- elseif u >= -4 && u < -2
  --     y = fi(-3,1,36,28);
  -- elseif u >= -2 && u < 0
  --     y = fi(-1,1,36,28);
  -- elseif u >= 0 && u < 2
  --     y = fi(1,1,36,28);
  -- elseif u >= 2 && u < 4
  --     y = fi(3,1,36,28);
  -- elseif u >= 4 && u < 6
  --     y = fi(5,1,36,28);
  -- elseif u >= 6 && u < 8
  --     y = fi(7,1,36,28);
  -- elseif u >= 8 && u < 10
  --     y = fi(9,1,36,28);
  -- elseif u >= 10 && u < 12
  --     y = fi(11,1,36,28);
  -- elseif u >= 12 && u < 14
  --     y = fi(13,1,36,28);
  -- elseif u >= 14 && u < 16
  --     y = fi(15,1,36,28);
  -- elseif u >= 16 && u < 18
  --     y = fi(17,1,36,28);
  -- elseif u >= 18 && u < 20
  --     y = fi(19,1,36,28);
  -- elseif u >= 20 && u < 22
  --     y = fi(21,1,36,28);
  -- elseif u >= 22 && u < 24
  --     y = fi(23,1,36,28);
  -- elseif u >= 24 && u < 26
  --     y = fi(25,1,36,28);
  -- elseif u >= 26 && u < 28
  --     y = fi(27,1,36,28);
  -- elseif u >= 28 && u < 30
  --     y = fi(29,1,36,28);
  -- else % u > 30
  --     y = fi(31,1,36,28);
  -- end

  y <= std_logic_vector(y_tmp);

END rtl;
