----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:50:27 12/27/2017 
-- Design Name: 
-- Module Name:    all_digital_modulator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------W
use work.fixed_pkg.all;

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity all_digital_modulator is
	Generic (
		GEN_DIGITAL_UP_CONVERTER_EN : boolean := true
	);
	Port ( 
		sys_clk : in  STD_LOGIC;
		sys_rst_n : in  STD_LOGIC;
		bypass : in  STD_LOGIC := '0';
		DAC_IN : in  STD_LOGIC_VECTOR (33 downto 0);
		DAC_OUT : out  STD_LOGIC_VECTOR (33 downto 0);
		DAC_OUT1 : out  STD_LOGIC_VECTOR (33 downto 0);
		DAC_OUT2 : out  STD_LOGIC_VECTOR (33 downto 0);
		DAC_OUT3 : out  STD_LOGIC_VECTOR (33 downto 0);
		DAC_OUT4 : out  STD_LOGIC_VECTOR (33 downto 0);
		DAC_OUT5 : out  STD_LOGIC_VECTOR (35 downto 0);
		DSM_OUT : out  STD_LOGIC_VECTOR (1 downto 0);
		DSM_OUT1 : out  STD_LOGIC_VECTOR (1 downto 0)
	);
end all_digital_modulator;

architecture Behavioral of all_digital_modulator is

	component PLL_CLOCK
		port (
			CLKIN1_IN    : in    std_logic; 
			CLKFBOUT_OUT : out   std_logic; 
			CLKOUT0_OUT  : out   std_logic; 
			CLKOUT1_OUT  : out   std_logic; 
			CLKOUT2_OUT  : out   std_logic
		);
	end component;

	component Clock_Generator_1
	port (
		-- Clock in ports
		CLK_IN1           : in     std_logic;
		-- Clock out ports
		CLK_OUT1          : out    std_logic;
		CLK_OUT2          : out    std_logic
	);
	end component;
	
	COMPONENT dds
	PORT (
		clk : IN STD_LOGIC;
		sine : OUT STD_LOGIC_VECTOR(25 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT top_level_ddfs
		port (
			clk, rst_n : in std_logic;
			ddfs_function_type : in std_logic_vector(3 downto 0);
			ddfs_function_out : out std_logic_vector(33 downto 0)
		);
	END COMPONENT;
	
	component Channel_Filter
		port (
		clk: in std_logic;
		rfd: out std_logic;
		rdy: out std_logic;
		din: in std_logic_vector(33 downto 0);
		dout: out std_logic_vector(33 downto 0));
	end component;
	
	component Halfband_1_61_44
		port (
			clk: in std_logic;
			rfd: out std_logic;
			rdy: out std_logic;
			din: in std_logic_vector(33 downto 0);
			dout: out std_logic_vector(33 downto 0)
		);
	end component;
	
	component Halfband_2_122_88
		port (
			clk: in std_logic;
			rfd: out std_logic;
			rdy: out std_logic;
			din: in std_logic_vector(33 downto 0);
			dout: out std_logic_vector(33 downto 0)
		);
	end component;
	
	component Halfband_3_245_76
		port (
			clk: in std_logic;
			rfd: out std_logic;
			rdy: out std_logic;
			din: in std_logic_vector(33 downto 0);
			dout: out std_logic_vector(33 downto 0)
		);
	end component;
	
	component Halfband_4_491_52
		PORT (
			clk                             :   IN    std_logic; 
			clk_enable                      :   IN    std_logic; 
			reset                           :   IN    std_logic; 
			filter_in                       :   IN    std_logic_vector(33 DOWNTO 0); -- sfix34_En31
			filter_out                      :   OUT   std_logic_vector(35 DOWNTO 0); -- sfix36_En32
			ce_out                          :   OUT   std_logic  
		);
	end component;
	
	component Fourth_order_delta_sigma_modulator
	  PORT( clk                               :   IN    std_logic;
			  reset                             :   IN    std_logic;
			  clk_enable                        :   IN    std_logic;
			  In1                               :   IN    std_logic_vector(35 DOWNTO 0);  -- sfix36_En32
			  ce_out                            :   OUT   std_logic;
			  Out1                              :   OUT   std_logic_vector(1 DOWNTO 0)  -- sfix2
        );
	end component;
	
	component Eight_order_delta_sigma_modulator
	  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        In1                               :   IN    std_logic_vector(35 DOWNTO 0);  -- sfix36_En32
        ce_out                            :   OUT   std_logic;
        Out1                              :   OUT   std_logic_vector(1 DOWNTO 0)  -- sfix2
        );
	end component;

	signal sine : STD_LOGIC_VECTOR(25 DOWNTO 0);
	signal ddfs_mux : STD_LOGIC_VECTOR(33 DOWNTO 0);
	signal full_scale_ddfs_out_slv : STD_LOGIC_VECTOR(33 DOWNTO 0);	
	-- Input clock buffering / unused connectors
	signal clkin1      : std_logic;
	-- Output clock buffering / unused connectors
	signal clkfbout         : std_logic;
	signal clkfbout_buf     : std_logic;
	signal clkout0          : std_logic;
	signal clkout1   		  	: std_logic;
	signal clkout2   			: std_logic;
	signal clkout3   			: std_logic;
	signal clkout4   			: std_logic;
	signal clkout5   			: std_logic;
	-- Unused status signals
	signal locked_unused    : std_logic;

	signal sys_rst : std_logic;
	
	signal Baseband_signal_slv : STD_LOGIC_VECTOR(33 DOWNTO 0); 
	signal Channel_Filter_out_slv : STD_LOGIC_VECTOR(33 DOWNTO 0);
	signal Halfband_1_out_slv : STD_LOGIC_VECTOR(33 DOWNTO 0);
	signal Halfband_2_out_slv : STD_LOGIC_VECTOR(33 DOWNTO 0);
	signal Halfband_3_out_slv : STD_LOGIC_VECTOR(33 DOWNTO 0);
	signal Halfband_4_out_slv : STD_LOGIC_VECTOR(35 DOWNTO 0);
	signal Digital_PCM_signal_slv : STD_LOGIC_VECTOR(35 DOWNTO 0);
	signal Modulator_Input_slv : std_logic_vector(35 downto 0);

	signal tone, Baseband_signal: sfixed(3 downto -32);
	signal Channel_Filter_out : sfixed(3 downto -32);
	signal Halfband_1_out: sfixed(3 downto -32);
	signal Halfband_2_out: sfixed(3 downto -32);
	signal Halfband_3_out: sfixed(3 downto -32);
	signal Halfband_4_out: sfixed(3 downto -32);
	signal Digital_PCM_signal: sfixed(3 downto -32);
	signal Modulator_Input: sfixed(3 downto -32);
	
	constant bypass_ddfs : std_logic := '0';
	
begin

	sys_rst <= not sys_rst_n;

	U0 : PLL_CLOCK
	port map (
		-- Clock in ports
		CLKIN1_IN => sys_clk, 	-- 30.720 MHz
		-- Clock out ports
		CLKFBOUT_OUT => open, 
		CLKOUT0_OUT => clkout0, -- 30.720 MHz
		CLKOUT1_OUT => clkout1, -- 61.440 MHz
		CLKOUT2_OUT => clkout2 	-- 122.880 MHz
	);

	-- TODO : If there is a translation error, remove the IBUF from Clock_Generator_1 vhdl file since they are already driven by BUFG at the output of the PLL_CLOCK
	U1 : Clock_Generator_1
	port map (
		-- Clock in ports
		CLK_IN1 => sys_clk, 		-- 30.720 MHz
		-- Clock out ports
		CLK_OUT1 => clkout3, 	-- 245.76 (245.761) MHz
		CLK_OUT2 => clkout4 		-- 491.52 (491.521) MHz
	);
	
	tone <= to_sfixed(std_logic_vector(resize(signed(DAC_IN), 36)), tone);
	ddfs_mux <= std_logic_vector(resize(signed(sine), Baseband_signal_slv'length)) when bypass_ddfs = '0' else full_scale_ddfs_out_slv;
	Baseband_signal_slv <= ddfs_mux when bypass = '0' else DAC_IN;
	Baseband_signal <= to_sfixed(std_logic_vector(resize(signed(Baseband_signal_slv), 36)), Baseband_signal);
	
	GEN_DIGITAL_UP_CONVERTER_LBL : if (GEN_DIGITAL_UP_CONVERTER_EN = true) generate
		U2 : dds
		PORT MAP (
			clk => clkout0,
			sine => sine
		);
		
		U3 : Channel_Filter
		port map (
			clk => clkout0,
			rfd => open,
			rdy => open,
			din => Baseband_signal_slv,
			dout => Channel_Filter_out_slv
		);

		U4 : Halfband_1_61_44
		port map (
			clk => clkout1,
			rfd => open,
			rdy => open,
			din => Channel_Filter_out_slv,
			dout => Halfband_1_out_slv
		);

		U5 : Halfband_2_122_88
		port map (
			clk => clkout2,
			rfd => open,
			rdy => open,
			din => Halfband_1_out_slv,
			dout => Halfband_2_out_slv
		);

		U6 : Halfband_3_245_76
		port map (
			clk => clkout3,
			rfd => open,
			rdy => open,
			din => Halfband_2_out_slv,
			dout => Halfband_3_out_slv
		);
			
		U7 : Halfband_4_491_52
		port map (
			clk => clkout4, 
			clk_enable => '1', 
			reset => sys_rst,  
			filter_in => Halfband_3_out_slv,
			filter_out => Halfband_4_out_slv,
			ce_out => open 
		);
		
		Channel_Filter_out <= to_sfixed(std_logic_vector(resize(signed(Channel_Filter_out_slv), 36)), Channel_Filter_out);
		Halfband_1_out <= to_sfixed(std_logic_vector(resize(signed(Halfband_1_out_slv), 36)), Halfband_1_out);
		Halfband_2_out <= to_sfixed(std_logic_vector(resize(signed(Halfband_2_out_slv), 36)), Halfband_2_out);
		Halfband_3_out <= to_sfixed(std_logic_vector(resize(signed(Halfband_3_out_slv), 36)), Halfband_3_out);
		Halfband_4_out <= to_sfixed(std_logic_vector(resize(signed(Halfband_4_out_slv), 36)), Halfband_4_out);
	end generate GEN_DIGITAL_UP_CONVERTER_LBL;
	
	DAC_OUT <= Baseband_signal_slv;
	DAC_OUT1 <= Channel_Filter_out_slv;
	DAC_OUT2 <= Halfband_1_out_slv;
	DAC_OUT3 <= Halfband_2_out_slv;
	DAC_OUT4 <= Halfband_3_out_slv;
	DAC_OUT5 <= Halfband_4_out_slv;
	
	Digital_PCM_signal_slv <= to_slv(Baseband_signal) when GEN_DIGITAL_UP_CONVERTER_EN = false else Halfband_4_out_slv;
	Digital_PCM_signal <= to_sfixed(Digital_PCM_signal_slv, Digital_PCM_signal);
	Modulator_Input <= shift_left(Digital_PCM_signal, 3);
	Modulator_Input_slv <= to_slv(Digital_PCM_signal);
	
	--	 Fourth-order Delta-Sigma modulator (OSR=16,Fs=491.52(16x30.72))
	U8 : Fourth_order_delta_sigma_modulator
	port map (
		clk => clkout4,
		reset => sys_rst,
		clk_enable => '1',
		In1 => Modulator_Input_slv,
		Out1 => DSM_OUT,
		ce_out => open
	);

	--	 Eigth-order Delta-Sigma modulator (OSR=16,Fs=491.52(16x30.72))
	U9 : Eight_order_delta_sigma_modulator
	port map ( 
		clk => clkout4,
		reset => sys_rst,
		clk_enable => '1',
		In1 => Modulator_Input_slv,
		Out1 => DSM_OUT1,
		ce_out => open
	);

end Behavioral;

