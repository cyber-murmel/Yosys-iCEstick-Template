module example
#(parameter N_COUNT = 26, N_LEDS = 5)
(input clk_100mhz, output [N_LEDS:1] led);

    prescaler #(
        .N_COUNT(N_COUNT),
        .N_OUT(N_LEDS)
      )
      pres (
        .clk_in(clk_100mhz),
        .clk_out(led)
    );

endmodule 
