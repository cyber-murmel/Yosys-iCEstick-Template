module example_tb #(parameter N = 8) ();

reg clk = 0;

wire [5:1] led;
reg [N:1] counter_check = 1;


example #(.N(N))
  ex1 (
    .clk_100mhz(clk),
    .led(led)
);

always 
  #1 clk = ~clk;

//-- Comprobacion del valor del contador
//-- En cada flanco de bajada se comprueba la salida del contador
//-- y se incrementa el valor esperado
always @(negedge clk) begin
  if (counter_check[N:N-4] != led)
	  $display("-->ERROR! Expected: %d. got: %d",counter_check[N:N-4], led);
	counter_check <= counter_check + 1;
end

initial begin
	//$dumpfile("counter_tb.vcd");
	$dumpvars(0, example_tb);
	# 0.5 if (led != 0)
					$display("ERROR! Counter is not 0!");
				else
					$display("Counter initialized. OK.");

	# 600 $display("Finished simulation");
	$finish;
end

endmodule