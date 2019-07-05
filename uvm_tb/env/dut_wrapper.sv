module dut_wrapper(spi_if inf);

spi_if inf(


	.reset(inf.reset);
	.sclk(inf.sclk);
	.ss_n(inf.ss_n);
	.mosi(inf.mosi);
	.miso(inf.miso);

);



endmodule
