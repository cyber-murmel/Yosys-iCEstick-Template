module example_tb;

parameter N = 8;

reg clk = 0;
wire [5:1] led;
reg [N:1] led_check = 1;


example #(.N_COUNT(N))
  ex1 (
    .clk_100mhz(clk),
    .led(led)
);

always begin
  #1 clk = ~clk;
end

always @(negedge clk) begin
  if (led_check[N:N-4] != led)
	  $display("-->ERROR! Expected: %d. got: %d",led_check[N:N-4], led);
	led_check <= led_check + 1;
end

initial begin
	$dumpvars(0, example_tb);
	# 0.5 if (led != 0)
        $display("ERROR! Counter is not 0!");
    else
    $display("Counter initialized. OK.");

	# 600 $display("Finished simulation");
	$finish;
end

endmodule