module counter #(parameter N_COUNT = 26) (input clk, output [N_COUNT:1] out);

reg [N_COUNT:1] counter = 0;
assign out = counter;

always @(posedge clk) begin
    counter <= counter + 1;
end

endmodule 
