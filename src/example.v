module top(input clk_100mhz, output [4:0] led);

parameter N = 26;

wire [N:1] arr;
assign led = arr[N:N-4];

counter #(.N_COUNT(N))
  PRES (
    .clk(clk_100mhz),
    .out(arr)
);

endmodule 
