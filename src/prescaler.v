module prescaler #(parameter N_COUNT = 26,  N_OUT = 5) (input clk_in, output [N_OUT:1]clk_out);

reg [N_COUNT:1] count = 0;
assign clk_out = count[N_COUNT:(N_COUNT-(N_OUT-1))];

always @(posedge clk_in) begin
  count++;
end

endmodule
