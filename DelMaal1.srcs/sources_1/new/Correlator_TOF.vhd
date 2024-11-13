----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2024 08:51:06 AM
-- Design Name: 
-- Module Name: Correlator_TOF - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Correlator_TOF is
    generic (
        input_size : positive := 200;
        word_size : positive := 12
    );
    Port ( 
            clk : in STD_LOGIC; -- 12 MHz clock
            start : in STD_LOGIC;
            Sample : in STD_LOGIC_VECTOR (word_size-1 downto 0);
            sample_ready : in STD_LOGIC;
            samples_to_run : in STD_LOGIC_VECTOR (15 downto 0);
            TOF_out : out STD_LOGIC_VECTOR (12 downto 0);
            TOF_ready : out STD_LOGIC);
end Correlator_TOF;

architecture Behavioral of Correlator_TOF is
    type xcorr_states is (shift,multiply_1, multiply_2, summize_1, summize_2, compare,wait_4_idle, idle, stopped); -- de states
    type sample_shift_register  is array (0 to input_size-1) of std_logic_vector(word_size-1 downto 0); -- Den som kan holdes vores samples
    type xcorr_temp_result is array (0 to input_size -1) of unsigned(2*word_size-1 downto 0); --kan optimeres til log2(a*b)
    
    
    constant init_sample_shift_register : sample_shift_register := (
        0 => x"800", 
        1 => x"8c8", 2 => x"95b", 3 => x"98f", 4 => x"958", 5 => x"8c4", 6 => x"7fb", 7 => x"733", 8 => x"6a2", 9 => x"670", 10 => x"6a9", 
        11 => x"73e", 12 => x"808", 13 => x"8cf", 14 => x"95f", 15 => x"98f", 16 => x"954", 17 => x"8bd", 18 => x"7f3", 19 => x"72c", 20 => x"69e", 
        21 => x"670", 22 => x"6ad", 23 => x"746", 24 => x"811", 25 => x"8d7", 26 => x"963", 27 => x"98f", 28 => x"94f", 29 => x"8b5", 30 => x"7ea", 
        31 => x"725", 32 => x"69a", 33 => x"670", 34 => x"6b2", 35 => x"74e", 36 => x"819", 37 => x"8de", 38 => x"967", 39 => x"98f", 40 => x"94b", 
        41 => x"8ae", 42 => x"7e1", 43 => x"71d", 44 => x"696", 45 => x"671", 46 => x"6b7", 47 => x"755", 48 => x"822", 49 => x"8e5", 50 => x"96a", 
        51 => x"98e", 52 => x"946", 53 => x"8a6", 54 => x"7d9", 55 => x"716", 56 => x"693", 57 => x"672", 58 => x"6bc", 59 => x"75d", 60 => x"82a", 
        61 => x"8ec", 62 => x"96e", 63 => x"98d", 64 => x"941", 65 => x"89e", 66 => x"7d0", 67 => x"710", 68 => x"68f", 69 => x"673", 70 => x"6c1", 
        71 => x"765", 72 => x"833", 73 => x"8f3", 74 => x"971", 75 => x"98c", 76 => x"93c", 77 => x"896", 78 => x"7c8", 79 => x"709", 80 => x"68c", 
        81 => x"674", 82 => x"6c6", 83 => x"76d", 84 => x"83b", 85 => x"8fa", 86 => x"974", 87 => x"98b", 88 => x"936", 89 => x"88e", 90 => x"7bf", 
        91 => x"702", 92 => x"689", 93 => x"675", 94 => x"6cb", 95 => x"775", 96 => x"844", 97 => x"900", 98 => x"977", 99 => x"989", 100 => x"931", 
        101 => x"886", 102 => x"7b7", 103 => x"6fb", 104 => x"686", 105 => x"677", 106 => x"6d1", 107 => x"77d", 108 => x"84c", 109 => x"907", 110 => x"97a", 
        111 => x"988", 112 => x"92b", 113 => x"87e", 114 => x"7af", 115 => x"6f5", 116 => x"683", 117 => x"678", 118 => x"6d7", 119 => x"785", 120 => x"855", 
        121 => x"90d", 122 => x"97d", 123 => x"986", 124 => x"925", 125 => x"876", 126 => x"7a6", 127 => x"6ef", 128 => x"681", 129 => x"67a", 130 => x"6dc", 
        131 => x"78d", 132 => x"85d", 133 => x"913", 134 => x"97f", 135 => x"984", 136 => x"920", 137 => x"86e", 138 => x"79e", 139 => x"6e8", 140 => x"67e", 
        141 => x"67c", 142 => x"6e2", 143 => x"796", 144 => x"865", 145 => x"91a", 146 => x"982", 147 => x"982", 148 => x"91a", 149 => x"865", 150 => x"795", 
        151 => x"6e2", 152 => x"67c", 153 => x"67e", 154 => x"6e9", 155 => x"79e", 156 => x"86e", 157 => x"920", 158 => x"984", 159 => x"97f", 160 => x"913", 
        161 => x"85d", 162 => x"78d", 163 => x"6dc", 164 => x"67a", 165 => x"681", 166 => x"6ef", 167 => x"7a6", 168 => x"876", 169 => x"926", 170 => x"986", 
        171 => x"97d", 172 => x"90d", 173 => x"855", 174 => x"785", 175 => x"6d7", 176 => x"678", 177 => x"683", 178 => x"6f5", 179 => x"7af", 180 => x"87e", 
        181 => x"92b", 182 => x"988", 183 => x"97a", 184 => x"907", 185 => x"84c", 186 => x"77d", 187 => x"6d1", 188 => x"677", 189 => x"686", 190 => x"6fc", 
        191 => x"7b7", 192 => x"886", 193 => x"931", 194 => x"989", 195 => x"977", 196 => x"900", 197 => x"844", 198 => x"775", 199 => x"6cb"
    );

    signal test_sample_reg : sample_shift_register := init_sample_shift_register; --registret vi tester imod.
    signal sample_buffer : sample_shift_register := (others=>(others => '0')); --sampleren ADC'en fodrer i
    signal sample_counter : unsigned(15 downto 0) := (others=> '0');

