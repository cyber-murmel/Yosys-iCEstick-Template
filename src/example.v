module example #(parameter N = 26) (input clk_100mhz, output [5:1] led);

wire [N:1] arr;
assign led = arr[N:N-4];

counter #(.N_COUNT(N))
  cntr (
    .clk(clk_100mhz),
    .out(arr)
);

endmodule 
