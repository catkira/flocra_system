
`timescale 1 ns / 1 ps

module axis_stemlab_sdr_adc #
(
)
(
  // System signals
  input  wire                        aclk,

  // ADC signals
  output wire                        adc_csn,
  input  wire [15:0]   adc_dat_a,
  input  wire [15:0]   adc_dat_b,

  // Master side
  output wire                        m_axis_a_tvalid,
  output wire [15:0] m_axis_a_tdata,
  output wire                        m_axis_b_tvalid,
  output wire [15:0] m_axis_b_tdata
);
  reg  [15:0] int_dat_a_reg;
  reg  [15:0] int_dat_b_reg;

  always @(posedge aclk)
  begin
    int_dat_a_reg <= adc_dat_a;
    int_dat_b_reg <= adc_dat_b;
  end

  assign adc_csn = 1'b1;

  assign m_axis_a_tvalid = 1'b1;
  assign m_axis_b_tvalid = 1'b1;

  assign m_axis_a_tdata = {{int_dat_a_reg[15]}, ~int_dat_a_reg[14:0]};
  assign m_axis_b_tdata = {{int_dat_b_reg[15]}, ~int_dat_b_reg[14:0]};

endmodule