begin

process(sample_ready, clk, start)
    variable summize_temp : unsigned(3*word_size-1 downto 0) := (others=> '0');
    variable xcorr_temp : xcorr_temp_result :=(others=>(others => '0'));
    variable state : xcorr_states := stopped;

    variable clock_at_max_corr : unsigned(15 downto 0) := (others=>'0');
    variable max_corr_score : unsigned(3*word_size-1 downto 0) := (others=> '0');

begin
    if rising_edge(clk) then
        case state is
            when shift =>
                for i in input_size-1 downto 1 loop
                    sample_buffer(i) <= sample_buffer(i-1);
                end loop;
                sample_buffer(0) <= sample;
                
                state := multiply_1;
            when multiply_1 =>
                for i in input_size-1 downto input_size/2 loop
                    xcorr_temp(i) := unsigned(sample_buffer(i))* unsigned(test_sample_reg(i));
                end loop; --ganger det hele sammen og gemmer det i et temp array.
                state := multiply_2;
                
                
            when multiply_2 =>
                for i in (input_size/2)-1 downto 0 loop
                    xcorr_temp(i) := unsigned(sample_buffer(i))* unsigned(test_sample_reg(i));
                end loop; --ganger det hele sammen og gemmer det i et temp array.
                state := summize_1;
                
                
                
            when summize_1 => -- lægger det hele sammen
                summize_temp := (others=>'0'); 
                for i in input_size-1 downto (input_size/2) loop -- vi tæller fra 0 af
                    summize_temp := summize_temp + xcorr_temp(i);
                end loop ;
                state := summize_2;
                
                
            when summize_2 => -- lægger det hele sammen 2
                for i in (input_size/2)-1 downto 0 loop -- vi tæller fra 0 af
                    summize_temp := summize_temp + xcorr_temp(i);
                end loop ;
                state := compare; -- hopper i idle state vi er i mål                
            
            
            
            when compare => -- sammenligner og noterer om vores clock skal huskes

                if(unsigned(max_corr_score) < unsigned(summize_temp)) then
                    clock_at_max_corr := sample_counter;
                    max_corr_score := unsigned(summize_temp);
                end if;
                
                if(unsigned(sample_counter) >= unsigned(samples_to_run)) then --Hvis vi har kørt den tid vi ville så stopper vi
                    state := stopped;
                    TOF_ready <= '1';
                    TOF_out <= std_logic_vector(clock_at_max_corr);
                else
                    state := idle; --Hopper til idle så vi kan køre næste sample
                end if;
                
                
            when idle =>                
                if sample_ready = '1' then
                    sample_counter <= sample_counter + 1;
                    state := shift; --starter svinet
                end if;
            
            
            when stopped =>
                if start = '1' then
                    sample_counter <= (others => '0');
                    max_corr_score := (others => '0');
                    TOF_ready <= '0';
                    xcorr_temp :=(others=>(others => '0'));
                    sample_buffer <= (others=>(others => '0'));
                    state := idle;
                end if; 
            when others =>
        end case;
    end if;
end process;
end Behavioral;