module top(input clk_100mhz, output [0:4] led);

reg [25:0] counter = 0;
assign led = counter[25:21];

always @(posedge clk_100mhz) begin
    counter <= counter + 1;
end

endmodule 
